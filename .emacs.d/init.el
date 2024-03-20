;;; init.el --- setting for emacs
;;; Commentary:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:

;; leaf読み込み前の設定
;; ラズパイでpackageをインストールができなかったときよう
;; (when (string= (system-name) "RaspberryPi")
;;   (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)
    (leaf *straight
      :when (executable-find "git")
      :config
      (defvar bootstrap-version)
      (let ((bootstrap-file
             (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
            (bootstrap-version 5))
        (unless (file-exists-p bootstrap-file)
          (with-current-buffer
              (url-retrieve-synchronously
               "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
               'silent 'inhibit-cookies)
            (goto-char (point-max))
            (eval-print-last-sexp)))
        (load bootstrap-file nil 'nomessage)))

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; 必要なPackageのInstall
(leaf leaf
  :config
  (leaf leaf-convert
    :ensure t
    :config (leaf use-package :emacs>= 24.3 :ensure t))
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imuenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c j" . macrostep-expand)))


;; boot
(leaf *add-to-load-path
  :load-path `(,(mapcar (lambda (elm)
                          (concat user-emacs-directory elm))
                        '("elisp" "conf" "public_repos")))
  :config
  (leaf private-path
    :when (file-directory-p "~/private/elisp")
    :load-path "~/private/elisp"))

(leaf *cus-edit
  :doc "customファイルをinit.elに記入しない"
  :preface (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  :custom `((custom-file . ,(expand-file-name "custom.el" user-emacs-directory)))
  :hook `(kill-emacs-hook . (lambda ()
                              (if (file-exists-p custom-file)
                                  (delete-file custom-file)))))

(leaf exec-path-from-shell
  :doc "Get environment variables such as $PATH from the shell"
  :req "emacs-24.1" "cl-lib-0.6"
  :tag "environment" "unix" "emacs>=24.1"
  :url "https://github.com/purcell/exec-path-from-shell"
  :added "2021-09-05"
  :emacs>= 24.1
  :ensure t
  :unless (eq system-type 'windows-nt)
  :defun (exec-path-from-shell-initialize)
  :custom ((exec-path-from-shell-check-startup-files . nil)
           (exec-path-from-shell-variables           . '("SHELL" "PATH")))
  :config
  (exec-path-from-shell-initialize))

(leaf gcmh
  :doc "the Garbage Collector Magic Hack"
  :req "emacs-24"
  :tag "internal" "emacs>=24"
  :url "https://gitlab.com/koral/gcmh"
  :added "2021-09-18"
  :emacs>= 24
  :ensure t
  :global-minor-mode t
  :custom `((read-process-output-max . ,(* 64 1024 1024))
            (garbage-collection-messages           . t)))

(leaf async
    :doc "Asynchronous processing in Emacs"
    :req "emacs-24.4"
    :tag "async" "emacs>=24.4"
    :url "https://github.com/jwiegley/emacs-async"
    :added "2021-09-05"
    :emacs>= 24.4
    :ensure t
    :custom ((dired-async-mode . 1)
             (async-bytecomp-package-mode . 1)
             (async-bytecomp-allowed-packages . '(all))))


;; 基本設定
(leaf *cus-start
  :doc "define customization properties of builtins"
  :url "http://handlename.hatenablog.jp/entry/2011/12/11/214923" ; align sumple
  :defvar show-paren-deley

  :hook  (;; 保存時にいらないスペースを削除
          (before-save-hook . delete-trailing-whitespace)
          (after-save-hook  . flashAfterSave)
          (after-save-hook  . executable-make-buffer-file-executable-if-script-p))

  :preface
  (defun flashAfterSave ()
    (interactive)
    (let ((orig-fg (face-background 'mode-line)))
      (set-face-background 'mode-line "dark green")
      (run-with-idle-timer 0.1 nil
                           (lambda (fg) (set-face-background 'mode-line fg))
                           orig-fg)))

  :custom `(;; 表示
            (tool-bar-mode                         . nil)
            (scroll-bar-mode                       . nil)
            (menu-bar-mode                         . nil)
            (blink-cursor-mode                     . nil)
            (column-number-mode                    . nil)
            (ring-bell-function                    . 'ignore)
            ;; 編集
            (tab-width                             . 4)
            (indent-tabs-mode                      . nil)
            (fill-column                           . 72)   ;; RFC2822 風味
            (truncate-lines                        . t)  ;; 折り返し無し
            (truncate-partial-width-windows        . nil)
            (paragraph-start                       . '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")
            (auto-fill-mode                        . nil)
            (read-file-name-completion-ignore-case . t)  ; 大文字小文字区別無し
            ;; undo/redo - 数字に根拠無し
            (undo-limit                            . 200000)
            (undo-strong-limit                     . 260000)
            ;; 履歴無制限
            (history-length                        . t)
            (create-lockfiles                      . nil)
            (use-dialog-box                        . nil)
            (use-file-dialog                       . nil)
            (frame-resize-pixelwise                . t)
            (enable-recursive-minibuffers          . t)
            (history-delete-duplicates             . t)
            (mouse-wheel-scroll-amount             . '(1 ((control) . 5)))
            (text-quoting-style                    . 'straight)
            ;; システムの時計をCにする
            (system-time-locale                    . "C")
            ;; 改行コードを表示する
            (eol-mnemonic-dos                      . "(CRLF)")
            (eol-mnemonic-mac                      . "(CR)")
            (eol-mnemonic-unix                     . "(LF)")
            ;; 右から左に読む言語に対応させないことで描画高速化
            (bidi-display-reordering               . nil)
            ;; 同じ内容を履歴に記録しない
            (history-delete-duplicates             . t)
            ;; バックアップファイ及び、自動セーブの無効
            (make-backup-files                     . nil)
            (delete-auto-save-files                . t)
            (auto-save-default                     . nil)
            ;; バッファの最後でnewlineで新規行を追加するのを禁止する
            (next-line-add-newlines                . nil)
            ;; ミニバッファの履歴を保存する
            (savehist-mode                         . 1)
            ;;
            (show-paren-mode                       . 1)
            (show-paren-delay                      . 0.125)
            ;;
            (vc-follow-symlinks                    . t)
            (temp-buffer-resize-mode               . 1)
            (display-time-mode                     . t)
            (display-time-string-forms             . '((format "%s/%s(%s)%s:%s"
                                                               month day dayname
                                                               24-hours minutes)))
            ;; 初めの画面を表示させない
            (inhibit-splash-screen             . t)
            (inhibit-startup-screen            . t)
            (inhibit-startup-message           . t)
            (inhibit-startup-echo-area-message . t)
            (initial-buffer-choice             . t)
            (initial-scratch-message           . nil)
            ;; byte-compileのエラーを無視する
            (debug-on-error . nil)
            (byte-compile-no-warnings . t)
            (byte-compile-warnings . '(not cl-functions obsolete))
            ;; キルリングの設定
            (kill-ring-max                . 10000)
            (kill-read-only-ok            . t)
            (kill-whole-line              . t)
            (eval-expression-print-length . nil)
            (eval-expression-print-level  . nil)
            (auto-revert-interval . 0.1)
            (global-auto-revert-mode . t))
  :init
  (set-face-background 'region "#555")
  (run-with-idle-timer 60.0 t #'garbage-collect)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (with-current-buffer "*scratch*"
    (emacs-lock-mode 'kill))
  (with-current-buffer "*Messages*"
    (emacs-lock-mode 'kill))
)

(leaf *fontSetting
  :config
  (leaf *forArchlinux
    :when (eq system-type 'gnu/linux)
    :when (string= (system-name) "archlinuxhonda")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 130))
  (leaf *forSX12
    :when (eq system-type 'gnu/linux)
    :when (string= (system-name) "sx12toshiaki")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 140)
    (set-fontset-font t 'japanese-jisx0208 (font-spec :family "HackGen")))
  (leaf *forSX12_wsl
    :when (eq system-type 'gnu/linux)
    :when (string= (system-name) "sx12_toshiaki")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 140)
    (set-fontset-font t 'japanese-jisx0208 (font-spec :family "HackGen")))
  (leaf *HP_wsl
    :when (eq system-type 'gnu/linux)
    :when (string= (system-name) "JPC20627141")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 140)
    (set-fontset-font t 'japanese-jisx0208 (font-spec :family "HackGen")))
  (leaf *forMac
    :when (eq system-type 'darwin)
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 150)
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      (font-spec :family "HackGen"
                                 :height 150)))
  (leaf *windows
    :when (eq system-type 'windows-nt)
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 150)
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      (font-spec :family "HackGen"
                                 :height 150)))
  (leaf *pi
    ;; :disabled t
    :when (string= (system-name) "RaspberryPi")
    :when (string= (getenv "EXWM") "enable")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 120)
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      (font-spec :family "HackGen"
                                 :height 120))))

(leaf *dired
  ;; :disabled t
  :after dired
  :bind ((dired-mode-map
          :package dired
          ("j" . dired-next-line)
          ("k" . dired-previous-line)
          ("h" . kill-current-buffer-and-dired-up-directory)
          ("l" . kill-current-buffer-and/or-dired-open-file)
          ("f" . kill-current-buffer-and/or-dired-open-file)
          ("b" . kill-current-buffer-and-dired-up-directory)
          ("q" . kill-current-buffer-and-dired-up-directory)))
  :custom `((dired-recursive-copies     . 'always)
            (dired-recursive-deletes    . 'always)
            (dired-copy-preserve-time   . t)
            (dired-auto-revert-buffer   . t)
            (dired-dwim-target          . t)
            ;; (delete-by-moving-to-trash . t)
            ;; (dired-listing-switches    . "-Alhv --group-directories-first")
            ;; 追加
            (dired-launch-mailcap-frend . '("env" "xdg-open"))
            (dired-launch-enable        . t)
            (dired-isearch-filenames    . t)
            (dired-listing-switches     . ,(purecopy "-alht")))
  :init
  (leaf dired-x :require t)
  (leaf wdired
    :require t
    :hook (dired-hook . wired)
    :custom ((wdired-allow-to-change-permissions . t))
    :bind ((dired-mode-map
            :package dired
            ("e" . wdired-change-to-wdired-mode))))
  (leaf dired-filter
    :doc "Ibuffer-like filtering for dired"
    :req "dash-2.10.0" "dired-hacks-utils-0.0.1" "f-0.17.0" "cl-lib-0.3"
    :tag "files"
    :added "2021-09-05"
    :ensure t
    ;; :after dired-hacks-utils
    :bind ((dired-mode-map
            :package dired
            ("/" . dired-filer-map))))
  (leaf peep-dired
    :doc "Peep at files in another window from dired buffers"
    :tag "convenience" "files"
    :added "2021-09-05"
    :ensure t
    :bind ((dired-mode-map
            :package dired
            ("P" . peep-dired))))
  (leaf dired-open
    :doc "Open files from dired using using custom actions"
    :req "dash-2.5.0" "dired-hacks-utils-0.0.1"
    :tag "files"
    :added "2021-09-05"
    :ensure t
    :require t
    :when (eq system-type 'gnu/linux)
    :custom ((dired-open-extensions .
                                    '(("mkv"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("mp4"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("avi"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("wmv"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("webm"     . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("mpg"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("flv"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("m4v"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("mp3"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("flac"     . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("wav"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("m4a"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("3gp"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("rm"       . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("rmvb"     . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("mpeg"     . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("VOB"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("mov"      . "~/.emacs.d/script/mpv-rifle.sh")
                                      ("iso"      . "mpv dvd:// -dvd-device")
                                      ("playlist" . "mpv --playlist")
                                      ("exe"      . "wine")
                                      ("pdf"      . "zathura")
                                      ;; ("zip"      . "zathura")
                                      ;; ("rar"      . "zathura")
                                      ;; ("tar"      . "zathura")
                                      ("zip"      . "YACReader")
                                      ("rar"      . "YACReader")
                                      ("tar"      . "YACReader")
                                      ;; ("zip"      . "mcomix")
                                      ;; ("rar"       . "mcomix")
                                      ;; ("tar"       . "mcomix")
                                      ("xls"      . "xdg-open")
                                      ("xlsx"     . "xdg-open")
                                      ("jpg"      . "sxiv-rifle.sh")
                                      ("png"      . "sxiv-rifle.sh")
                                      ("jpeg"     . "sxiv-rifle.sh")
                                      ("gif"      . "sxiv-rifle.sh")
                                      ("png"      . "sxiv-rifle.sh")
                                      ("webp"     . "sxiv-rifle.sh")
                                      ))))
  (leaf dired-open
    :doc "Open files from dired using using custom actions"
    :req "dash-2.5.0" "dired-hacks-utils-0.0.1"
    :tag "files"
    :added "2021-09-05"
    :ensure t
    ;; :after dired-hacks-utils
    :when (eq system-type 'darwin)
    :custom ((dired-open-extensions .
                                    '(("key"  . "open")
                                      ("docx" . "open")
                                      ("pdf"  . "open")
                                      ("cmdf" . "open")
                                      ("xlsx" . "open")
                                      ("pxp"  . "open")
                                      ("bmp"  . "open")
                                      ))))
  (leaf *dired-wsl
    :when (string-match "microsoft" (shell-command-to-string "uname -r"))
    :bind ((dired-mode-map
            :package dired
            ("w" . open-file-by-windowsApp)))
    :preface
    (defun open-file-by-windowsApp ()
      (interactive)
      (let* ((file-path
              (shell-command-to-string (format "wslpath -w \"%s\"" (dired-get-file-for-visit))))
             (result (shell-command-to-string (format "cmd.exe /c start \"\" \"%s\" 2> /dev/null" file-path)))
             )
        (message (format "start %s" file-path))))
    )

  :preface
  (defun kill-current-buffer-and/or-dired-open-file ()
    "In Dired, dired-open-file for a file.
For a directory, dired-find-file and kill previously selected buffer."
    (interactive)
    (if (file-directory-p (dired-get-file-for-visit))
        (dired-find-alternate-file)
      (dired-view-file)))
  (defun kill-current-buffer-and-dired-up-directory (&optional other-window)
    "In Dired, dired-up-directory and kill previously selected buffer."
    (interactive "P")
    (let ((b (current-buffer)))
      (dired-up-directory other-window)
      (kill-buffer b)))
  (defun dired-open-file-other-window ()
    "In Dired, open file on other-window and select previously selected buffer."
    (interactive)
    (let ((cur-buf (current-buffer)) (tgt-buf (dired-open-file)))
      (switch-to-buffer cur-buf)
      (when tgt-buf
        (with-selected-window (next-window)
          (switch-to-buffer tgt-buf)))))
  (defun dired-up-directory-other-window ()
    "In Dired, dired-up-directory on other-window"
    (interactive)
    (dired-up-directory t)))

(leaf *eshell-tools
  :bind (("C-c e" . eshell))
  :defvar (eshell-command-aliases-list)
  :config
  (setq eshell-command-aliases-list '(("ll" . "ls -ltrh")
                                      ("la" . "ls -a")
                                      ("o" . "xdg-open")
                                      ("emacs" . "find-file $1")
                                      ("m" . "find-file $1")
                                      ("mc" . "find-file $1")
                                      ("d" . "dired .")
                                      ("l" . "eshell/less $1")
                                      ("dd" . "dd status=progress")
                                      ("pacmandate" . "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1")
                                      ("open" . "cmd.exe /c start {wslpath -w $*}")
                                      ))
  ;; (if (not (eq system-type 'windows))
  ;;         (eval-after-load "esh-module"
  ;;           '(defvar eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))))


  :preface
  (setenv "GIT_PAGER" "")
  (leaf eshell-prompt-extras
    :doc "Display extra information for your eshell prompt."
    :req "emacs-25"
    :tag "prompt" "eshell" "emacs>=25"
    :url "https://github.com/zwild/eshell-prompt-extras"
    :added "2022-03-19"
    :emacs>= 25
    :ensure t
    ;; :after esh-opt
    :commands epe-theme-lambda
    :custom ((eshell-highlight-prompt . nil)
             (eshell-prompt-function . 'epe-theme-lambda))
    )
   ;; (leaf *eshell-modules
   ;;   :disabled t
   ;;   :unless (eq system-type 'windows)
   ;;   :after esh-module
   ;;   :defvar (eshell-modules-list)
   ;;   :custom `(eshell-modules-list . ,(delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))
   ;; )
  )

(leaf *global-setting
  ;; :disabled t
  :hook (minibuffer-setup-hook . minibuffer-delete-backward-char)
  :init (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
  :bind (("C-x x s" . my-xset)
         ("C-c r"   . window-resizer)
         ("C-S-n"   . scroll-up_alt)
         ("C-S-p"   . scroll-down_alt)
         ("C-m"     . newline-and-indent)
         ("C-h"     . delete-backward-char)
         ("M-h"     . backward-kill-word)
         ("C-c ?"   . help-command)
         ("C-c l"   . toggle-truncate-lines)
         ("C-c t"   . display-line-numbers-mode)
         ("C-c w"   . whitespace-mode)
         ("C-c o"   . occur)
         ("C-c C-j" . eval-print-last-sexp))
  :custom ((scroll-preserve-screen-position . t)
           ;; スクロール開始のマージン
           (scroll-margin                   . 5)
           (scroll-conservatively           . 100)
           ;; 1画面スクロール時に重複させる行数
           (next-screen-context-lines       . 10)
           ;; 1画面スクロール時にカーソルの画面上の位置をなるべく変えない
           (scroll-preserve-screen-position . t)
           (windmove-wrap-around            . t))

  :config
  (leaf *ForMac
    :when (eq system-type 'darwin)
    :bind (("s-n" . windmove-down)
           ("s-f" . windmove-right)
           ("s-b" . windmove-left)
           ("s-p" . windmove-up)
           ("s-a" . zoom-window-zoom)
           ("s-q" . kill-current-buffer)
           ("s-h" . delete-window)
           ("s-o" . consult-buffer)))
  (leaf *ForWindows
    :when (eq system-type 'windows-nt)
    :bind (("M-n" . windmove-down)
           ("M-f" . windmove-right)
           ("M-b" . windmove-left)
           ("M-p" . windmove-up)
           ("M-a" . zoom-window-zoom)
           ("M-q" . kill-current-buffer)
           ("M-h" . delete-window)
           ("M-d" . app-launcher-run-app)
           ("M-o" . consult-buffer)))
  (leaf *ForLinux
    :when (eq system-type 'gnu/linux)
    :bind (("s-s" . async-shell-command)
           ("s-S" . window-capcher)
           ("s-n" . windmove-down)
           ("s-f" . windmove-right)
           ("s-b" . windmove-left)
           ("s-p" . windmove-up)
           ("s-a" . zoom-window-zoom)
           ("s-h" . delete-window)
           ("s-d" . app-launcher-run-app)
           ("s-n" . windmove-down)
           ("s-p" . windmove-up)
           ("s-q" . kill-current-buffer)
           ("s-o" . consult-buffer))
    :config
    (leaf *ForWsl
      :when (string-match "microsoft" (shell-command-to-string "uname -r"))
      :config
      (leaf wslx
        :bind (("M-q" . kill-current-buffer)
               ("M-o" . consult-buffer))
        :config
        (my-xset))

      (leaf *CLI
        :unless (eq window-system 'x)
        :bind (("M-n" . windmove-down)
               ("M-f" . windmove-right)
               ("M-b" . windmove-left)
               ("M-p" . windmove-up)
               ("M-a" . zoom-window-zoom)
               ("M-q" . kill-current-buffer)
               ("M-h" . delete-window)
               ("C-M-i" . output_toggle)
               ("C-M-m" . mute_toggle)
               ("C-M-n" . lower_volume )
               ("C-M-p" . upper_volume)
               ("M-d" . app-launcher-run-app)
               ("M-o" . consult-buffer))
        :custom (global-hl-line-mode . t))
      )
    )

  :preface
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
  (defun window-capcher ()
    "capcher window by imagemagic"
    (interactive)
    (let ((stringShellCommand (concat "import " "~/Downloads/screenshot_" "20" (format-time-string "%02y%02m%02d%02H%02M%02S" (current-time)) ".png")))
      (shell-command stringShellCommand)))
  (defun my-xset ()
    (interactive)
    (start-process-shell-command
     "xset 再設定"
     nil
     (format "xset r rate 250 40")))
  (defun scroll-up_alt ()
    (interactive)
    (scroll-up 1))
  (defun scroll-down_alt ()
    (interactive)
    (scroll-down 1))
  (defun upperLight ()
    (interactive)
    (start-process-shell-command
     "upper light"
     nil
     (format "xbacklight -inc 10")))
  (defun lowerLight ()
    (interactive)
    (start-process-shell-command
     "lower light"
     nil
     (format "xbacklight -dec 10")))
  (defun minibuffer-delete-backward-char ()
    (local-set-key (kbd "C-h") 'delete-backward-char))
  )

(leaf info
  ;; info日本語化
  :require t
  :config
  (add-to-list 'Info-directory-list "~/.emacs.d/info/")
  (defun Info-find-node--info-ja (orig-fn filename &rest args)
    (apply orig-fn
           (pcase filename
             ;; elisp を elisp-ja.info に置き換える
             ("elisp" "elisp-ja.info")
             (_ filename))
           args)
    (apply orig-fn
           (pcase filename
             ("emacs" "emacs-ja.info")
             (_ filename))
           args))
  (advice-add 'Info-find-node :around 'Info-find-node--info-ja))

(leaf *forWindows
  :when (eq system-type 'windows-nt)
  :custom ((w32-pass-rwindow-to-system . nil)
           (w32-rwindow-modifier       . 'super)
           (w32-shell-execute          . t)
           ;; (set-default-coding-systems . 'utf-8-dos)
           ;; (default-file-name-coding-system . 'shift-jis)
           (prefer-coding-system       . 'utf-8)
           (coding-system-for-read     . 'utf-8)
           (coding-system-for-write    . 'utf-8)
           (default-file-name-coding-system . 'shift_jis)
           )
  :config
  (leaf *diredForWindows
    :after dired
    :bind ((dired-mode-map
            :package dired
            ("w" . open-file-by-windowsApp)
            ("z" . unzip)
            ))
    :preface
    (defun shift-jis-to-utf8 (str) (decode-coding-string (encode-coding-string str 'japanese-shift-jis-dos) 'utf-8))
    (defun utf8-to-shift-jis (str) (decode-coding-string (encode-coding-string str 'utf-8) 'japanese-shift-jis-dos))
    (defun open-file-by-windowsApp ()
      (interactive)
      ;; (let ((file-name (decode-coding-string (encode-coding-string (dired-get-file-for-visit) 'japanese-shift-jis-dos) 'utf-8)))
      (let ((file-name (shift-jis-to-utf8 (dired-get-file-for-visit))))
        (shell-command (format "start \"\" \"%s\"" file-name))
        (message (utf8-to-shift-jis file-name))
        )
      )
    (defun openExplorer()
      (interactive)
      (let ((currentDir (shift-jis-to-utf8 default-directory)))
        (shell-command (format "start \"\" \"%s\"" currentDir))
        (message (format "open %s" (utf8-to-shift-jis currentDir)))
        )
      )
    (defun genBib ()
      (interactive)
      (let ((file-name (shift-jis-to-utf8 (dired-get-file-for-visit))))
        (shell-command (format
                        "python c:/Users/0145220079/Documents/programing/python/script/fromHTMLtoBib.py \"%s\""
                        file-name))
        )
      )
    (defun base64ToPng (fileName)
      (interactive "sfile name: ")
      (shell-command (format
                      "python c:/Users/0145220079/Documents/programing/python/script/decodeBase64.py %s"
                      fileName))
      )
    (defun unzip ()
      (interactive)
      (let ((file-name (shift-jis-to-utf8 (dired-get-file-for-visit))))
        (shell-command (format "call powershell -command \"Expand-Archive %s\"" file-name))
        (message (format "unzip %s" (utf8-to-shift-jis file-name)))
        )
      )
    )
  (leaf *my-app
    :require app-launcher-for-windows
    :config
    (add-to-list 'app-launcher-apps-directories "C:/Users/0145220079/AppData/Roaming/Microsoft/Windows/Start Menu/Programs")
    )
  )


;; theme
(leaf nord-theme
  :doc "An arctic, north-bluish clean and elegant theme"
  :req "emacs-24"
  :tag "emacs>=24"
  :url "https://github.com/arcticicestudio/nord-emacs"
  :added "2022-03-30"
  :emacs>= 24
  :ensure t
  :config
  (load-theme 'nord t)
  (leaf moody
    ;; :disabled t
    :doc "Tabs and ribbons for the mode line"
    :req "emacs-25.3"
    :tag "emacs>=25.3"
    :url "https://github.com/tarsius/moody"
    :added "2022-03-30"
    :emacs>= 25.3
    :ensure t
    :custom ((x-uderline-at-descent-line . t))
    :config
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode)
    (moody-replace-eldoc-minibuffer-message-function)
    (column-number-mode)
    (set-face-foreground 'mode-line-inactive "SlateGray")
    (set-face-background 'mode-line-inactive "gray20")
    (leaf minions
      :doc "A minor-mode menu for the mode line"
      :req "emacs-25.2"
      :tag "emacs>=25.2"
      :url "https://github.com/tarsius/minions"
      :added "2022-03-30"
      :emacs>= 25.2
      :ensure t
      :custom ((minions-mode-line-lighter . "[+]"))
      :global-minor-mode (minions-mode))
    )
  )


(leaf chatgpt-shell
  :doc "Interaction mode for ChatGPT"
  :req "emacs-27.1" "shell-maker-0.17.1"
  :tag "emacs>=27.1"
  :url "https://github.com/xenodium/chatgpt-shell"
  :added "2023-04-28"
  :emacs>= 27.1
  :ensure t
  :disabled t
  :custom
  `(chatgpt-shell-openai-key . ,(auth-source-pick-first-password :host "api.openai.com"))
  :bind ("C-c g" . chatgpt-shell)
  )

(leaf csv
  :doc "Functions for reading and parsing CSV files."
  :tag "csv" "data" "extensions"
  :added "2021-09-05"
  :ensure t)

(leaf ebib
  :doc "a BibTeX database manager"
  :req "parsebib-2.3" "emacs-25.1"
  :tag "bibtex" "text" "emacs>=25.1"
  :url "http://joostkremers.github.io/ebib/"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :after parsebib
  :custom (
           (bibtex-autokey-name-case-convert      . 'capitalize)
           (bibtex-autokey-titleword-case-convert . 'capitalize)
           (bibtex-autokey-titleword-separator    . "")
           (bibtex-autokey-titleword-length       . nil)
           (bibtex-autokey-titlewords             . 1)
           (bibtex-autokey-year-length            . 4)
           (bibtex-autokey-year-title-separator   . "_")
           (bibtex-autokey-titleword-ignore       . '("A" "An" "On" "The" "a" "an"
                                                      "on" "the" "Le" "La" "Les"
                                                      "le" "la" "les" "Zur" "zur" "Des" "Dir" "Die"))
           (ebib-keywords-use-only-file           . t)
           (ebib-keywords-file-save-on-exit       . 'always)
           )
  :config
  (leaf *ebibForMac
    :when (eq system-type 'darwin)
    :custom ((ebib-file-associations . '(("pdf" . "open") ("ps"  . "open"))))
    )
  (leaf *ebibForLinux
    :when (eq system-type 'gnu/linux)
    :custom ((ebib-preload-bib-files . '("~/tex/references.bib"))
             (ebib-keywords-file     . "~/tex/ebib-keywords.txt")
             (ebib-file-associations . '(("pdf" . "zathura") ("ps"  . "zathura")))
             (ebib-file-search-dirs  . '("~/tex/pdfs" "~/tex/papers" "~/tex/books"))
             ))
  (leaf *ebibForSony
    :when (eq system-type 'windows-nt)
    :when (string= (system-name) "JPC20627141")
    :bind (("C-c b" . ebib))
    :custom ((ebib-preload-bib-files . '("~/Documents/PDF/references.bib"))
             (ebib-keywords-file     . "~/Documents/PDF/ebib-keywords.txt")
             (ebib-file-associations . '(("pdf" . "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
                                         ("ps"  . "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")))
             (ebib-file-search-dirs  . '("~/Documents/PDF/ER" "~/Documents/PDF/paper"))
             ))
  (leaf biblio
    :doc "Browse and import bibliographic references from CrossRef, arXiv, DBLP, HAL, Dissemin, and doi.org"
    :req "emacs-24.3" "biblio-core-0.2"
    :tag "hypermedia" "convenience" "tex" "bib" "emacs>=24.3"
    :url "https://github.com/cpitclaudel/biblio.el"
    :added "2023-04-18"
    :emacs>= 24.3
    :ensure t
    :after biblio-core)
  )

(leaf ediff
  :doc "a comprehensive visual interface to diff & patch"
  :tag "builtin"
  :added "2022-03-24"
  :custom `((ediff-window-setup-function . 'ediff-setup-windows-plain)
            (ediff-split-window-function . 'split-window-horizontally)))

(leaf ein
  :doc "Emacs IPython Notebook"
  :req "emacs-25" "websocket-1.12" "anaphora-1.0.4" "request-0.3.3" "deferred-0.5" "polymode-0.2.2" "dash-2.13.0" "with-editor-0.-1"
  :tag "reproducible research" "literate programming" "jupyter" "emacs>=25"
  :url "https://github.com/dickmao/emacs-ipython-notebook"
  :added "2021-09-05"
  :emacs>= 25
  :ensure t
  ;; :require ein ein-notebook
  ;; :el-get millejoh/emacs-ipython-notebook
  :hook (
         (ein:notebook-mode-hook . jedi:setup)
         (ein:notebook-mode-hook . smartparens-mode))
  :custom (
           (ein:worksheet-enable-undo . t)
           (ein:output-area-inlined-images . t)
           (ein:markdown-command . "pandoc --metadata pagetitle=\"markdown preview\" -f markdown -c ~/.pandoc/github-markdown.css -s --self-contained --mathjax=https://raw.githubusercontent.com/ustasb/dotfiles/b54b8f502eb94d6146c2a02bfc62ebda72b91035/pandoc/mathjax.js")
           (jedi:complete-on-dot . t)
           )
  :config
  (leaf *ein-for-windows
    :when (string= system-type 'windows-nt)
    :hook ((ein:notebook-mode-hook . ac-mode-map-bind))
    :preface
    (defun ac-mode-map-bind ()
      (interactive)
      (progn
        (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
        (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous))))
  (setq ein:output-type-preference
      '(emacs-lisp svg png jpeg html text latex javascript))
  (leaf jedi-core
    :doc "Common code of jedi.el and company-jedi.el"
    :req "emacs-24" "epc-0.1.0" "python-environment-0.0.2" "cl-lib-0.5"
    :tag "emacs>=24"
    :added "2023-11-12"
    :emacs>= 24
    :ensure t)
  (leaf company-jedi
    :doc "Company-mode completion back-end for Python JEDI"
    :req "emacs-24" "cl-lib-0.5" "company-0.8.11" "jedi-core-0.2.7"
    :tag "emacs>=24"
    :url "https://github.com/emacsorphanage/company-jedi"
    :added "2023-11-12"
    :emacs>= 24
    :ensure t)
  )

(leaf eww
  :doc "Emacs Web Wowser"
  :tag "builtin"
  :added "2021-09-05"
  ;; :disabled t
  :hook ((eww-mode-hook . eww-mode-hook-disable-image))
  :defun eww-reload
  :defvar (shr-put-image-function eww-disable-colorize)
  :custom ((eww-search-prefix . "https://www.google.co.jp/search?btnl&q=")
           (eww-browse-with-external-link . t)
           (eww-disable-colorize . t))
  :bind (("C-c m"  . browse-url-with-eww)
         (eww-mode-map
          ("f"     . ace-link-eww)
          ("s-l"   . eww-search-words)
          ("M"     . eww-open-in-new-buffer)
          ("s-w"   . eww-buffer-kill)
          ("C-s-v" . eww-enable-images)
          ("s-v"   . eww-disable-images)
          ("s-e"   . eww-browse-with-external-browser)
          ("r"     . eww-reload)
          ;; vi風
          ("h"     . backward-char)
          ("j"     . next-line)
          ("k"     . previous-line)
          ("l"     . forward-char)
          ("g"     . eww-top)
          ("/"     . isearch-forward)
          ("n"     . isearch-next)
          ("?"     . isearch-backward)
          ;; vimium風
          ("J"     . View-scroll-line-forward)
          ("K"     . View-scroll-line-backward)
          ("H"     . eww-back-url)
          ("L"     . eww-forward-url)
          ("J"     . previous-buffer)
          ("K"     . next-buffer)
          ("d"     . scroll-up)
          ("u"     . scroll-down)))

  :config
  (leaf ace-link
    :doc "Quickly follow links"
    :req "avy-0.4.0"
    :tag "avy" "links" "convenience"
    :url "https://github.com/abo-abo/ace-link"
    :added "2022-04-30"
    :ensure t)
  (leaf addressbar
    :when (executable-find "git")
    :el-get (addressbar
             :type github
             :pkgname "lurdan/emacs-addressbar")
    :custom `((addressbar-persistent-history-directory . "~/.emacs.d/.cache/")
              (addressbar-ignore-url-regexp . "\\(://duckduckgo\\.com/\\|google\\.com/search\\)")
              (addressbar-search-command-alist . '("g" . "https://google.com/search?&gws_rd=cr&complete=0&pws=0&tbs=li:1&q="))
              (addressbar-display-url-max-length . 60)))

  :advice
  (:around shr-colorize-region shr-colorize-region--disable)
  (:around eww-colorize-region shr-colorize-region--disable)

  :preface
  (defun shr-put-image-alt (spec alt &optional flags)
    (insert alt))

  (defun eww-disable-images ()
    "eww で画像表示させない"
    (interactive)
    (setq-local shr-put-image-function 'shr-put-image-alt)
    (eww-reload))
  (defun eww-enable-images ()
    "eww で画像表示させる"
    (interactive)
    (setq-local shr-put-image-function 'shr-put-image)
    (eww-reload))
  ;; はじめから非表示
  (defun eww-mode-hook-disable-image ()
    (setq-local shr-put-image-function 'shr-put-image-alt))

  (defun browse-url-with-eww ()
    (interactive)
    (let ((url-region (bounds-of-thing-at-point 'url)))
      ;; url
      (if url-region
          (eww-browse-url (buffer-substring-no-properties (car url-region)
                                                          (cdr url-region))))
      ;; org-link
      (setq browse-url-browser-function 'eww-browse-url)))

  (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
    (unless eww-disable-colorize
      (funcall orig start end fg)))

  (defun eww-disable-color ()
    "eww で文字色を反映させない"
    (interactive)
    (setq-local eww-disable-colorize t)
    (eww-reload))

  (defun eww-enable-color ()
    "eww で文字色を反映させる"
    (interactive)
    (setq-local eww-disable-colorize nil)
    (eww-reload)))

(leaf google-translate
  :ensure t
  :require t
  :bind (("s-g" . google-translate-enja-or-jaen))
  :custom ((google-translate--translation-directions-alist . '(("en" . "ja")
                                                               ("ja" . "en")))
           (google-translate-output-destination . 'popup))
  :config
  (defun google-translate-enja-or-jaen (&optional string)
    "Translate words in region or current position. Can also specify query with C-u"
    (interactive)
    (setq string
          (cond ((stringp string) string)
                (current-prefix-arg
                 (read-string "Google Translate: "))
                ((use-region-p)
                 (buffer-substring (region-beginning) (region-end)))
                (t
                 (thing-at-point 'word))))
    (let* ((asciip (string-match
                    (format "\\`[%s]+\\'" "[:ascii:]’“”–")
                    string)))
      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
       (if asciip "en" "ja")
       (if asciip "ja" "en")
       string)))

  (defun google-translate--search-tkk ()
    "Search TKK."
    (list 430675 2721866130))
  ;; (defun google-translate--get-b-d1 ()
  ;;   ;; TKK='427110.1469889687'
  ;;   (list 427110 1469889687))
  )

(leaf google-this
  :doc "A set of functions and bindings to google under point."
  :req "emacs-24.1"
  :tag "hypermedia" "convenience" "emacs>=24.1"
  :url "http://github.com/Malabarba/emacs-google-this"
  :added "2022-12-30"
  :emacs>= 24.1
  :ensure t)

(leaf graphviz-dot-mode
  :doc "Mode for the dot-language used by graphviz (att)."
  :req "emacs-25.0"
  :tag "att" "graphs" "graphviz" "dotlanguage" "dot-language" "dot" "mode" "emacs>=25.0"
  :url "https://ppareit.github.io/graphviz-dot-mode/"
  :added "2023-06-20"
  :emacs>= 25.0
  :ensure t)

(leaf magit
  :doc "A Git porcelain inside Emacs."
  :req "emacs-25.1" "dash-20210330" "git-commit-20210806" "magit-section-20210806" "transient-20210701" "with-editor-20210524"
  :tag "vc" "tools" "git" "emacs>=25.1"
  :url "https://github.com/magit/magit"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :after git-commit magit-section with-editor
  :when (executable-find "git")
  :bind (("C-x g" . magit-status))
  :config (setenv "GIT_PAGER" ""))

(leaf mew
  :doc "Messaging in the Emacs World"
  :added "2024-02-18"
  :ensure t
  :require t
  :when (executable-find "stunnel")
  ;; :custom ((mew-fcc . "+outbox")
  ;;          (exec-path . (cons "/usr/bin" exec-path))
  ;;          (user-mail-addressuser-mail-address . "frenzieddoll@gmail.com")
  ;;          (user-full-name . "frenzieddoll")
  ;;          (mew-smtp-server . "smtp.gmail.com")
  ;;          (mail-user-agent . 'mew-user-agent)
  ;;          )
  ;; :init
  ;; (autoload 'mew "mew" nil t)
  ;; (autoload 'mew-send "mew" nil t)

  :config
  (autoload 'mew "mew" nil t)
  (autoload 'mew-send "mew" nil t)
  (setq mew-fcc "+outbox")
  (setq exec-path (cons "/usr/bin" exec-path))

  (setq user-mail-address "frenzieddoll@gmail.com")
  (setq user-full-name "frenzieddoll")
  (setq mew-smtp-server "smtp.gmail.com")
  (setq mail-user-agent 'mew-user-agent)
  (define-mail-user-agent
    'mew-user-agent
    'mew-user-agent-compose
    'mew-draft-send-message
    'mew-draft-kill
    'mew-send-hook))

(leaf org
  :doc "Export Framework for Org Mode"
  :tag "builtin"
  :added "2021-09-05"
  :disabled t
  :custom ((org-agenda-files . '("~/Dropbox/org/todo.org"))
           (org-directory . "~/Dropbox/org"))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :custom `((org-capture-templates . '(("n" "Note" entry (file+headline "~/Dropbox/org/notes.org" "Notes") "* %?\nEntered on %U\n %i\n %a")
                                       ("t" "Todo" entry (file+headline "~/Dropbox/org/todo.org"  "Todo")  "* TODO %?\n %i\n %a")))
            (org-todo-keywords . '((sequence "TODO(t)" "SOMEDAY(s)" "WATTING(w)" "|" "DONE(d)" "CANCELED(c@)")))
            (org-enforce-todo-dependencies . t)
            (org-log-done . t))
  )

(leaf org
    :doc "Export Framework for Org Mode"
    :tag "builtin"
    :added "2021-09-05"
    :preface
    (setq org-path (expand-file-name
                   (cond ((string= (system-name) "archlinux") "~/Dropbox/org/")
                         (t "~/.emacs.d/org/"))))
    (defun concat-org-path (str) (concat org-path str))
    (setq todoFile (concat-org-path "todo.org"))
    (setq memoFile (concat-org-path "memo.org"))
    (setq glosFile (concat-org-path "glossary.org"))
    (setq org-agenda-files (list todoFile))

    :bind (("C-c a" . org-agenda)
           ("C-c c" . org-capture))
    :custom `((org-directory    . org-path)
              (org-capture-templates . `(("t" "task"     entry (file+headline todoFile "todo") "** TODO %? \n" :empty-lines 1)
                                         ("m" "memo"     entry (file          memoFile) "* %^t \n" :empty-lines 1)
                                         ("g" "glossary" entry (file          glosFile) "** %? \n" :empty-lines 1)))
              (org-todo-keywords . '((sequence "TODO(t)" "SOMEDAY(s)" "WATTING(w)" "|" "DONE(d)" "CANCELED(c@)")))
              (org-enforce-todo-dependencies . t)
              (org-log-done . t))
    )

(leaf paradox
  :doc "A modern Packages Menu. Colored, with package ratings, and customizable."
  :req "emacs-24.4" "seq-1.7" "let-alist-1.0.3" "spinner-1.7.3" "hydra-0.13.2"
  :tag "packages" "package" "emacs>=24.4"
  :url "https://github.com/Malabarba/paradox"
  :added "2023-03-18"
  :emacs>= 24.4
  :ensure t
  :require t
  :config (paradox-enable))

(leaf pdf-tools
  :doc "Support library for PDF documents"
  :req "emacs-24.3" "tablist-1.0" "let-alist-1.0.4"
  :tag "multimedia" "files" "emacs>=24.3"
  :url "http://github.com/vedang/pdf-tools/"
  :added "2021-09-05"
  :emacs>= 24.3
  :ensure t
  :after tablist
  :when (executable-find "epdfinfo")
  :hook ((pdf-view-mode-hook . pdf-misc-size-indication-minor-mode)
         (pdf-view-mode-hook . pdf-links-minor-mode)
         (pdf-view-mode-hook . pdf-isearch-minor-mode)))

;; (leaf shackle
;;   :doc "Enforce rules for popups"
;;   :req "emacs-24.3" "cl-lib-0.5"
;;   :tag "convenience" "emacs>=24.3"
;;   :url "https://depp.brause.cc/shackle"
;;   :added "2021-09-05"
;;   :emacs>= 24.3
;;   :ensure t
;;   :unless (string-match "RaspberryPi" (system-name))
;;   :custom `((shackle-rules . '((compilation-mode :align below :ratio 0.2)
;;                                ("*Google Translate*" :align right :ratio 0.3)
;;                                ("*Help*" :align right)
;;                                ("*online-judge*" :align below :ratio 0.5)
;;                                ("*haskell-compilation*" :align below :ratio 0.5)
;;                                ))
;;             (shackle-mode . 1)
;;             (winner-mode . 1)
;;             (shackle-lighter . ""))
;;   :bind (("C-z" . winner-undo)))

;; (leaf twittering-mode
;;   :doc "Major mode for Twitter"
;;   :tag "web" "twitter"
;;   :url "http://twmode.sf.net/"
;;   :added "2021-09-05"
;;   :ensure t
;;   :custom ((twittering-allow-insecure-server-cert . t)
;;            (twittering-use-master-password . t)))

(leaf treemacs
  :doc "A tree style file explorer package"
  :req "emacs-26.1" "cl-lib-0.5" "dash-2.11.0" "s-1.12.0" "ace-window-0.9.0" "pfuture-1.7" "hydra-0.13.2" "ht-2.2" "cfrs-1.3.2"
  :tag "emacs>=26.1"
  :url "https://github.com/Alexander-Miller/treemacs"
  :added "2023-04-09"
  :emacs>= 26.1
  :ensure t
  :custom ((treemacs-load-theme . "all-the-icons"))
  :config
  (leaf treemacs-all-the-icons
    :doc "all-the-icons integration for treemacs"
    :req "emacs-26.1" "all-the-icons-4.0.1" "treemacs-0.0"
    :tag "emacs>=26.1"
    :url "https://github.com/Alexander-Miller/treemacs"
    :added "2023-04-09"
    :emacs>= 26.1
    :ensure t
    :after all-the-icons treemacs)
)

(leaf view
  :doc "peruse file or buffer without editing"
  :tag "builtin"
  :added "2021-09-05"
  :defun (undo-tree-redo
          undo-tree-undo
          backward-line)
  :custom ((view-read-only . t))
  :bind (("C-;" . view-mode)
         (view-mode-map
          ("SPC" . ignore)
          ("C-m" . ignore)
          ("h"   . backward-char)
          ("j"   . next-line)
          ("k"   . previous-line)
          ("l"   . forward-char)
          ("J"   . View-scroll-line-forward)
          ("K"   . View-scroll-line-backward)
          ("b"   . backward-char)
          ("n"   . next-line)
          ("p"   . previous-line)
          ("f"   . forward-char)
          ("C-f" . forward-char)
          ("C-b" . backward-char)
          ("C-;" . ignore)
          ("a"   . vim-forward-char-to-insert)
          ("A"   . vim-end-of-line-to-insert)
          ("I"   . vim-beginning-of-line-to-insert)
          ("i"   . View-exit)
          ("x"   . vim-del-char)
          ("X"   . vim-backward-kill-line)
          ("0"   . beginning-of-line)
          ("$"   . move-end-of-line)
          ("e"   . end-of-line)
          ("o"   . vim-o)
          ("O"   . vim-O)
          ("y"   . copy-region-as-kill)
          ("Y"   . vim-copy-line)
          ("w"   . forward-word+1)
          ("W"   . backward-word)
          ("P"   . vim-P)
          ("D"   . vim-kill-line)
          (":"   . save-buffer)
          ("u"   . vim-undo)
          ("r"   . vim-redo)
          ("d"   . vim-kill-whole-line)
          ("c"   . vim-kill-whole-line-to-insert)
          ("g"   . View-goto-line)
          ("G"   . View-goto-percent)))
  :preface
  (leaf *keys-in-view-mode
    :config
    (defun vim-forward-char-to-insert ()
      (interactive)
      (view-mode 0)
      (forward-char 1)
      (message "edit-mode !"))
    ;; like A
    (defun vim-end-of-line-to-insert ()
      (interactive)
      (view-mode 0)
      (end-of-line)
      (message "edit-mode !"))
    ;; like I
    (defun vim-beginning-of-line-to-insert ()
      (interactive)
      (view-mode 0)
      (beginning-of-line)
      (message "edit-mode !"))
    ;; like cc
    (defun vim-kill-whole-line-to-insert ()
      (interactive)
      (view-mode 0)
      (kill-whole-line)
      (open-line 1)
      (backward-line)
      (beginning-of-line)
      (message ":kill-whole-line and edit-mode !"))
    ;; like dd
    (defun vim-kill-whole-line ()
      (interactive)
      (view-mode 0)
      (kill-whole-line)
      (view-mode 1)
      (message "kill-whole-line"))
    ;; like D
    (defun vim-kill-line ()
      (interactive)
      (view-mode 0)
      (kill-line)
      (view-mode 1)
      (message "kill-line"))
    ;; like C
    (defun vim-kill-line-to-insert ()
      (interactive)
      (view-mode 0)
      (kill-line)
      (message "kill-line and edit-mode !"))
    ;; like o
    (defun vim-o ()
      (interactive)
      (view-mode 0)
      (forward-line)
      (open-line 1)
      (beginning-of-line)
      (message "edit-mode !"))
    ;; like O
    (defun vim-O ()
      (interactive)
      (view-mode 0)
      (open-line 1)
      (beginning-of-line)
      (message "edit-mode !"))
    ;; like x
    (defun vim-del-char ()
      (interactive)
      (view-mode 0)
      (delete-char 1)
      (view-mode 1)
      (message "delete-char"))
    ;; like c
    (defun vim-del-char-to-insert ()
      (interactive)
      (view-mode 0)
      (delete-char 1)
      (message "delete-char and edit mode !"))
    ;; like u
    (defun vim-undo ()
      (interactive)
      (view-mode 0)
      (undo-tree-undo)
      (view-mode 1)
      (message "undo !"))
    ;; like C-r
    (defun vim-redo ()
      (interactive)
      (view-mode 0)
      (undo-tree-redo)
      (view-mode 1)
      (message "redo !"))
    ;; like Y
    (defun vim-copy-line (arg)
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
    ;; like P
    (defun vim-P ()
      (interactive)
      (view-mode 0)
      (beginning-of-line)
      (yank)
      (beginning-of-line)
      (forward-line -1)
      (view-mode 1)
      (message "yank !"))
    ;; like p
    (defun vim-p ()
      (interactive)
      (view-mode 0)
      (yank)
      (view-mode 1)
      (message "yank !"))
    ;; like w
    (defun forward-word+1 ()
      (interactive)
      (forward-word)
      (forward-char))
    ;; like %
    (defun vim-jump-brace()
      "Jump to correspondence parenthesis"
      (interactive)
      (let ((c (following-char))
            (p (preceding-char)))
        (if (eq (char-syntax c) 40) (forward-list)
          (if (eq (char-syntax p) 41) (backward-list)
            (backward-up-list)))))
    ;; Delete from cursor position to beginning-of-line
    (defun vim-backward-kill-line (arg)
      "Kill chars backward until encountering the beginning of line."
      (interactive "p")
      (view-mode 0)
      (kill-line 0)
      (view-mode 1)
      (message "backward-kill-line"))))

(leaf vlf
  :doc "View Large Files"
  :tag "utilities" "large files"
  :url "https://github.com/m00natic/vlfi"
  :added "2021-09-05"
  ;; :require vlf-setup
  :ensure t)

(leaf yaml
  :doc "YAML parser for Elisp"
  :req "emacs-25.1"
  :tag "tools" "emacs>=25.1"
  :url "https://github.com/zkry/yaml.el"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t)

(leaf yatex
  :doc "Yet Another tex-mode for emacs //野鳥//"
  :added "2021-09-05"
  :ensure t
  :hook ((yatex-mode-hook . (lambda () (auto-fill-mode -1)))
         (yatex-mode-hook . reftex-mode)
         (latex-mode-hook . (lambda () (yatex-mode)))
         )
  ;; :bind (("C-c C-z" . ebib))
  :mode (("\\ .tex\\'" "\\ .ltx\\'" "\\ .cls\\'" "\\ .sty\\'" "\\ .clo\\'" "\\ .bbl\\'") . yatex-mode)
  :custom `((YaTeX-inhibit-prefix-letter  . t)
            (YaTeX-kanji-code             . 4)
            (YaTeX-latex-message-code     . 'utf-8)
            (YaTeX-use-LaTeX2e            . t)
            (YaTeX-use-AMS-LaTeX          . t)
            (YaTeX-dvi2-command-ext-alist . '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|atril\\|xreader\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|MicrosoftEdge\\|microsoft-edge\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
            (tex-command                  . "lualatex -synctex=1")
            ;; (tex-command  . "ptex2pdf -u -l -ot '-synctex=1 -file-line-error'")
            ;; (tex-command  . "ptex2pdf -l -ot '-synctex=1")
            (bibtex-command               . "upbibtex")
            ;; (makeindex-command  . "mendex")
            (dviprint-command-format      . "open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")
            (YaTeX-nervous                . nil)
            (YaTeX-close-paren-always     . nil))
  :config
  (leaf *yatexForLinux
    :when (eq system-type 'gnu/linux)
    :custom ((dvi2-command        .   "zathura -x \"emacsclient --no-wait +%{line} %{input}\"")
             (tex-pdfview-command .   "zathura -x \"emacsclient --no-wait +%{line} %{input}\"")))

  (leaf *yatexforMac
    ;; :disabled t
    :when (eq system-type 'darwin)
    :custom ((dvi2-command        .   "open -a Skim")
             (tex-pdfview-command .   "open -a Skim")))

  (leaf *yatex_after_load
    :after yatexprc
    :defvar YaTeX-parent-file YaTeX-cmd-displayline
    :defun YaTeX-preview-default-previewer YaTeX-visit-main YaTeX-system
    :config
    (defun YaTeX-preview-jump-line ()
      "Call jump-line function of various previewer on current main file"
      (interactive)
      (save-excursion
        (save-restriction
          (widen)
          (let*((pf (or YaTeX-parent-file
                        (save-excursion (YaTeX-visit-main t) (buffer-file-name))))
                (pdir (file-name-directory pf))
                (bnr (substring pf 0 (string-match "\\....$" pf)))
                                        ;(cf (file-relative-name (buffer-file-name) pdir))
                (cf (buffer-file-name)) ;2016-01-08
                (buffer (get-buffer-create " *preview-jump-line*"))
                (line (count-lines (point-min) (point-end-of-line)))
                (previewer (YaTeX-preview-default-previewer))
                (cmd (cond
                      ((string-match "Skim" previewer)
                       (format "%s %d '%s.pdf' '%s'"
                               YaTeX-cmd-displayline line bnr cf))
                      ((string-match "evince" previewer)
                       (format "%s '%s.pdf' %d '%s'"
                               "fwdevince" bnr line cf))
                      ((string-match "sumatra" previewer)
                       (format "%s \"%s.pdf\" -forward-search \"%s\" %d"
                               previewer bnr cf line))
                      ((string-match "zathura" previewer)
                       (format "%s --synctex-forward '%d:0:%s' '%s.pdf'"
                               previewer line cf bnr))
                      ((string-match "qpdfview" previewer)
                       (format "%s '%s.pdf#src:%s:%d:0'"
                               previewer bnr cf line))
                      ((string-match "okular" previewer)
                       (format "%s '%s.pdf#src:%d %s'"
                               previewer bnr line (expand-file-name cf)))
                      )))
            (YaTeX-system cmd "jump-line" 'noask pdir)))))
    )

  (leaf reftex
    :doc "minor mode for doing \\label, \\ref, \\cite, \\index in LaTeX"
    :tag "builtin"
    :added "2021-09-05"
    :hook (yatex-mode . reftex-mode)
    :custom ((reftex-mode . 1)
             (reftex-label-alist . '((nil ?e nil "\\eqref{%s}" nil nil)))
             (reftex-default-bibliography . '("~/tex/references.bib"))
             (reftex-bibliography-commands . '("bibliography" "nobibliography" "addbibresorce")))

    :bind ((YaTeX-mode-map
            ("C-c >" . YaTeX-comment-region)
            ("C-c <" . YaTeX-uncomment-region)))))


;; マイナーモードの設定
(leaf align
  :doc "align text to a specific column, by regexp"
  :tag "builtin"
  :added "2021-09-05"
  :require t
  :config
  (leaf *align-for-haskell
    :defvar (align-rules-list)
    :config
    (add-to-list 'align-rules-list
                 '(haskell-types
                   (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                   (modes quote (haskell-mode literate-haskell-mode))))
    (add-to-list 'align-rules-list
                 '(haskell-assignment
                   (regexp . "\\(\\s-+\\)=\\s-+")
                   (modes quote (haskell-mode literate-haskell-mode))))
    (add-to-list 'align-rules-list
                 '(haskell-arrows
                   (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                   (modes quote (haskell-mode literate-haskell-mode))))
    (add-to-list 'align-rules-list
                 '(haskell-left-arrows
                   (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
                   (modes quote (haskell-mode literate-haskell-mode))))
    )
  )

(leaf app-launcher
  :doc "Launch applications from Emacs"
  :req "emacs-27.1"
  :tag "out-of-MELPA" "emacs>=27.1"
  :url "https://github.com/sebastienwae/app-launcher"
  :added "2021-09-06"
  :emacs>= 27.1
  :el-get sebastienwae/app-launcher
  :when (executable-find "git")
  :require t
  :after orderless
  )


(leaf calfw
  :doc "Calendar view framework on Emacs"
  :tag "calendar"
  :url "https://github.com/kiwanami/emacs-calfw"
  :added "2021-09-05"
  :ensure t
  :disabled t
  :config
  (leaf calfw-org
    :doc "calendar view for org-agenda"
    :tag "org" "calendar"
    :added "2021-09-05"
    :ensure t
    :require t)
  (leaf calfw-ical
    :doc "calendar view for ical format"
    :tag "calendar"
    :added "2021-09-05"
    :ensure t
    :require t
    :config
    (load "calfw_functions" t)
    (add-hook 'calendar-load-hook (lambda ()
                                    (require 'japanese-holidays)
                                    (setq calendar-holidays
                                          (append japanese-holidays))))))

(leaf *cua
  :bind (("C-x SPC" . cua-set-rectangle-mark))
  :custom ((cua-mode . t)
           (cua-enable-cua-keys . nil)))

(leaf dabbrev
  :doc "dynamic abbreviation package"
  :tag "builtin"
  :added "2021-09-20"
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :custom (dabbrev-case-fold-search . nil))

(leaf ddskk
  :doc "Simple Kana to Kanji conversion program."
  :req "ccc-1.43" "cdb-20141201.754"
  :added "2021-09-05"
  :ensure t
  ;; :after ccc cdb
  :require skk skk-study
  :defvar (skk-user-directory skk-rom-kana-rule-list skk-katakana skk-j-mode skk-latin-mode)
  :defun skk-toggle-kana skk-hiragana-set skk-katakana-set
  :hook ((isearch-mode-hook . skk-isearch-mode-setup)
         (isearch-mode-end-hook . skk-isearch-mode-cleanup)
         (find-file-hooks . my/always-enable-skk-latin-mode-hook))
  :bind (("C-x j" . skk-mode)
         ("C-j" . nil)
         ("C-j" . skk-hiragana-set)
         ("C-\\" . skk-latin-mode)
         ("C-l" . skk-latin-mode)
         (minibuffer-local-map
          ("C-j" . skk-kakutei)
          ("C-l" . skk-latin-mode)))
  :custom `((skk-user-directory                 . "~/.emacs.d/ddskk")
            (skk-initial-search-jisyo           . "~/.emacs.d/ddskk/jisyo")
            (skk-large-jisyo                    . "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
            (skk-egg-like-newline               . t)
            (skk-delete-implies-kakutei         . t)
            (skk-henkan-strict-okuri-precedence . t)
            (skk-isearch-start-mode             . 'latin)
            (skk-search-katakana                . t))
  :init
  (setq skk-user-directory "~/.emacs.d/ddskk")
  ;; :config
  ;; (setq skk-rom-kana-rule-list
  ;;       (append skk-rom-kana-rule-list
  ;;               '(("ll" nil "っ")
  ;;                 ("xn" nil "ん")
  ;;                 ("xx" nil "っ")
  ;;                 ("z," nil ",")
  ;;                 ("z." nil ".")
  ;;                 ("z[" nil "[")
  ;;                 ("z]" nil "]")
  ;;                 ("z-" nil "-")
  ;;                 ("!" nil "!")
  ;;                 ("." nil "。")
  ;;                 ("," nil "、")
  ;;                 (":" nil ":")
  ;;                 (";" nil ";")
  ;;                 ("?" nil "?")
  ;;                 ("la" nil "ぁ" )
  ;;                 ("li" nil "ぃ" )
  ;;                 ("lu" nil "ぅ" )
  ;;                 ("le" nil "ぇ" )
  ;;                 ("lo" nil "ぉ" ))))
  :preface
  (defun skk-hiragana-set nil
    (interactive)
    (cond (skk-katakana
           (skk-toggle-kana nil))
          (t
           (skk-kakutei))))
  (defun skk-katakana-set nil
    (interactive)
    (cond (skk-katakana
           (lambda))
          (skk-j-mode
           (skk-toggle-kana nil))
          (skk-latin-mode
           (dolist (skk-kakutei (skk-toggle-kana nil))))))
  (defun my/always-enable-skk-latin-mode-hook ()
    (skk-latin-mode 1))
  )

(leaf git-gutter
  :doc "Port of Sublime Text plugin GitGutter"
  :req "emacs-24.4"
  :tag "emacs>=24.4"
  :url "https://github.com/emacsorphanage/git-gutter"
  :added "2021-10-02"
  :emacs>= 24.4
  :ensure t
  :custom-face ((git-gutter:modified . '((t (:background "#f1fa8c"))))
                (git-gutter:added . '((t (:background "#50fa7b"))))
                (git-gutter:deleted . '((t (:background "#ff79c6")))))
  :custom ((git-gutter:modified-sign . "~")
           (git-gutter:added-sign . "+")
           (git-gutter:deleted-sign . "-"))

  :global-minor-mode t)

(leaf highlight-indent-guides
  :doc "Minor mode to highlight indentation"
  :req "emacs-24.1"
  :tag "emacs>=24.1"
  :url "https://github.com/DarthFennec/highlight-indent-guides"
  :added "2021-09-05"
  :emacs>= 24.1
  :ensure t
  :unless (string-match "RaspberryPi" (system-name))
  :hook ((prog-mode-hook . highlight-indent-guides-mode))
  :custom '((highlight-indent-guides-method . 'column)))

(leaf *hs-minor-mode
  :hook ((emacs-lisp-mode-hook . hs-minor-mode-active))
  :bind (("C-'" . hs-toggle-hiding))
  :preface
  (defun hs-minor-mode-active ()
    (interactive)
    (hs-minor-mode 1)))

(leaf *hydra-config
  :doc "Make bindings that stick around."
  :req "cl-lib-0.5" "lv-0"
  :tag "bindings"
  :url "https://github.com/abo-abo/hydra"
  :added "2021-09-06"
  :hydra
  (hydra-pinky
   (global-map "s-j p")
   "pinky"
   ("n" next-line)
   ("p" previous-line)
   ("f" forward-char)
   ("b" backward-char)
   ("a" beginning-of-line)
   ("e" move-end-of-line)
   ("v" scroll-up-command)
   ("V" scroll-down-command)
   ("g" keyboard-quit)
   ("j" next-line)
   ("k" previous-line)
   ("l" forward-char)
   ("h" backward-char)
   ("o" other-window)
   ("r" avy-goto-word-1)
   ("s" consult-line)
   ("S" window-swap-states)
   ("q" kill-buffer)
   ("w" clipboard-kill-ring-save)
   ("," beginning-of-buffer)
   ("." end-of-buffer)
   ("SPC" set-mark-command)
   ("1" delete-other-windows)
   ("2" split-window-below)
   ("3" split-window-right)
   ("0" delete-window)
   ("x" delete-window)
   (";" consult-buffer)
   ("M-n" next-buffer)
   ("M-p" previous-buffer))
  (hydra-zoom
   (global-map "<f2>")
   "zoom"
   ("j" text-scale-increase "in")
   ("k" text-scale-decrease "out")
   ("l" text-scale-set "adjust"))
  )

(leaf japanese-holidays
  :doc "Calendar functions for the Japanese calendar"
  :req "emacs-24.1" "cl-lib-0.3"
  :tag "calendar" "emacs>=24.1"
  :url "https://github.com/emacs-jp/japanese-holidays"
  :added "2021-09-05"
  :emacs>= 24.1
  :ensure t
  :after calendar
  :defvar (calendar-day-header-array
           calendar-day-name-array
           calendar-holidays)

  :require japanese-holidays
  :hook ((calendar-today-visible-hook   . japanese-holiday-mark-weekend)
         (calendar-today-invisible-hook . japanese-holiday-mark-weekend)
         (calendar-today-visible-hook   . calendar-mark-today))
  :custom ((calendar-mark-holidays-flag     . t)
           (japanese-holiday-weekend        . '(0 6))
           (japanese-holiday-weekend-marker . '(holiday nil nil nil nil nil japanese-holiday-saturday))
           (org-agenda-include-diary        . t)
           (calendar-day-header-array       . ["日" "月" "火" "水" "木" "金" "土"])
           (calendar-day-name-array array   . ["日" "月" "火" "水" "木" "金" "土"])
           (calendar-month-header . '(propertize
                                      (format "%d年 %s月" year month)
                                      'font-lock-face 'calendar-month-header))
           `(calendar-holidays . ,(append japanese-holidays holiday-local-holidays holiday-other-holidays))
           )
  ;; :config
  ;; (setq calendar-holidays (append japanese-holidays holiday-local-holidays holiday-other-holidays))
  )

(leaf online-judge
  :when (executable-find "oj")
  :el-get ROCKTAKEY/emacs-online-judge
  :require t
  :custom ((online-judge-directories . '("~/Dropbox/atcoder/"))
           (online-judge-command-name . nil)))

(leaf page-ext
  :doc "extended page handling commands"
  :tag "builtin"
  :added "2021-09-05"
  :require t)

(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :added "2021-10-02"
  :ensure nil
  :commands show-paren-mode
  :hook ((after-init-hook . show-paren-mode))
  :custom-face ((show-paren-match . '((nil (:background "#44475a" :foreground "#f1fa8c")))))
  :custom ((show-paren-style . 'mixed)
           (show-paren-when-point-inside-paren . t)
           (show-paren-when-point-in-periphery . t)))

(leaf pulseaudio
  :when (executable-find "pactl")
  :el-get frenzieddoll/pulseaudio
  :require t
  )

(leaf rainbow-delimiters
  :doc "Highlight brackets according to their depth"
  :tag "tools" "lisp" "convenience" "faces"
  :url "https://github.com/Fanael/rainbow-delimiters"
  :added "2021-09-05"
  :ensure t
  :hook (emacs-lisp-mode-hook . rainbow-delimiters-mode))

(leaf recentf
  :init
  (leaf recentf-ext
    :doc "Recentf extensions"
    :tag "files" "convenience"
    :url "http://www.emacswiki.org/cgi-bin/wiki/download/recentf-ext.el"
    :added "2023-02-09"
    :ensure t
    )
  :custom
  `((recentf-save-file . "~/.emacs.d/recentf")
    (recentf-max-saved-items . 2000)
    (recentf-auto-cleanup . 'never)
    (recnetf-exclude . '("/recentf"
                         "COMMIT_EDITMSG"
                         "/.?TAGS"
                         "^/sudo:"
                         "/\\.emacs\\.d/games/*-scores"
                         "/\\.emacs\\.d/\\.cask/"
                         "~/Videos/Geheimnis/"))
    ;; (recentf-auto-cleanup-timer . (run-with-idle-timer 30 t 'recentf-save-list))
    )
  )

(leaf smartparens
  :doc "Automatic insertion, wrapping and paredit-like navigation with user defined pairs."
  :req "dash-2.13.0" "cl-lib-0.3"
  :tag "editing" "convenience" "abbrev"
  :url "https://github.com/Fuco1/smartparens"
  :added "2022-02-25"
  :ensure t
  :global-minor-mode (smartparens-strict-mode)
  :bind (("C-c s" . smartparens-strict-mode)
         (:smartparens-mode-map
          ("C-M-f" . sp-forward-sexp)
          ("C-M-b" . sp-backward-sexp)
          ("C-M-n" . sp-next-sexp)
          ("C-M-p" . sp-previous-sexp)
          ("C-M-a" . sp-beginning-of-sexp)
          ("C-M-e" . sp-end-of-sexp)
          ("M-["   . sp-backward-unwrap-sexp)
          ("M-]"   . sp-unwrap-sexp)))
  :config
  (sp-pair "'" "'" :actions :rem)
  (sp-pair "`" "`" :actions :rem)
  (sp-local-pair 'python-mode "'" "'")
  (sp-local-pair 'ein:ipynb-mode "'" "'")
  (sp-local-pair 'haskell-mode "`" "`"))

(leaf ssh
  :doc "Support for remote logins using ssh."
  :tag "comm" "unix"
  :added "2021-11-03"
  :ensure t)

(leaf sudo-edit
  :doc "Open files as another user"
  :req "emacs-24" "cl-lib-0.5"
  :tag "convenience" "emacs>=24"
  :url "https://github.com/nflath/sudo-edit"
  :added "2021-09-10"
  :emacs>= 24
  :ensure t)

(leaf undo-tree
  :doc "Treat undo history as a tree"
  :tag "tree" "history" "redo" "undo" "files" "convenience"
  :url "http://www.dr-qubit.org/emacs.php"
  :added "2021-09-05"
  :ensure t
  :unless (string-match "RaspberryPi" (system-name))
  :global-minor-mode t)

(leaf uniquify
  :doc "unique buffer names dependent on file name"
  :tag "builtin" "files"
  :added "2023-02-09"
  :custom
  ((uniquify-buffer-name-style . 'post-forward-angle-brackets)
   (uniquify-min-dir-content . 1)))

(leaf vertico
  :doc "VERTical Interactive COmpletion"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/vertico"
  :added "2021-09-05"
  :emacs>= 27.1
  :ensure t
  :require t
  ;; :disabled t
  :bind ((vertico-map
          ("?" . minibuffer-complition-help)
          ("M-RET" . minibuffer-force-complete-and-exit)
          ("M-TAB" . minibuffer-complete)
          ;; ("C-," . up-to-dir)
          ("C-," . vertico-directory-up)
          ("<mouse-3>" . vertico-exit)))
  :custom ((vertico-count . 15)
           (vertico-mouse-mode . t)
           ;; (vertico-preselect . 'prompt)
           )
  :global-minor-mode t
  ;; :preface
  ;; (defun up-to-dir ()
  ;;   "Move to parent directory like \"cd ..\" in find-file."
  ;;   (interactive)
  ;;   (let ((sep (eval-when-compile (regexp-opt '("/" "\\")))))
  ;;     (save-excursion
  ;;       (left-char 1)
  ;;       (when (looking-at-p sep)
  ;;         (delete-char 1)))
  ;;     (save-match-data
  ;;       (when (search-backward-regexp sep nil t)
  ;;         (right-char 1)
  ;;         (filter-buffer-substring (point)
  ;;                                  (save-excursion (end-of-line) (point))
  ;;                                  #'delete)))))
  )

(leaf consult
  :doc "Consulting completing-read"
  :req "emacs-26.1"
  :tag "emacs>=26.1"
  :url "https://github.com/minad/consult"
  :added "2021-09-05"
  :emacs>= 26.1
  :ensure t
  :bind (("M-g g" . consult-goto-line)
         ("C-x b" . consult-buffer)
         ("C-c i" . consult-imenu)
         ("M-y" . consult-yank-pop)
         ("C-o" . consult-line)
         ("C-c h" . consult-recent-file)
         ("M-g g" . consult-goto-line)
         ("C-x r l" . consult-bookmark)
         (minibuffer-local-map
          ("C-c h" . consult-history)))

  :custom `((consult-preview-key . nil))
  :global-minor-mode (recentf-mode)
  )
(leaf orderless
  :doc "Completion style for matching regexps in any order"
  :req "emacs-26.1"
  :tag "extensions" "emacs>=26.1"
  :url "https://github.com/oantolin/orderless"
  :added "2021-09-05"
  :emacs>= 26.1
  :ensure t
  :defvar (orderless-style-dispatchers)
  :custom ((completion-styles . '(basic  orderless))
           (completion-category-defaults . nil)
           (completion-category-overrides . nil)
           )
  )


(leaf marginalia
  :doc "Enrich existing commands with completion annotations"
  :req "emacs-26.1"
  :tag "emacs>=26.1"
  :url "https://github.com/minad/marginalia"
  :added "2021-09-06"
  :emacs>= 26.1
  :ensure t
  :unless (string= (system-name) "RaspberryPi")
  :config (marginalia-mode 1)
  )

(leaf embark
  :doc "Conveniently act on minibuffer completions"
  :req "emacs-26.1"
  :tag "convenience" "emacs>=26.1"
  :url "https://github.com/oantolin/embark"
  :added "2021-09-17"
  :emacs>= 26.1
  :ensure t
  :disabled t
  :bind (("s-e" . embark-act))
  ;; :custom ((prefix-help-command . #'embark-prefix-help-command))
  :config
  (leaf embark-consult
    :doc "Consult integration for Embark"
    :req "emacs-26.1" "embark-0.12" "consult-0.10"
    :tag "convenience" "emacs>=26.1"
    :url "https://github.com/oantolin/embark"
    :added "2022-03-24"
    :emacs>= 26.1
    :ensure t))

(leaf savehist
  :doc "Save minibuffer history"
  :tag "builtin"
  :added "2021-09-05"
  :global-minor-mode t)

(leaf *mySaveFrame
    :when (or (eq system-type 'darwin)
              (eq system-type 'windows-nt))
    :hook ((emacs-startup-hook . my-load-frame-size)
           (kill-emacs-hook . my-save-frame-size))
    :defun my-save-frame-size my-load-frame-size
    :defvar my-save-frame-file
    :custom ((my-save-frame-file . "~/.emacs.d/.framesize"))
    :preface
    (defun my-save-frame-size ()
      "現在のフレームの位置、大きさを'my-save-frame-file'に保存します"
      (interactive)
      (let* ((param (frame-parameters (selected-frame)))
             (current-height (frame-height))
             (current-width (frame-width))
             (current-top-margin (if (integerp (cdr (assoc 'top param)))
                                     (cdr (assoc 'top param))
                                   0))

             (current-left-margin (if (integerp (cdr (assoc 'top param)))
                                      (cdr (assoc 'top param))
                                    0))
             (buf nil)
             (file my-save-frame-file))
        ;; ファイルと関連付けられてたバッファ作成
        (unless (setq buf (get-file-buffer (expand-file-name file)))
          (setq buf (find-file-noselect (expand-file-name file))))
        (set-buffer buf)
        (erase-buffer)
        ;; ファイル読み込み時に直接評価させる内容を記述
        (insert
         (concat
          "(set-frame-size (selected-frame) "(int-to-string current-width)" "(int-to-string current-height)")\n"
          "(set-frame-position (selected-frame) "(int-to-string current-left-margin)" "(int-to-string current-top-margin)")\n"
          ))
        (save-buffer)))
    (defun my-load-frame-size ()
      "`my-save-fram-file'に保存されたフレームの位置、大きさを復元します"
      (interactive)
      (let ((file my-save-frame-file))
        (when (file-exists-p file)
          (load-file file))))
    :config
    (run-with-idle-timer 60 t 'my-save-frame-size)
    )

(leaf corfu
  :doc "Completion Overlay Region FUnction"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/corfu"
  :added "2021-09-11"
  :emacs>= 27.1
  :ensure t
  ;; :require t
  ;; :defvar (corfu-auto)
  :when (eq window-system 'x)
  :hook ((minibuffer-setup-hook . my/corfu-enable-in-minibuffer)
         (eshell-mode-hook . (lambda ()
                               (setq-local corfu-auto nil)
                               (corfu-mode)))
         (corfu-mode . corfu-popupinfo-mode)
         )
  :global-minor-mode global-corfu-mode
  :custom ((tab-always-indent        . 'complete)
           (corfu-cycle              . t)
           (corfu-auto               . t)
           (corfu-auto-prefix        . 3)
           (corfu-auto-delay         . 0.01)
           ;; (corfu-quit-no-match   . 'separator)
           ;; (corfu-separator       . ? \s)
           ;; (corfu-preselect-first . nil)
           )
  :bind
  ((corfu-map
    ("M-SPC" . corfu-insert-separator)))
  :init
  (defun my/corfu-enable-in-minibuffer ()
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (setq-local corfu-auto nil)
      (corfu-mode 1)))
  (defun my/corfu-insert-and-send ()
    (interactive)
    (corfu-insert)
    (cond
     ((and (derived-mode-p 'eshell-mode) (fboundp 'eshell-send-input))
      (eshell-send-input)
      ((derived-mode-p 'comint-mode)
       (comint-send-input)))))
  :global-minor-mode global-corfu-mode
  )

(leaf kind-icon
  :doc "Completion kind icons"
  :req "emacs-27.1" "svg-lib-0"
  :tag "completion" "emacs>=27.1"
  :url "https://github.com/jdtsmith/kind-icon"
  :added "2022-11-26"
  :emacs>= 27.1
  :ensure t
  :disabled t
  :when (eq window-system 'x)
  :after corfu
  :pre-setq (kind-icon-defalut-face . 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(leaf tempel
  :doc "Tempo templates/snippets with in-buffer field editing"
  :req "emacs-27.1" "compat-29.1.4.0"
  :tag "wp" "tools" "languages" "abbrev" "emacs>=27.1"
  :url "https://github.com/minad/tempel"
  :added "2023-11-10"
  :emacs>= 27.1
  :ensure t
  :after corfu
  :bind (("C-+" . tempel-complete)
         ("C-*" . tempel-insert)
         (tempel-map
          ("C-S-n" . tempel-next)
          ("C-S-p" . tempel-previous)
          ("C-RET" . tempel-done)
          )
         )
  :config
  (leaf tempel-collection
    :doc "Collection of templates for Tempel"
    :req "tempel-0.5" "emacs-29.1"
    :tag "tools" "emacs>=29.1"
    :url "https://github.com/Crandel/tempel-collection"
    :added "2023-11-10"
    :emacs>= 29.1
    :ensure t
    :after tempel)
  )

(leaf cape
  :doc "Completion At Point Extensions"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/cape"
  :added "2022-03-31"
  :emacs>= 27.1
  :ensure t
  ;; :after corfu
  ;; :disabled t
  :hook ((ein:notebook-mode-hook . my/set-ein-capf))
  :config
  (add-to-list 'completion-at-point-functions #'tempel-complete)
  (add-to-list 'completion-at-point-functions #'cape-file t)
  (add-to-list 'completion-at-point-functions #'cape-dict t)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-to-list 'completion-at-point-functions #'cape-tex)
  :init
  (defun my/convert-super-capf (arg-capf)
    (list (cape-capf-noninterruptible
           (cape-capf-accept-all
            (cape-capf-buster arg-capf
                              #'cape-file
                              )))
          #'cape-dict))

  (defun my/set-ein-capf ()
    (interactive)
    ;; (setq-local completion-at-point-functions
    ;;             (my/convert-super-capf (cape-company-to-capf #'company-jedi)))
    (setq-local completion-at-point-functions
                (list (cape-capf-noninterruptible
                       (cape-capf-accept-all
                        (cape-capf-buster
                         (cape-company-to-capf #'company-jedi))))))
    (add-to-list 'completion-at-point-functions #'cape-file t)
    (add-to-list 'completion-at-point-functions #'cape-dict t)
    )
  (defun my/reset-capf ()
    (interactive)
    (setq completion-at-point-functions
          (list (cape-capf-noninterruptible
                 (cape-capf-accept-all
                  (cape-capf-buster
                   (cape-super-capf #'cape-elisp-symbol))))))
    )
  )

(leaf *emacs
  :preface
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(leaf visual-regexp-steroids
  :doc "Extends visual-regexp to support other regexp engines"
  :req "visual-regexp-1.1"
  :tag "feedback" "visual" "python" "replace" "regexp" "foreign" "external"
  :url "https://github.com/benma/visual-regexp-steroids.el/"
  :added "2021-09-05"
  :ensure t
  :after visual-regexp
  :bind (("M-%" . vr/query-replace)
         ;; multiple-cursorsを使っているならこれで
         ("C-c m" . vr/mc-mark)
         ;; 普段の正規表現isearchにも使いたいならこれを
         ("C-M-r" . vr/isearch-backward)
         ("C-M-s" . vr/isearch-forward))
  :custom `((vr/engine . 'python)))

(leaf vterm
  :doc "Fully-featured terminal emulator"
  :req "emacs-25.1"
  :tag "terminals" "emacs>=25.1"
  :url "https://github.com/akermu/emacs-libvterm"
  :added "2023-02-19"
  :emacs>= 25.1
  :ensure t
  :when (string= system-type 'gnu/linux)
  :custom ((vterm-max-scrollback . 10000)
           (vterm-buffer-name-string . "vterm: %s")
           )
  :bind (("C-c v" . multi-vterm)
         ;; ("s-v"   . multi-vterm)
         (:vterm-mode-map
          ("C-m" . vterm-send-return)
          ("C-h" . vterm-send-backspace)
          ("C-y" . vterm-yank)
          ))
  :config
  (leaf multi-vterm
    :doc "Like multi-term.el but for vterm"
    :req "emacs-26.3" "vterm-0.0" "project-0.3.0"
    :tag "processes" "terminals" "emacs>=26.3"
    :url "https://github.com/suonlight/multi-libvterm"
    :added "2023-03-12"
    :emacs>= 26.3
    :ensure t
    :after vterm project)
  )

(leaf which-key
  :doc "Display available keybindings in popup"
  :req "emacs-24.4"
  :tag "emacs>=24.4"
  :url "https://github.com/justbur/emacs-which-key"
  :added "2021-09-12"
  :emacs>= 24.4
  :ensure t
  :custom
  (which-key-setup-side-window-bottom)
  :global-minor-mode which-key-mode
  )

(leaf yasnippet
  :doc "Yet another snippet extension for Emacs"
  :req "cl-lib-0.5"
  :tag "emulation" "convenience"
  :url "http://github.com/joaotavora/yasnippet"
  :added "2021-09-05"
  :ensure t
  ;; :disabled t
  :hook ((emacs-lisp-mode-hook
          org-mode-hook
          yatex-mode-hook
          haskell-mode-hook
          web-mode-hook
          python-mode-hook
          sh-mode-hook) . yas-minor-mode)
  :unless (string-match "Raspberrypi" (system-name))
  ;; :custom ((yas-global-mode . t))
  :bind ((yas-minor-mode-map
          ("C-." . consult-yasnippet)))
  ;; :custom ((yas-snippet-dirs . '("~/.emacs.d/elpa/yasnippet-snippets-20220713.1234/snippets/")))
  :config
  (leaf consult-yasnippet
    :doc "A consulting-read interface for yasnippet"
    :req "emacs-27.1" "yasnippet-0.14" "consult-0.16"
    :tag "emacs>=27.1"
    :url "https://github.com/mohkale/consult-yasnippet"
    :added "2022-09-04"
    :emacs>= 27.1
    :ensure t
    :after yasnippet consult)
  (leaf yasnippet-snippets
    :doc "Collection of yasnippet snippets"
    :req "yasnippet-0.8.0"
    :tag "snippets"
    :url "https://github.com/AndreaCrotti/yasnippet-snippets"
    :added "2022-09-04"
    :ensure t
    :after yasnippet)
  (leaf haskell-snippets
    :doc "Yasnippets for Haskell"
    :req "cl-lib-0.5" "yasnippet-0.8.0"
    :tag "haskell" "snippets"
    :url "https://github.com/haskell/haskell-snippets"
    :added "2023-02-18"
    :ensure t
    :after yasnippet)
  (leaf py-snippets
    :doc "Collection of advanced Python yasnippet snippets"
    :req "yasnippet-0.8.0"
    :tag "snippets" "convenience"
    :url "https://github.com/Xaldew/py-snippets"
    :added "2023-02-18"
    :ensure t
    :after yasnippet)
  )

(leaf zoom-window
  :doc "Zoom window like tmux"
  :req "emacs-24.3"
  :tag "emacs>=24.3"
  :url "https://github.com/syohex/emacs-zoom-window"
  :added "2021-09-05"
  :emacs>= 24.3
  :ensure t
  :custom (zoom-window-mode-line-color . "#5E81AC")
  )


;; プログラミング設定
(leaf *clang
  :bind (cc-mode-map
         ("C-c c" . compile))
  )

(leaf eglot
  :doc "The Emacs Client for LSP servers"
  :req "emacs-26.3" "jsonrpc-1.0.14" "flymake-1.2.1" "project-0.3.0" "xref-1.0.1" "eldoc-1.11.0" "seq-2.23"
  :tag "languages" "convenience" "emacs>=26.3"
  :url "https://github.com/joaotavora/eglot"
  :added "2023-02-09"
  :emacs>= 26.3
  :ensure t
  :disabled t
  :custom `((read-process-output-max       . ,(* 1024 1024))
            (completion-category-overrides . '((eglot (styles orderless))))
            )
  ;; :config
  ;; (setq read-process-output-max (* 1024 1024))
  ;; (setq completion-category-overrides '((eglot (styles orderless))))
  )

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :added "2022-04-04"
  :emacs>= 24.3
  :ensure t
  :unless (or (string= (system-name) "sx12toshiaki-wsl")
              (string= (system-name) "sx12_toshiaki"))
  :disabled t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error)))

(leaf haskell-mode
  :doc "A Haskell editing mode"
  :req "emacs-25.1"
  :tag "haskell" "files" "faces" "emacs>=25.1"
  :url "https://github.com/haskell/haskell-mode"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :defvar haskell-process-args-ghcie
  :custom `(;; (flymake-proc-allowed-file-name-masks . ,(delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
            (haskell-process-type          . 'cabal-repl)
            ;; (haskell-process-path-ghci     . "")
            ;; (haskell-process-args-ghcie    . "ghci")
            (haskell-indent-offset                  . 4)
            (haskell-indendt-spaces                 . 4)
            (haskell-compile-stack-build-command    . t)
            (haskell-process-suggest-hoogle-imports . t)
            (haskell-indent-after-keywords          . '(("where" 4 0)
                                                        ("of" 4)
                                                        ("do" 4)
                                                        ("mdo" 4)
                                                        ("rec" 4)
                                                        ("in" 4 0)
                                                        ("{" 4)
                                                        "if"
                                                        "then"
                                                        "else"
                                                        "let"))
            ;; (haskell-hoogle-command              . nil)
            ;; (haskell-hoogle-url                  . "https://www.stackage.org/lts/hoogle?q=%s")
            )
  :bind `((haskell-mode-map
           ("C-c C-z" . haskell-interactive-bring)
           ("C-c C-l" . haskell-process-load-file)
           ("C-c C-," . haskell-mode-format-imports)
           ("<f5>"    . haskell-compile)
           ("<f8>"    . haskell-navigate-imports)))
  :hook ((haskell-mode-hook . interactive-haskell-mode)
         (haskell-mode-hook . haskell-doc-mode)
         (haskell-mode-hook . haskell-indentation-mode)
         ;; (haskell-mode-hook . haskell-auto-insert-module-template)
         (haskell-mode-hook . haskell-decl-scan-mode)
         (haskell-mode-hook . lsp)
         ;; (haskell-mode-hook . flycheck-mode)
         ;; (haskell-literate-mode . lsp)
         )
  :config
  (leaf lsp-haskell
    :doc "Haskell support for lsp-mode"
    :req "emacs-24.3" "lsp-mode-3.0" "haskell-mode-16.1"
    :tag "haskell" "emacs>=24.3"
    :url "https://github.com/emacs-lsp/lsp-haskell"
    :added "2023-02-10"
    :emacs>= 24.3
    :ensure t
    ;; :disabled t
    :custom ((lsp-haskell-server-path . "haskell-language-server-wrapper")
             (lsp-haskell-completion-snippets-on . nil)
             )
    )
  )

(leaf lsp-mode
  :doc "LSP mode"
  :req "emacs-26.1" "dash-2.18.0" "f-0.20.0" "ht-2.3" "spinner-1.7.3" "markdown-mode-2.3" "lv-0"
  :tag "languages" "emacs>=26.1"
  :url "https://github.com/emacs-lsp/lsp-mode"
  :added "2021-11-06"
  :emacs>= 26.1
  :ensure t
  ;; :disabled t
  ;; :el-get emacs-lsp/lsp-mode
  ;; :unless (string-match "Raspberrypi" (system-name))
  :custom ((lsp-keymap-prefix                      . "C-z")
           ;; (lsp-idle-delay                         . 0.500)
           (lsp-log-io                             . nil)
           (lsp-completion-provider                . :none)
           ;; (lsp-prefer-capf                        . t)
           (lsp-headerline-breadcrumb-icons-enable . nil)
           (lsp-enable-snippet                     . nil))
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless)))
  :hook (
         (lsp-mode-hook            . lsp-enable-which-key-integration)
         ;; (lsp-completion-mode-hook . my/lsp-mode-setup-completion)
         (haskell-mode-hook        . lsp)
         ;; (haskell-mode-hook        . flycheck-mode)
         (rustic-mode-hook         . lsp)
         (c-mode-hook              . lps)
         (c++-mode-hook            . lsp)
         )
  :config
  (leaf lsp-ui
    :doc "UI modules for lsp-mode"
    :req "emacs-26.1" "dash-2.18.0" "lsp-mode-6.0" "markdown-mode-2.3"
    :tag "tools" "languages" "emacs>=26.1"
    :url "https://github.com/emacs-lsp/lsp-ui"
    :added "2021-11-06"
    :emacs>= 26.1
    :ensure t
    ;; :disabled t
    :hook ((lsp-mode-hook . lsp-ui-mode))
    :commands lsp-ui-mode)
  (leaf lsp-treemacs
    :doc "LSP treemacs"
    :req "emacs-26.1" "dash-2.18.0" "f-0.20.0" "ht-2.0" "treemacs-2.5" "lsp-mode-6.0"
    :tag "languages" "emacs>=26.1"
    :url "https://github.com/emacs-lsp/lsp-treemacs"
    :added "2021-12-21"
    :emacs>= 26.1
    ;; :disabled t
    :ensure t
    :custom ((lsp-treemacs-sync-mode . 1)))
  (leaf consult-lsp
    :doc "LSP-mode Consult integration"
    :req "emacs-27.1" "lsp-mode-5.0" "consult-0.9" "f-0.20.0"
    :tag "lsp" "completion" "tools" "emacs>=27.1"
    :url "https://github.com/gagbo/consult-lsp"
    :added "2021-11-08"
    :emacs>= 27.1
    ;; :disabled t
    :ensure t)
  )

(leaf python-mode
  :doc "Python major mode"
  :tag "oop" "python" "processes" "languages"
  :url "https://gitlab.com/groups/python-mode-devs"
  :added "2021-09-11"
  :ensure t
  :config
  )

(leaf quickrun
  :doc "Run commands quickly"
  :req "emacs-24.3"
  :tag "emacs>=24.3"
  :url "https://github.com/syohex/emacs-quickrun"
  :added "2021-11-06"
  :emacs>= 24.3
  :ensure t)

(leaf purescript-mode
  :doc "A PureScript editing mode"
  :req "emacs-25.1"
  :tag "purescript" "files" "faces" "emacs>=25.1"
  :url "https://github.com/purescript-emacs/purescript-mode"
  :added "2022-12-14"
  :emacs>= 25.1
  :ensure t
  ;; :bind `((purescript-mode-map
  ;;           ("C-c C-z" . purescript-interactive-switch)
  ;;           ("C-c C-l" . purescript-process-load-file)
  ;;           ("C-c C-b" . purescript-interactive-switch)
  ;;           ("C-c C-t" . purescript-process-do-type)
  ;;           ("C-c C-i" . purescript-process-do-info)))
  :hook ((purescript-mode-hook . lsp))
  )

(leaf rustic
  :doc "Rust development environment"
  :req "emacs-26.1" "dash-2.13.0" "f-0.18.2" "let-alist-1.0.4" "markdown-mode-2.3" "project-0.3.0" "s-1.10.0" "seq-2.3" "spinner-1.7.3" "xterm-color-1.6"
  :tag "languages" "emacs>=26.1"
  :added "2021-11-06"
  :emacs>= 26.1
  :ensure t
  :mode (("\\.rs\\'" . rust-mode))
  :hook ((rustic-mode-hook . smartparens-mode)
         (rustic-mode-hook . lsp))
  ;; :custom ((rustic-format-trigger . 'on-save))
  :bind ((rustic-mode-map
          ("M-j" . lsp-ui-imenu)
          ("M-?" . lsp-find-references)
          ("C-c C-c l" . flycheck-list-errors)
          ("C-c C-c a" . lsp-execute-code-action)
          ("C-c C-c r" . lsp-rename)
          ("C-c C-c q" . lsp-workspace-restart)
          ("C-c C-c Q" . lsp-workspace-shutdown)
          ("C-c C-c s" . lsp-rust-analyzer-status)))
  :config
  (leaf cargo
    :doc "Emacs Minor Mode for Cargo, Rust's Package Manager."
    :req "emacs-24.3" "markdown-mode-2.4"
    :tag "tools" "emacs>=24.3"
    :added "2022-11-25"
    :emacs>= 24.3
    :ensure t
    :hook (rust-mode . cargo-minor-mode)
    )
  )

(leaf web-mode
  :doc "major mode for editing web templates"
  :req "emacs-23.1"
  :tag "languages" "emacs>=23.1"
  :url "https://web-mode.org"
  :added "2022-09-03"
  :emacs>= 23.1
  :ensure t
  :hook (web-mode-hook . smartparens-mode)
  :mode ((("\\.html\\'" "\\.js\\'" "\\.mustache\\'") . web-mode))
  :custom ((web-mode-markup-indent-offset . 4)
           (web-mode-css-indent-offset . 4)
           (web-mode-enable-current-element-highlight . t)
           (web-mode-enable-auto-pairing . t)
           (web-mode-enable-auto-closing . t)))

;; window managr
(leaf *exwm-config
  ;; :disabled t
  :when (string= (getenv "EXWM") "enable")
  :when (eq system-type 'gnu/linux)
  ;; :when (string= "archlinuxhonda" (system-name))
  :init
  (server-start)
  :config
  (leaf exwm
    :ensure t
    :ensure exwm-x
    :require exwm
    :defun (exwm-workspace-rename-buffer exwm-workspace-toggle exwm-randr-enable exwm-input-set-local-simulation-keys)
    :defvar (exwm-workspace-current-index exwm-class-name)
    :hook ((exwm-update-class-hook . (lambda ()
                                       (exwm-workspace-rename-buffer exwm-class-name)))
           (exwm-mana-finish-hook . (lambda ()
                                      (when (and exwm-class-name
                                                 (string= exwm-class-name "Alacritty"))
                                        (exwm-input-set-local-simulation-keys nil)))))

    :custom `((use-dialog-box                     . nil)
              (window-divider-default-right-width . 1)
              (exwm-workspace-show-all-buffers    . t)
              (exwm-layout-show-all-buffers       . t)
              (exwm-workspace-number              . 3)
              (exwm-input-global-keys . '(;; 自前の関数
                                          (,(kbd "s-r")     . exwm-reset)
                                          (,(kbd "s-<tab>") . exwm-workspace-toggle)
                                          (,(kbd "s-q")     . kill-current-buffer)
                                          (,(kbd "s-h")     . delete-window)
                                          (,(kbd "s-SPC")   . exwm-floating-toggle-floating)
                                          (,(kbd "s-e")     . exwm-input-toggle-keyboard)
                                          (,(kbd "s-r")     . exwm-reset)
                                          (,(kbd "C-j")     . ,(kbd "C-`"))
                                          (,(kbd "C-l")     . ,(kbd "C-\\"))
                                          ;; (,(kbd "C-j")     . ,(kbd "C-,"))
                                          ;; (,(kbd "C-l")     . ,(kbd "C-."))
                                          ,@(mapcar (lambda (i)
                                                      `(,(kbd (format "s-%d" i)) .
                                                        (lambda ()
                                                          (interactive)
                                                          (exwm-workspace-switch-create ,i))))
                                                    (number-sequence 0 9))
                                          ;; 他のアプリの関数
                                          (,(kbd "s-n")     . windmove-down)
                                          (,(kbd "s-f")     . windmove-right)
                                          (,(kbd "s-b")     . windmove-left)
                                          (,(kbd "s-p")     . windmove-up)
                                          (,(kbd "C-s-i")   . pulseaudio-select-sink-by-name)
                                          (,(kbd "C-s-m")   . pulseaudio-toggle-sink-mute)
                                          (,(kbd "C-s-n")   . pulseaudio-decrease-sink-volume)
                                          (,(kbd "C-s-p")   . pulseaudio-increase-sink-volume)
                                          (,(kbd "s-[")     . lowerLight)
                                          (,(kbd "s-]")     . upperLight)
                                          (,(kbd "s-d")     . app-launcher-run-app)
                                          (,(kbd "s-a")     . zoom-window-zoom)
                                          (,(kbd "s-o")     . consult-buffer)
                                          (,(kbd "C-x r l") . consult-bookmark)
                                          (,(kbd "M-!")     . shell-command)
                                          (,(kbd "s-S")     . window-capcher)
                                          ;; (,(kbd "<mouse-8>")    . keyboard-quit)
                                          (,(kbd "<mouse-10>")   . pulseaudio-increase-sink-volume)
                                          (,(kbd "<mouse-11>")   . pulseaudio-decrease-sink-volume)
                                          (,(kbd "<mouse-12>")   . app-launcher-run-app)
                                          ))
              (exwm-input-simulation-keys . '(;; new version
                                              (,(kbd "C-b")           . [left])
                                              (,(kbd "M-b")           . [C-left])
                                              (,(kbd "C-f")           . [right])
                                              (,(kbd "M-f")           . [C-right])
                                              (,(kbd "C-p")           . [up])
                                              (,(kbd "C-n")           . [down])
                                              (,(kbd "C-a")           . [home])
                                              (,(kbd "C-e")           . [end])
                                              (,(kbd "M-v")           . [prior])
                                              (,(kbd "C-v")           . [next])
                                              (,(kbd "C-d")           . [delete])
                                              (,(kbd "C-k")           . [S-end ?\C-x])
                                              (,(kbd "M-<")           . [C-home])
                                              (,(kbd "M->")           . [C-end])
                                              (,(kbd "C-/")           . [C-z])
                                              ;; C-h は特別扱い扱い
                                              ([?\C-h]                . [backspace])
                                              (,(kbd "C-m")           . [return])
                                              (,(kbd "C-/")           . [C-z])
                                              (,(kbd "C-S-f")         . [S-right])
                                              (,(kbd "C-S-b")         . [S-left])
                                              (,(kbd "C-S-p")         . [S-up])
                                              (,(kbd "C-S-n")         . [S-down])
                                              (,(kbd "C-w")           . ,(kbd "C-x"))
                                              (,(kbd "M-w")           . ,(kbd "C-c"))
                                              (,(kbd "C-y")           . ,(kbd "C-v"))
                                              (,(kbd "s-v")           . ,(kbd "C-v"))
                                              (,(kbd "C-x h")         . ,(kbd "C-a"))
                                              (,(kbd "M-d")           . [C-S-right ?\C-x])
                                              (,(kbd "M-<backspace>") . [C-S-left ?\C-x])
                                              ;; search
                                              (,(kbd "C-s")           . ,(kbd "C-f"))
                                              ;; escape
                                              (,(kbd "C-g")           . [escape])
                                              ;; like mac
                                              (,(kbd "s-w")           . [C-w])
                                              ([s-left]               . [C-S-tab])
                                              ([s-right]              . [C-tab])
                                              ;; ([s-up] . [C-tab])
                                              ;; ([s-down] . [C-tab])
                                              (,(kbd "s-t")           . [C-t ?\C-k])
                                              (,(kbd "s-T")           . [C-T])

                                              (,(kbd "s-l")           . [C-k])
                                              (,(kbd "s-k")           . [C-l])
                                              ;;
                                              (,(kbd "C-x C-s")       . [C-s])
                                              (,(kbd "C-u C-/")       . [C-y])
                                              ;; (,(kbd "C-j")           .,(kbd "C-<"))
                                              ;; (,(kbd "C-l")           .,(kbd "C->"))
                                              (,(kbd "C-c C-c")       . ,(kbd "C-c"))
                                              )))
    :bind (("C-\\" . skk-latin-mode)
           ("C-l" . skk-latin-mode))
    :init
    (defun exwm-workspace-toggle ()
      (interactive)
      (if (= exwm-workspace-current-index 0)
          (exwm-workspace-switch 1)
        (exwm-workspace-switch 0)))

    :config
    ;; (exwmx-floating-smart-hide)
    ;; (exwmx-button-enable)
    (leaf exwm-systemtray
      :require t
      :defun exwm-systemtray-enable
      ;; :custom (exwm-systemtray-height . 50)
      :config
      (exwm-systemtray-enable))
    (leaf exwm-randr
      :disabled t
      :require t
      :when (string= (system-name) "archlinuxhonda")
      :custom ((exwm-randr-workspace-monitor-plist . '(0 "DP-2" 1 "DP-2" 2 "DP-2" 3 "DP-2" 4 "DP-2" 5 "DP-2")))
      :hook ((exwm-randr-screen-change-hook . (lambda ()
                                                (start-process-shell-command
                                                 ;; "xrandr" nil "xrandr --output DP-2 --auto --output HDMI-0 --auto --right-of DP-2; xrandr --output HDMI-0 --auto --scale 1.5x1.5")
                                                 "xrandr" nil "xrandr --output DP-2")
                                                )))
      :config
      (exwm-randr-enable))
    ;; (leaf *fix_ediff
    ;;   :after ediff-wind
    ;;   :custom `((ediff-window-setup-function . 'ediff-setup-windows-plain)))
    (leaf exwm-enable
      :defun (exwm-enable)
      :config
      (exwm-enable))
    )
  )

(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
