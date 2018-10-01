;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; ロードパスの設定
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

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

;; migemo
(require 'migemo)
;; (when (and (executable-find "cmigemo")
;;            (require 'migemo nil t))
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
;; 辞書ファイル
(setq migemo-dictionary "/usr/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dicitonary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)


;; ddskk のキーバインド
;; (require 'skk)
;; (global-set-key (kbd "C-c C-j") 'skk-mode)
;; skkの設定
;; (when (require 'skk nil t)
;;   (global-set-key (kbd "C-c j") 'skk-auto-fill-mode) ;;良い感じに改行を自動入力してくれる機能
;;   (setq default-input-method "japanese-skk")         ;;emacs上での日本語入力にskkをつかう
;;   (require 'skk-study))

;; keymap change
;; C-m : 改行プラスインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;;C-h : backspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; C-x ? : help
(define-key global-map (kbd "C-x ?") 'help-command)
;; C-t : ウィンドウ間の移動 (元 transpose-chars)
;; (define-key global-map (kbd "C-t") 'other-window)
;;折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; 文字コードセット

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

;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

;; スマートなウィンドウ切り替え
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings);
(global-set-key (kbd "C-c n") 'windmove-down)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c p") 'windmove-up)
(setq windmove-wrap-around t)

;; ウィンドウのサイズ変更
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?n)
               (enlarge-window dy))
              ((= c ?p)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

;; ウィンドウサイズの変更のキーバインド
(global-set-key (kbd "C-c r") 'window-resizer)

;; 補完で大文字小文字無視
(setq read-file-name-completion-ignore-case t)

;; set alpha
(add-to-list 'default-frame-alist '(alpha . 80))

;; set font and screen
;; (progn
;;   ;; 文字の色を設定します。
;;   (add-to-list 'default-frame-alist '(foreground-color . "azure1"))
;;   ;; 背景色を設定します。
;;   (add-to-list 'default-frame-alist '(background-color . "black"))
;;   ;; カーソルの色を設定します。
;;   (add-to-list 'default-frame-alist '(cursor-color . "green"))
;;   ;; マウスポインタの色を設定します。
;;   (add-to-list 'default-frame-alist '(mouse-color . "green"))
;;   ;; モードラインの文字の色を設定します。
;;   (set-face-foreground 'modeline "white")
;;   ;; モードラインの背景色を設定します。
;;   (set-face-background 'modeline "DimGrey")
;;   ;; 選択中のリージョンの色を設定します。
;;   (set-face-background 'region "Blue")
;;   ;; モードライン（アクティブでないバッファ）の文字色を設定します。
;;   (set-face-foreground 'mode-line-inactive "gray30")
;;   ;; モードライン（アクティブでないバッファ）の背景色を設定します。
;;   (set-face-background 'mode-line-inactive "gray85")
;; )

;;eww の設定
;; --------------------------------------------------------------------------------------
;; 検索エンジンの変更
(setq eww-search-prefix "https://www.google.co.jp/search?btnl&q=")
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
;; デフォルトで画像を表示させない
(provide 'mylisp-eww-image)
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

;; 外部ブラウザで開く
(setq eww-browse-with-external-link t)

;; 現在のurlをewwで開く
(defun browse-url-with-eww ()
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    ;; url
    (if url-region
      (eww-browse-url (buffer-substring-no-properties (car url-region)
                              (cdr url-region))))
    ;; org-link
    (setq browse-url-browser-function 'eww-browse-url)
    (org-open-at-point)))
(global-set-key (kbd "C-c e") 'browse-url-with-eww)

;; ------------------------------------------------------------------------------------
;; テーマの設定
;; (load-theme 'misterioso)
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*")
                                     (powerline-raw " |")
                                     (powerline-process nil)
                                     (powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list (powerline-raw "%4l")
                                     (powerline-raw ":")
                                     (powerline-raw "%2c")
                                     (powerline-raw " | ")
                                     (powerline-raw "%6p")
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)
(load-theme 'atom-one-dark t)

;; diredの設定
;; ２画面ファイラー
(setq dired-dwim-target t)

;; フォント設定
(add-to-list 'default-frame-alist '(font. "SourceHanCodeJP-Regular-12"))

;; スクロールの設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; スクロールを一行ずつにする
;; (setq scroll-step 1)

;; スクロールした際のカーソルの移動行数
(setq scroll-conservatively 1)

;; スクロール開始のマージン
(setq scroll-margin 10)

;; 1画面スクロール時に重複させる行数
(setq next-screen-context-lines 10)

;; 1画面スクロール時にカーソルの画面上の位置をなるべく変えない
(setq scroll-preserve-screen-position t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; exwmの設定
;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)
;; (define-key key-translation-map [?\C-h] [?\C-?])
;; (push ?\C-h exwm-input-prefix-keys)
;; (exwm-input-set-simulation-keys '(([?\C-?] . backspace)))
;; exwm-initの読み込み
(load "init-exwm")

;; multi-termの設定
;; (when (require 'multi-term nil t)
;;   ;; 使用するシェルを指定
;;   (setq multi-term-program "/bin/bash"))

;; jupyter notebookを使う
(require 'ein)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ein migemo rainbow-delimiters atom-one-dark-theme powerline multi-term exwm edit-server ddskk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
