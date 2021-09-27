;; multipart-decode.el -- Multipart Decode.
;; Copyright (C) 2018 fubuki
;; @(#)$Revision: 1.3 $

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

;; When executed in the mail buffer, the buffer is decoded into human readable form.
;; Wherever the cursor at the start is located,
;; it covers from the beginning to the end of the buffer.

;;; Installation:

;; (require 'mew-search-with-builtin)

;;; Code:

(defgroup multipart-decode nil
  "Multipart decode."
  :group 'mew
  :version "26.1"
  :prefix "mpd-")

(defcustom mpd-multipart-regexp
  "^Content-Type: \\(?1:multipart/\\(?:alternative;\\|mixed;\\|related;\\|report;\\)\\).*\n?.+\n?.*boundary=\"?\\(?2:[^\"\n]+\\)\"?"
  "Content-Type Multipart header."
  :type  'regexp
  :group 'multipart-decode)

(defcustom mpd-text-regexp
  "^Content-Type: \\(?1:\\(?:text\\|message\\)/\\(?:plain\\|html\\|rfc822\\)\\)\\(?:\\(?:;\\|;\n\\).*charset=\"?\\(?2:[^;\"\n]+\\)\"?\\)?"
  "Content-Type Type header."
  :type  'regexp
  :group 'multipart-decode)


(defcustom  mpd-enco-regexp
  "^Content-Transfer-Encoding: \\(?1:.+\\)$"
  "Content-Type Concoding type header."
  :type  'regexp
  :group 'multipart-decode)

(defcustom mpd-decode-function-alist
  '(("base64"           . base64-decode-string)
    ("B"                . base64-decode-string)
    ("quoted-printable" . quoted-printable-decode-string)
    ("Q"                . quoted-printable-decode-string))
  "Decode function Symbol alist."
  :type  '(repeat (cons string function))
  :group 'multipart-decode)

(defcustom mpd-regular-alist
  '((shift-jis       . shift_jis)
    (cp-850          . cp437)
    (cp-1252         . iso-8859-1)
    (134             . gb2312)
    (ansi_x3\.4-1968 . utf-8))
  "ほぼ spam にしか現われないので設定しなくても問題ない."
  :type  '(repeat (cons (choice symbol number) coding-system))
  :group 'multipart-decode)

;; 以下の macro の各要素の番号は `mpd-content-type' の戻り値が基準
(defmacro mpd-type-type (contents)
  `(elt ,contents 0))

(defmacro mpd-type-boundary (contents)
  `(elt ,contents 1))

(defmacro mpd-type-char (contents)
  `(elt ,contents 2))

(defmacro mpd-type-enco (contents)
  `(elt ,contents 3))

(defmacro mpd-type-beg (contents)
  `(elt ,contents 4))

(defmacro mpd-type-end (contents)
  `(elt ,contents 5))

(defmacro mpd-type-set-beg (contents val)
  `(aset ,contents 4 ,val))

(defmacro mpd-type-set-end (contents val)
  `(aset ,contents 5 ,val))

(defvar mpd-subject-list '("^From:" "^To:" "^Subject:" "^Cc:"))

(defun multipart-decode (&optional buffer)
  "buffer の encode 部分等を展開する.
シングルパート/マルチパート の base64 quoted-printable のプレーン text と html に対応.
zip jpg pdf 等のバイナリは誤マッチ防止のため残さないで削除します."
  (interactive)
  (let (boundary match)
    (save-excursion
      (with-current-buffer (or buffer (current-buffer))
        (goto-char (point-min))
        (dolist (subj mpd-subject-list)
          (mpd-subject-decode subj))
        (setq boundary (and (re-search-forward mpd-multipart-regexp nil t) (match-string 2)))
        (cond
         (boundary
          (mpd-multipart-buffer-decode boundary))
         (t
          (mpd-single-buffer-decode mpd-text-regexp)))))))

(defun mpd-regular (string)
  "STRING を intern して symbol にして返し、数字文字列なら数値にして返す.
但し連想リスト `mpd-regular-alist' に置換するシンボルが設定されていればそれを返す."
  (let ((num (string-to-number string))
        (sym (intern (downcase string))))
    (or (cdr (assq (if (zerop num) sym num) mpd-regular-alist)) sym)))

(defun mpd-content-type ()
  "開始ポイントは \"boundary\" Search 直後に在ると想定し、
直後に続く \"Content-Type: \" 行のパラメータをベクター(並びは返り値の通り)にして返す.
対応しているのは変数 `mpd-multipart-regexp' `mpd-text-regexp' `mpd-enco-regexp'
に設定されたもの.
終了時のポイントは \"Content-Type: \" 行の後のそれ以外の行の行頭に在る."
  (let (type boundary char encoding beg end)
    (catch 'break
      (while (zerop (forward-line))
        (cond
         ((looking-at mpd-multipart-regexp)
          (setq type     (match-string 1)
                boundary (match-string 2))
          (goto-char (match-end 0)))

         ((looking-at mpd-text-regexp)
          (setq type   (match-string 1)
                char (if (match-string 2)
                         (mpd-regular (match-string 2))
                       'utf-8))
          (goto-char (match-end 0)))

         ((looking-at mpd-enco-regexp)
          (setq encoding (downcase (match-string 1)))
          (goto-char (match-end 0)))

         ((not (looking-at "^\n"))
          (end-of-line))

         (t
          (throw 'break nil)))))
    (vector type boundary char encoding beg end)))

(defun mpd-subject-decode (subject)
  "Message buffer 内の `mpd-subject-list' の中のキーワード箇所が
エンコードされていれば当該コードにデコードして差し替える.
デコードすればその文字列を返し、デコードが発生しなければ NIL を返す."
  (let (beg end string non-ascii)
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward subject nil t)
        (setq beg (point))

        (catch 'break
          (while (not (eobp))
            (cond
             ((eolp)
              (forward-line))
             ((looking-at "[ \t]+\"?=\\?\\(?1:[^?]+\\)\\?\\(?2:.\\)\\?\\(?3:[^?]+\\)\\?=\"?")
              (let* ((code (mpd-regular (match-string 1)))
                     (enco (match-string 2))
                     (subj (match-string 3))
                     (func (cdr (assoc (upcase enco) mpd-decode-function-alist))))
                (setq non-ascii t)
                (setq end  (match-end 0))
                (setq string
                      (concat
                       string
                       (decode-coding-string (funcall func subj) code)))
                (goto-char end)))
             ((looking-at "\\(?1:[ \t]\\)\\(?2:[^ \n]+\\)")
              (setq end  (match-end 0))
              (setq string (concat string (match-string 1) (match-string 2)))
              (goto-char end))
             (t
              (throw 'break nil)))))

        (when non-ascii
          (delete-region beg (progn (goto-char end) (point)))
          (insert " " string))
        string))))

(defun mpd-multipart-buffer-decode (boundary)
  "`multipart-decode' の実体. 再帰でループする."
  (let (types beg)
    (while (search-forward boundary nil t) ; メタ文字が使われている場合があるので普通のサーチ
      (setq types (mpd-content-type))
      (and
       (or
        (mpd-type-type types)
        (mpd-type-char types)
        (mpd-type-boundary types)
        (mpd-type-enco types))
       (cond
        ((mpd-type-boundary types)
         (mpd-multipart-buffer-decode (mpd-type-boundary types)))
        ((or (string-match "rfc822" (or (mpd-type-type types) ""))
             (assoc (mpd-type-enco types) mpd-decode-function-alist))
         (mpd-decode-body boundary types)))))))

(defun mpd-single-buffer-decode (regexp) ; mpd-text-regexp
  "非マルチパートの場合のヘッダの掴み."
  (let (type code enco)
    (save-excursion
      (when (re-search-forward regexp nil t)
        (setq type (match-string 1))
        (setq code
              (if (match-string 4)
                  (intern (downcase (match-string 4)))
                nil)))

      (unless code
        (goto-char (point-min))
        (when (re-search-forward mpd-text-regexp nil t)
          (setq code (mpd-regular (or (match-string 2) "utf-8")))))

      (goto-char (point-min)) ; 順不動なので仕切り直す
      (when (re-search-forward mpd-enco-regexp nil t)
        (setq enco (match-string 1)))

      (when (assoc enco mpd-decode-function-alist)
        ;; 次の関数の為にポントを本文に合わせておく
        (if (re-search-forward "\n\n" nil t) (end-of-line 0))
        (mpd-decode-body nil (vector type nil code enco nil nil))))))

(defun mpd-decode-body (boundary types)
  "デコーダ本体.
現在ポイントの次の行から BOUNDARY の 1行上の行末までを
変数 `mpd-decode-function-alist' の中の ENCO に対応した関数で
CODE にデコードしたものと差替える.
BOUNDARY が NIL だとバッファエンドまでが対象となる.
但し base64 の場合はその後にテキストのあるケースがあった為連続改行までとする.
Decode の必要の無いプレーンテキスト等の場合差替は発生せずカーソルだけが移動する.
`types' の中にも `boundary' はあるが次の `boundary' や
NIL である可能性もあるので個別になっている."
  (let ((func (cdr (assoc (mpd-type-enco types) mpd-decode-function-alist)))
        string)
    (forward-line)
    (mpd-type-set-beg types (point))

    (cond
     ;; Single Part 切出しポイントゲット
     ((null boundary)
      (if (string-equal (mpd-type-enco types) "base64")
          (or (prog1 (search-forward "\n\n" nil t) (backward-char))
              (goto-char (point-max)))
        (goto-char (point-max))))
     ;; Multi Part 切出しポイントゲット
     ((search-forward boundary nil t)
      (end-of-line 0))
     (t
      (goto-char (point-max))))

    (mpd-type-set-end types (point))

    ;; 差替本体 仮に関数化する場合に備えて分離しやすくしてある
    (let ((beg (mpd-type-beg types))
          (end (mpd-type-end types)))
      (cond
       ((string-match "rfc822" (or (mpd-type-type types) ""))
        (let ((string (buffer-substring beg end)))
          (setq string
                (with-temp-buffer
                  (insert string)
                  (multipart-decode) ; 更に再帰
                  (buffer-string)))
          (delete-region beg end)
          (insert string)))
       ((not (string-match "text\\|html" (or (mpd-type-type types) "")))
        (delete-region beg end))
       (t
        (setq string
              (decode-coding-string
               (funcall func (buffer-substring beg end))
               (mpd-type-char types)))
        (delete-region beg end)
        (insert string))))))

(provide 'multipart-decode)
;; fine.
