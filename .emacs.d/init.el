;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;; リポジトリの追加
(require 'package)
;;MELPA を追加
(add-to-list 'package-archives '("melpa"."https://melpa.org/packages/")t)
(package-initialize)

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
(setq uniquify-ignore-buffer-re "[^*]+")

;; ファイルの開いた位置を保持する
;; (require 'saveplace)
;; (setq-dafault save-place t)
;; (setq save-place-file (concat user-emacs-directory "places")

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-delay 0.125)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; cooding set
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; バックアップファイ及び、自動セーブの無効
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;; メニューバー、ツールバー、スクロールバーの非表示
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; emacs-mozc
(set-language-environment 'Japanese)
(require 'mozc)
(setq default-input-method "Japanese-mozc")
(global-set-key (kbd "C-c j") 'mozc-mode)

;; keymap change
;; C-m : 改行プラスインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;;C-h : backspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; C-x ? : help
(define-key global-map (kbd "C-x ?") 'help-command)
;; C-t : ウィンドウ間の移動 (元 transpose-chars)
(define-key global-map (kbd "C-t") 'other-window)

;;折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; ddskk のキーバインド

;;(global-set-key (kbd "C-c C-j") 'skk-mode)

;; 文字コードセット
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; 行番号を表示(軽量化あり)
(global-linum-mode t)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; 列番号表示
(column-number-mode t)

;; タイトルバーにフルパス表示
(setq frame-title-format "%f")

;;スペース、タブなどを可視化する
(global-whitespace-mode 1)

;; カーソル行をハイライトする
(global-hl-line-mode nil)
;; (blink-cursor-mode 1)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; 起動時に*scratch*バッファを表示する
(setq initial-buffer-choice t)

;; 高速起動用のミニマムメジャーモードを適用
;; (defun buffer-mode ()
;;   "Buffer Mode"
;;   (interactive)
;;   (setq mode-name "Buffer")
;;   (setq major-mode 'buffer-mode')
;;   (run-hooks 'buffer-mode-hook))

;; beep音を消す
(setq ring-bell-function 'ignore)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)
1
;; ウィンドウ内に収まらないときだけ格好内も光らせる
(setq show-paren-style 'mixed)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; コピーを使い安くする
(setq dired-dwim-target t)

;; スクロールを一行ずつにする
(setq scroll-step 1)

;; バッファの最後でnewlineで新規行を追加するのを禁止する
;; (setq next-line-add-newlines nil)

;; スマートなウィンドウ切り替え
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;eww の設定
;; 検索エンジンの変更
;; (setq eww-sarch-prefix "https://www.google.co.jp/search?btnl&q=")
(require 'eww)
(defun eww-disable-images()
  "ewwで画像は表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-image()
  "ewwで画像を表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt&optional flags)
  (insert alt))

(provide 'mylisp-eww-image)

(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

;; テーマの設定
(load-theme 'misterioso)

;; diredの設定
;; ２画面ファイラー
(setq dired-dwim-target t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ddskk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

