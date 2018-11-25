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
;; (add-to-list 'package-archives '("melpa"."https://melpa.org/packages/")t)
;; (package-initialize)

(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

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
(prefer-coding-system 'utf-8)

;; バックアップファイ及び、自動セーブの無効
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;; メニューバー、ツールバー、スクロールバーの非表示
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; ddskk のキーバインド
;; (require 'skk)
;; (global-set-key (kbd "C-c C-j") 'skk-mode)
;; skkの設定
;; (when (require 'skk nil t)
;;   (global-set-key (kbd "C-c j") 'skk-auto-fill-mode) ;;良い感じに改行を自動入力してくれる機能
;;   (setq default-input-method "japanese-skk")         ;;emacs上での日本語入力にskkをつかう
;;   (require 'skk-study))
(global-set-key (kbd "C-x C-j") 'skk-mode)
(global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
(setq skk-user-directory "~/.ddskk")
(setq skk-large-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")





;; emacs-mozc
;; (set-language-environment 'Japanese)
;; (require 'mozc)
;; (setq default-input-method "Japanese-mozc")
;; (global-set-key (kbd "C-c j") 'mozc-mode)

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



;; keymap change
;; C-m : 改行プラスインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;;C-h : backspace
;; (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-set-key (kbd "C-h") 'delete-backward-char)
(defun minibuffer-delete-backward-char ()
  (local-set-key (kbd "C-h") 'delete-backward-char))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
;; C-x ? : help
(define-key global-map (kbd "C-c ?") 'help-command)
;;折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
;; eshell start
;; (global-set-key (kbd "C-c e") 'eshell)
;; ウィンドウサイズの変更のキーバインド
(global-set-key (kbd "C-c r") 'window-resizer)

;; 文字コードセット
(prefer-coding-system 'utf-8)

;; フォント
(set-default-font "SourceHanCodeJP R")
;; 行番号を表示(軽量化あり)
;; (global-linum-mode t)
(global-set-key (kbd "C-c C-l") 'global-linum-mode)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.5 nil #'linum-update-current))

;;スペース、タブなどを可視化する
;; (global-whitespace-mode 1)
;;スペース、改行、タブを表示する
(global-set-key (kbd "C-c C-w") 'global-whitespace-mode)

;; 列番号表示
(column-number-mode t)

;; タイトルバーにフルパス表示
;; (setq frame-title-format "%f")

;; カーソル行をハイライトする
;; (global-hl-line-mode nil)
;; (blink-cursor-mode 1)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; 起動時に*scratch*バッファを表示する
(setq initial-buffer-choice t)

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

;; スマートなウィンドウ切り替え
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings);
;; (global-set-key (kbd "C-c n") 'windmove-down)
;; (global-set-key (kbd "C-c f") 'windmove-right)
;; (global-set-key (kbd "C-c b") 'windmove-left)
;; (global-set-key (kbd "C-c p") 'windmove-up)
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

;; 補完で大文字小文字無視
(setq read-file-name-completion-ignore-case t)

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
;; (setq eww-search-prefix "https://www.google.co.jp/search?btnl&q=")
;; (require 'eww)
;; (defun eww-disable-images()
;;   "ewwで画像は表示させない"
;;   (interactive)
;;   (setq-local shr-put-image-function 'shr-put-image-alt)
;;   (eww-reload))
;; (defun eww-enable-image()
;;   "ewwで画像を表示させる"
;;   (interactive)
;;   (setq-local shr-put-image-function 'shr-put-image)
;;   (eww-reload))
;; (defun shr-put-image-alt (spec alt&optional flags)
;;   (insert alt))
;; ;; デフォルトで画像を表示させない
;; (provide 'mylisp-eww-image)
;; (defun eww-mode-hook--disable-image ()
;;   (setq-local shr-put-image-function 'shr-put-image-alt))
;; (add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

;; ;; 外部ブラウザで開く
;; (setq eww-browse-with-external-link t)

;; ;; 現在のurlをewwで開く
;; (defun browse-url-with-eww ()
;;   (interactive)
;;   (let ((url-region (bounds-of-thing-at-point 'url)))
;;     ;; url
;;     (if url-region
;;       (eww-browse-url (buffer-substring-no-properties (car url-region)
;;                               (cdr url-region))))
;;     ;; org-link
;;     (setq browse-url-browser-function 'eww-browse-url)
;;     (org-open-at-point)))
;; (global-set-key (kbd "C-c e") 'browse-url-with-eww)

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
;; filter
(require 'dired-filter)
(define-key dired-mode-map (kbd "/") dired-filter-map)
;; wdired set to "e"
(require 'wdired)
(setq wdired-allow-to-change-premissions t)
(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
;; コピーを使い安くする
(setq dired-dwim-target t)
(setq dired-launch-mailcap-friend '("env" "xdg-open"))
(dired-launch-enable)
;; 再帰的にコピーする
(setq dired-recursive-copies 'always)
;; .zipで終るファイルをZキーで展開できるように
(add-to-list 'dired-compress-file-suffixes '("\\.zip\\" ".zip" "unzip"))


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

;;(load "init-tex")

;; multi-termの設定
;; (when (require 'multi-term nil t)
;;   ;; 使用するシェルを指定
;;   (setq multi-term-program "/bin/bash"))

;; jupyter notebookを使う
(require 'ein)

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-for-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h") 'helm-find)
;; (global-set-key (kbd "C-x d") 'h
;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;; (require 'helm-migemo)
;;; この修正が必要
;; (eval-after-load "helm-migemo"
;;   '(defun helm-compile-source--candidates-in-buffer (source)
;;      (helm-aif (assoc 'candidates-in-buffer source)
;;          (append source
;;                  `((candidates
;;                     . ,(or (cdr it)
;;                            (lambda ()
;;                              ;; Do not use `source' because other plugins
;;                              ;; (such as helm-migemo) may change it
;;                              (helm-candidates-in-buffer (helm-get-current-source)))))
;;                    (volatile) (match identity)))
;;        source)))

(require 'zoom-window)
(global-set-key (kbd "C-c 1") 'zoom-window-zoom)
(setq zoom-window-mode-line-color "DarkGreen")

;; company setting
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う

;; ;; org-modeの設定
;; ; カレンダーの日付を英語表記にする
;; (setq system-time-locale "C")

;; ; アジェンダ
;; (define-key global-map "\C-c a" 'org-agenda)
;; (setq org-agenda-files
;;       ("~/notes.org" "~/calendar.org" ))
;; ; refile( C-c C-w )
;; (setq org-refile-targets
;;       ( ("~/notes.org" :level . 2 )
;; ("~/calendar.org" :level . 2 )))

;; ;; 下で設定した状態は、
;; ;; C-S-<right>/<left> or C-u C-u C-c C-t でキーワードグループ変更
;; ;; S-<right>/<left> で全てのキーワードを順送り
;; (setq org-todo-keywords
;;       (sequence "TODO" "NEXT" "REPEAT" "REMEMBER" "|" "DONE")
;;       (sequence "WAITING" "|" "CANCELED" "DEFFERED"))

;; exwmの設定
(require 'exwm)
(require 'exwm-cm)
;; (require 'exwm-config)
;; (exwm-config-default)
;; exwm-initの読み込み
(require 'init-exwm)
;; (when (require 'exwm nil t) (require 'init-exwm))
;; (exwm_conf)

;; (global-set-key (kbd "C-c w") 'w3m)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-unstable")

(eval-after-load "esh-module"
  '(setq eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list))))

;; 音量ショートカットキー
(defconst taiju/audio-volume-modifier 3)
(defun taiju/audio-toggle ()
  (interactive)
  (start-process-shell-command
   "audio-toggle"
   nil
   "amixer -c 0 sset Master toggle | grep -q '\\[on\\]' && amixer -c 0 sset Headphone unmute && amixer -c 0 sset Speaker unmute"))

(defun taiju/audio-lower-volume ()
  (interactive)
  (start-process-shell-command
   "audio-lower-volume"
   nil
   (format "amixer -c 0 set Master %d%%-" taiju/audio-volume-modifier)))

(defun taiju/audio-raise-volume ()
  (interactive)
  (start-process-shell-command
   "audio-raise-volume"
   nil
   (format "amixer -c 0 set Master %d%%+" taiju/audio-volume-modifier)))

(defun taiju/audio-mic-toggle ()
  (interactive)
  (start-process-shell-command
   "audio-mic-toggle"
   nil
   "amixer -c 0 sset Capture toggle"))

(global-set-key (kbd "C-c u") 'taiju/audio-raise-volume)
(global-set-key (kbd "C-c d") 'taiju/audio-lower-volume)
;; (global-set-key (kbd "C-c t") nil)
;; (defun speaker ()
;;   (interactive)
;;   (shell-command-to-string "pactl move-sink-input 9 4"))
;; (defun earbunds ()
;;   (interactive)
;;   (shell-command-to-string "pactl move-sink-input 9 0"))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-external-programs-associations
   (quote
    (("exe" . "wine")
     ("rar" . "mcomix")
     ("pdf" . "mcomix")
     ("zip" . "mcomix"))))
 '(package-selected-packages
   (quote
    (vlf dired-open w3m dired-launch dired-filter company zoom-window fish-mode helm-migemo helm ein migemo rainbow-delimiters atom-one-dark-theme powerline multi-term exwm edit-server ddskk)))
 '(skk-auto-insert-paren nil)
 '(skk-auto-okuri-process nil)
 '(skk-auto-start-henkan t)
 '(skk-check-okurigana-on-touroku nil)
 '(skk-delete-implies-kakutei t)
 '(skk-egg-like-newline t)
 '(skk-henkan-okuri-strictly nil)
 '(skk-henkan-strict-okuri-precedence nil)
 '(skk-j-mode-function-key-usage nil)
 '(skk-japanese-message-and-error nil)
 '(skk-kakutei-early t)
 '(skk-preload nil)
 '(skk-share-private-jisyo nil)
 '(skk-show-annotation nil)
 '(skk-show-candidates-always-pop-to-buffer nil)
 '(skk-show-icon nil)
 '(skk-show-inline nil)
 '(skk-show-japanese-menu t)
 '(skk-show-tooltip nil)
 '(skk-use-color-cursor t)
 '(skk-use-face t)
 '(skk-use-jisx0201-input-method nil)
 '(skk-use-look nil)
 '(skk-use-numeric-conversion t)
 '(skk-verbose nil))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
