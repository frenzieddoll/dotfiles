;;; init-system.el --- setting for emacs's system
;;; Commentary:

;;; Code:
;; 日本語設定
;; 文字コードセット
;; (prefer-coding-system 'utf-8)
(set-language-environment 'japanese)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; splash screen を無効化
(setq inhibit-splash-screen t)

;; 同じ内容を履歴に記録しない
(setq history-delete-duplicates t)

;; 複数のディレクトリで同じファイル名のファイルを開いたときのバッファ名を調整する
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(defvar uniquify-ignore-buffer-re "[^*]+")

;; ファイルの開いた位置を保持する
;; (require 'saveplace)
;; (setq-dafault save-place t)
;; (setq save-place-file (concat user-emacs-directory "places")

;; 対応する括弧を光らせる
(show-paren-mode 1)
(defvar show-paren-delay 0.125)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; cooding set
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; 時計を表示
(display-time)
(setq display-time-string-forms
 '((format "%s/%s(%s)%s:%s"
		 month day dayname
		 24-hours minutes
   )))

;; バックアップファイ及び、自動セーブの無効
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;; メニューバー、ツールバー、スクロールバーの非表示
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; フォント
;; (set-default-font "SourceHanCodeJP R")
;; (set-frame-font "Ricty" 15)
;; (set-face-attribute 'default nil
;;                     :family "Ricty"
;;                     :height 170)


;; デスクトップPCでのみフォントサイズを変更する
(if (string-match system-name "archlinuxhonda")

    (set-face-attribute 'default nil
                        :family "Hackgen"
                        :height 170)

  (set-face-attribute 'default nil
                      :family "Hackgen"
                      :height 100))



;; (when (eq system-type 'gnu/linux)
;;   (set-face-attribute 'default nil
;;                       :family "Hackgen"
;;                       :height 170))


;; (when (eq system-type 'darwin)
;;   (global-set-key [s-mouse-1] 'browse-url-at-mouse)
;;   (let* ((size 14)
;; 	 (jpfont "Hiragino Maru Gothic ProN")
;; 	 (asciifont "Monaco")
;; 	 (h (* size 10)))
;;     (set-face-attribute 'default nil :family asciifont :height h)
;;     (set-fontset-font t 'katakana-jisx0201 jpfont)
;;     (set-fontset-font t 'japanese-jisx0208 jpfont)
;;     (set-fontset-font t 'japanese-jisx0212 jpfont)
;;     (set-fontset-font t 'japanese-jisx0213-1 jpfont)
;;     (set-fontset-font t 'japanese-jisx0213-2 jpfont)
;;     (set-fontset-font t '(#x0080 . #x024F) asciifont))
;;   (setq face-font-rescale-alist
;; 	'(("^-apple-hiragino.*" . 1.2)
;; 	  (".*-Hiragino Maru Gothic ProN-.*" . 1.2)
;; 	  (".*osaka-bold.*" . 1.2)
;; 	  (".*osaka-medium.*" . 1.2)
;; 	  (".*courier-bold-.*-mac-roman" . 1.0)
;; 	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;; 	  (".*monaco-bold-.*-mac-roman" . 0.9)
;; 	  ("-cdac$" . 1.3)))
;;   ;; C-x 5 2 で新しいフレームを作ったときに同じフォントを使う
;;   (setq frame-inherited-parameters '(font tool-bar-lines)))

;; 列番号表示
(column-number-mode t)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; 起動時に*scratch*バッファを表示する
(setq initial-buffer-choice t)
(setq initial-scratch-message "")

;; beep音を消す
(setq ring-bell-function 'ignore)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)
;; ウィンドウ内に収まらないときだけ格好内も光らせる
;; (setq show-paren-style 'mixed)
;; カーソルの点滅をやめる
(blink-cursor-mode 0)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)
;; 保存時に行末のスペースを削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; auto-fill-modeを切る
(auto-fill-mode 0)

;; yes or noをy,nにする
(fset 'yes-or-no-p 'y-or-n-p)

;; 補完で大文字小文字無視
(setq read-file-name-completion-ignore-case t)

;; 括弧をカラフルに
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;; 選択範囲の色
(set-face-background 'region "#555")

;; ミニバッファの履歴を保存する
(savehist-mode 1)
(setq history-length 30000)

;; root権限で開き直す
(defun reopen-with-sudo ()
  "Reopen current buffer-file with sudo using tramp."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "Cannot get a file name"))))

;; pathを引き継ぐ
(when (require 'exec-path-from-shell nil t)
  (exec-path-from-shell-initialize))

;; 折り返し禁止
(setq-default truncate-lines t)

;; マウスイベントの無効
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

;; パスを引き継ぐ
(exec-path-from-shell-initialize)
;;; init-system.el ends here
