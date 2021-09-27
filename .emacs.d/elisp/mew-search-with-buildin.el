;;; mew-search-with-builtin.el -- Mew Builtin Search.
;; Copyright (C) 2018 fubuki

;; Author: fubuki@*****.org
;; Keywords: tools

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Mew Builtin Search.

;;; Installation:

;; (require 'mew-search-with-builtin)

;;; Code:

(require 'mew)
(require 'qp)               ; quoted-printable liblary.
(require 'multipart-decode) ; base64 quoted-printable 部分をインライン展開

(defgroup mew-builtin-search nil
  "Mew Builtin Search."
  :group   'mew
  :version "26.1"
  :prefix  "mbs-")

;; `mew-search-method' が nil なら 'builtin に設定.
(and
 (boundp 'mew-search-method)
 (null mew-search-method)
 (setq mew-search-method 'builtin))

(defcustom mbs-builtin t
  "NIL なら `mew-prog-grep' が使われる."
  :type  'boolean
  :group 'mew-builtin-search)

(defcustom mbs-case-fold-search case-fold-search
  "Mew Builtin Search default case."
   :type  'boolean
   :group 'mew-builtin-search)

(defcustom mbs-match-function 'mbs-first-match
  "検索に使う 3つの引数を取る関数です.
マッチしたら非NIL を返し、しなければ NIL を返します.
(func regexp message-file case)"
  :type  'function
  :group 'mew-builtin-search)

(defcustom mbs-progress-threshold 400
  "サーチする Folder にこの数値以上のファイル数があれば経過割合を表示."
   :type  'integer
   :group 'mew-builtin-search)

(defmacro mbs-progress (all cnt)
  `(/ (* (- ,all ,cnt) 100) ,all))

(defmacro mbs-progress-message (all cnt msg file)
  "MSG は %s %d をこの順序で持った文字列.
%s に FILE が入り %d に ALL(総数) CNT(残数) の計算結果が入る."
  `(and (< mbs-progress-threshold ,all)
        (zerop (% (mbs-progress ,all ,cnt) 5))
        (let (message-log-max)
          (message ,msg ,file (mbs-progress ,all ,cnt)))))

(defcustom mbs-mew-pick-field-list
  '("^to: .*" "^cc: .*" "^subject: .*" "^dcc: .*" "^fcc: .*" "^bcc: .*" "^date: .*"
    "^reply-to: .*" "^followup-to: .*" "^from: .*" "^newsgroups: .*" "^content-.*")
  "Mew の補完リスト `mew-pick-field-list' に付け足す補完リスト.
不要なら nil にしておく."
  :type  '(repeat string)
  :group 'mew-builtin-search)

(if mbs-mew-pick-field-list
    (setq mew-pick-field-list (append mew-pick-field-list mbs-mew-pick-field-list)))

;; 検索キーに SPACE や正規表現 `?' も使えるようにする措置
;; デフォルトでは補完になっていて入力できないが補完は C-i 等でもできる
(add-hook 'mew-init-hook
          #'(lambda ()
              (define-key mew-input-map " " nil)
              (define-key mew-input-map "?" nil)
              (define-key mew-input-map "\M-c"  'mbs-toggle-case-fold-search)))

;; Original function wrapper part.

(defun mew-summary-pick-with-grep-wrap (func prog opts pattern folder src-msgs)
  "for MARK. 変数 `mbs-builtin' が NON-NIL ならアクティブ."
  (if (null mbs-builtin)
      (funcall func prog opts pattern folder src-msgs)
    (mew-summary-pick-with-builtin pattern folder src-msgs)))

(defun mew-summary-selection-by-pick-with-grep1-wrap (func prog opts pattern folder msgs)
  "for SELECTION. 変数 `mbs-builtin' が NON-NIL ならアクティブ."
  (if (null mbs-builtin)
      (funcall func prog opts pattern folder msgs)
    (mew-summary-selection-by-pick-with-builtin pattern folder msgs)))

(defun mew-pick-canonicalize-pattern-wrap (func pattern)
  "字句解析をスキップさせるラッパー."
  (if (null mbs-builtin)
      (funcall func pattern)
    pattern))

(defun mbs-toggle-case-fold-search ()
  "Builtin search ignore case toggle."
  (interactive)
  (setq mbs-case-fold-search (not mbs-case-fold-search))
  (message "mbs-case-fold-search: %s"
           (if mbs-case-fold-search "CASE INSENSITIVE." "Case sensitive.")))

;; (add-hook 'mew-summary-mode-hook
;;           #'(lambda ()
;;               (local-set-key "z\C-i" 'mbs-toggle-case-fold-search)
;;               (local-set-key "k\C-i" 'mbs-toggle-case-fold-search)))

;; Folder search part.

;; For MARK.
(defun mew-summary-pick-with-builtin (regexp folder src-msgs)
  "A function to pick messages matching REGEXP.
注意: SRC-MCGS は拡張子があるが返値 MSGS は拡張子があると動作しないので
この関数の中で拡張子を除去しないといけいない."
  (let* ((dir (mew-expand-folder folder))
	 (default-directory dir) ;; buffer local
         (case mbs-case-fold-search)
         (all (length src-msgs))
         (cnt all)
         msgs)
    (cd dir)
    (mbs-upush regexp)
    (dolist (message src-msgs)
      (let ((match (funcall mbs-match-function regexp message case)))
        (mbs-progress-message all cnt "Scan message %s...%d%%" folder)
        (if match
            (setq msgs (cons (file-name-sans-extension message) msgs))))
      (setq cnt (1- cnt)))
    (sort msgs #'(lambda (a b) (< (string-to-number a) (string-to-number b))))))

;; For SELECTION.
(defun mew-summary-selection-by-pick-with-builtin (regexp folder msgs)
  "FOLDER の MSGS から REGEXP をサーチしてセレクションを作る."
  (let* ((dir (mew-expand-folder folder))
	 (file (mew-make-temp-name))
	 (rttl 0)
         (case mbs-case-fold-search)
         (all (length msgs))
         (cnt all)
         result-msgs)

    (cd dir)
    (mbs-upush regexp 'clear) ; 仕切り直しなので履歴はクリア
    (dolist (message msgs)
      (let ((match (funcall mbs-match-function regexp message case)))
        (mbs-progress-message all cnt "Scan message %s...%d%%" folder)
        (if match
            (setq result-msgs (cons (file-name-sans-extension message) result-msgs))))
      (setq cnt (1- cnt)))
    (setq result-msgs
          (sort result-msgs #'(lambda (a b) (< (string-to-number a) (string-to-number b)))))

    (with-temp-buffer
      (setq rttl (length result-msgs))
      (insert "CD: " folder "\n")
      (mapc (lambda (x) (insert (mew-msg-get-filename x) "\n")) result-msgs)
      (mew-frwlet mew-cs-text-for-read mew-cs-text-for-write
	(write-region (point-min) (point-max) file nil 'no-msg))
      (list file rttl))))

(defcustom mbs-pattern-tail-empty t
  "パターンの末尾が \"\\|\" ならエラーで停止させる.
そのまま実行すると総てのメッセージにマッチしてその数が多すぎるとフリーズしてしまうことがある."
  :type 'boolean
  :group 'mew-builtin-search)

;; Search Core.
(defun mbs-first-match (regexp file &optional case)
  "FILE 内に REGEXP にマッチする箇所がひとつでもあればそれを返し、さもなければ NIL を返す.
但し Decode に失敗したファイルはエラーメッセージを表示しサーチは行なわれず NIL を返す."
  (and mbs-pattern-tail-empty (string-match "\\\\|\\'" regexp)
       (error "`%s' 空文字が含まれている可能性があります" regexp))
  (with-temp-buffer
    (let ((case-fold-search (or case mbs-case-fold-search))
          ;; ↓Mew 環境実行の場合これが無いとデコードで化けるケースが在り正しくマッチできない
          (coding-system-for-read nil))
      (insert-file-contents file)
      (goto-char (point-min))
      (if (condition-case err
              (multipart-decode)
            (error (message "%s: %s" file (error-message-string err))))
          nil
        (catch 'break
          (while (re-search-forward regexp nil t)
            (throw 'break (match-string 0))))))))

(advice-add 'mew-pick-canonicalize-pattern :around 'mew-pick-canonicalize-pattern-wrap)
(advice-add 'mew-summary-pick-with-grep :around 'mew-summary-pick-with-grep-wrap)
(advice-add 'mew-summary-selection-by-pick-with-grep1
            :around 'mew-summary-selection-by-pick-with-grep1-wrap)

;; Match Hilight part.

(defface mbs-match-1
  '((((background light))
     :foreground "black" :background "yellow" :weight bold)
    (((background dark))
     :foreground "black" :background "#ffffaa" :weight bold)
    (t :weight bold))
  "Mew builtin search matched highlight 1.")
(defvar mbs-match-1 'mbs-match-1)

(defface mbs-match-2
  '((((background light))
     :foreground "black" :background "palegreen" :weight bold)
    (((background dark))
     :foreground "black" :background "#ddffdd" :weight bold)
    (t :weight bold))
  "Mew builtin search matched highlight 2.")
(defvar mbs-match-2 'mbs-match-2)

(defface mbs-match-3
  '((((background light))
     :foreground "black" :background "lightskyblue" :weight bold)
    (((background dark))
     :foreground "black" :background "#cfdeee" :weight bold)
    (t :weight bold))
  "Mew builtin search matched highlight 3.")
(defvar mbs-match-3 'mbs-match-3)

(defface mbs-match-4
  '((((background light))
    :foreground "black" :background "hotpink" :weight bold)
   (((background dark))
    :foreground "black" :background "#ffdddd" :weight bold)
   (t :weight bold))
  "Mew builtin search matched highlight 4.")
(defvar mbs-match-4 'mbs-match-4)

(defcustom mbs-face-list '(mbs-match-1 mbs-match-2 mbs-match-3 mbs-match-4)
  "Mew Builtin Search Matched Highlight face cycle list."
  :type  '(repeat face)
  :group 'mew-builtin-search)

(defvar mbs-key        nil "Search word stack work.")
(defvar mbs-face-point nil "Work value.")
(defvar mbs-overlay    nil "Matched overlay stack work.")

(defun mbs-upush (key &optional clear)
  "`mbs-key' に KEY が無ければ push. CLEAR が非-NIL なら `mbs-key' をクリアして push."
  (cond
   (clear
    (setq mbs-key (cons (cons key (car mbs-face-list)) nil)))
   ((not (assoc key mbs-key))
    (setq mbs-key (cons (cons key (mbs-inc-face)) mbs-key))))
  mbs-key)

(defun mbs-inc-face ()
  "`mbs-face-point' をひとつ進めて car を返す.
NIL になると `mbs-face-list' がセットされる. "
  (car (setq mbs-face-point (or (cdr mbs-face-point) mbs-face-list))))

(defun mbs-match-highlight (&optional alist)
  "ALIST は (KEY . FACE) の alist.
buffer 内の KEY にマッチした文字列すべてを FACE でハイライト表示."
  (let ((list (or alist mbs-key)))
    (save-excursion
      (dolist (key list)
        (goto-char (point-min))
        (while (re-search-forward (car key) nil t)
          (setq mbs-overlay (cons (make-overlay (match-beginning 0) (match-end 0)) mbs-overlay))
          (overlay-put (car mbs-overlay) 'face (cdr key)))))))

(defun mbs-delte-overlay ()
  (dolist (ov mbs-overlay) (delete-overlay ov))
  (setq mbs-overlay    nil
        mbs-face-point nil
        mbs-key        nil))

(defun mew-summary-display-postscript-wrap (func &rest args)
  (mbs-match-highlight)
  (apply func args))

(advice-add 'mew-summary-undo-all :after 'mbs-delte-overlay)

;; `,' を押して表示される html source 等の生バッファでもマッチハイライト(overlay)が効きます.
;; 生表示用バッファでは mew-message-hook が効かない(ように敢えてしてある)ための措置ですが
;; 何か理由があってのことだと思いますが具体的な理由が判らないため、
;; 問題があった場合の為に変数で切れるようにしてあります.
;; この機能を切りたい場合は .mew.el や init.el 等に以下の1文を加えてください.
;; (setq mbs-highlight-func-asis nil)

(defvar mbs-highlight-func-asis t "*生バッファのハイライトをアクティブにするか?")
(if mbs-highlight-func-asis
    (advice-add 'mew-summary-display-postscript :around 'mew-summary-display-postscript-wrap))

(defun mbs-remove-highlight-function()
  (interactive)
  (advice-remove 'mew-summary-display-postscript 'mew-summary-display-postscript-wrap))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Mew Builtin Search
;;;

(setq mew-search-switch
      (cons
       '(builtin "Builtin" nil
                 mew-search-with-builtin
                 mew-search-virtual-with-builtin
                 nil nil nil nil nil)
       mew-search-switch))

(defmacro mbs-dot-directory-p (file)
  `(or (string-match "/\\.$"    ,file)
       (string-match "/\\.\\.$" ,file)))

;; queue
(defcustom mbs-ignore-directory-list '("\\(trash\\|draft\\|backup\\)")
  "*除外したいディレクトリの正規表現の list."
  :type  '(repeat regexp)
  :group 'mew-builtin-search)

(defvar mbs-mew-message-file-name (concat "[0-9]+\\" mew-suffix "\\'"))

(defun mbs-ignore-directory (file)
  (dolist (r mbs-ignore-directory-list)
    (if (string-match r file)
        (return t))))

(defun mbs-path-to-mew-folder (path)
  (string-match (concat (mew-expand-folder mew-folder-local) "/") path)
  (directory-file-name (file-name-directory (replace-match "" 'fixed-case nil path))))

(defun mbs-file-only-length (list)
  (let ((c 0))
    (dolist (f list c)
      (if (string-match "^CD:" f)
          nil
        (setq c (1+ c))))))

(defun mew-search-with-builtin (regexp folder &optional _dummy)
  "A function to pick messages matching REGEXP.
注意: この関数の中で返り値の拡張子を除去しないといけいない."
  (let* ((files (directory-files (mew-expand-folder folder) nil mbs-mew-message-file-name))
         (case mbs-case-fold-search)
         (all (length files))
         (cnt all)
         msgs)
    (mbs-upush regexp)
    (dolist (message files)
      (let ((match (funcall mbs-match-function regexp message case)))
        (mbs-progress-message all cnt "Scan message %-8s %d%%..." folder)
        (if match
            (setq msgs (cons (file-name-sans-extension message) msgs))))
      (setq cnt (1- cnt)))
    (sort msgs #'(lambda (a b) (< (string-to-number a) (string-to-number b))))))

(defun mbs-sort (list)
  "\"c:/foo/1.mew\" \"c:/foo/11.mew\" \"c:/foo/2.mew\" ...
等の文字列リストを数値として(逆順)ソート.
数値文字列でなくてもエラーにならず 0 になるの問題はない."
  (sort
   list
   #'(lambda (a b)
       (> (string-to-number (file-name-nondirectory (file-name-sans-extension a)))
          (string-to-number (file-name-nondirectory (file-name-sans-extension b)))))))

(defun mew--search-virtual-with-builtin (regexp path &optional _dummy)
  "PATH の中を再帰的に降りて集めた `mbs-mew-message-file-name' から
REGEXP にマッチする内容を持つファイルの list を \"CD:\" 付で返す.
PATH が atom なら `directory-files' に渡して file の list にし
list ならそのまま file list として処理をする.
`current-prefix-arg' が nil なら
`mbs-ignore-directory-list' で指定された ディレクトリは除外される."
  (let* ((files (if (consp path) path (directory-files path t)))
         (all (length files))
         (count all)
         (case mbs-case-fold-search)
         (prefix current-prefix-arg)
         chdir result att temp)
    (message "Scan directory %s..." path)
    (dolist (file files)
      (setq att (file-attributes file))
      (mbs-progress-message all count "Scan directory %s...%d%%" path)
      (cond
       ((null att)
        (message "File can't open %s." file))
       ((and (car att)
             (not (mbs-dot-directory-p file))
             (string-equal "drwxrwxrwx" (nth 8 att))
             (or prefix (not (mbs-ignore-directory file))))
        (setq result (append (mew--search-virtual-with-builtin regexp file) result)))
       ((string-match mbs-mew-message-file-name file)
        (when (funcall mbs-match-function regexp file case)
          (or chdir
              (setq chdir
                    (cons (concat "CD:" mew-folder-local (mbs-path-to-mew-folder file)) nil)))
          (setq temp (cons (concat (file-name-nondirectory file)) temp)))))
      (setq count (1- count)))
    (setq result (append (mbs-sort temp) chdir result))))

(defun mbs-split-arg-to-path (folder)
  (if (consp folder)
      (mapcar #'(lambda(f) (mew-expand-folder f)) folder)
    (mew-expand-folder folder)))

(defun mew-search-virtual-with-builtin (regexp flds &optional _dummy)
  (let* ((path (mbs-split-arg-to-path (or flds mew-folder-local))) ;; "~/Mail" 取得
	 (file (mew-make-temp-name))
         (msgs (nreverse (mew--search-virtual-with-builtin regexp path))))
    (mbs-upush regexp 'clear)  ; 仕切り直しなので履歴はクリア
    (insert (mapconcat #'identity msgs "\n"))
    (mew-frwlet mew-cs-text-for-read mew-cs-text-for-write
      (write-region (point-min) (point-max) file nil 'no-msg))
    (list file (mbs-file-only-length msgs))))

(provide 'mew-search-with-builtin)
;; fine.
