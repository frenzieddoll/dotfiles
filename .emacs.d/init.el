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
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
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

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; 必要なPackageのInstall
(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imuenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c j" . macrostep-expand)))


;; 起動初期設定
(leaf *add-to-load-path
  :load-path `(,(mapcar (lambda (elm)
                          (concat user-emacs-directory elm))
                        '("elisp" "conf" "public_repos")))
  :config
  (leaf private-path
    :when (file-directory-p "~/Doropbox/private/elisp")
    :load-path "~/Doropbox/private/elisp"))

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

(leaf *cus-start
  :doc "define customization properties of builtins"
  :url "http://handlename.hatenablog.jp/entry/2011/12/11/214923" ; align sumple
  :defvar show-paren-deley
  :custom `(;; GC
            (garbage-collection-messages           . t)
            ;; 表示
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
            (next-line-add-newlines                . nil)  ;; バッファ終端で newline を入れない
            (read-file-name-completion-ignore-case . t)  ; 大文字小文字区別無し
            ;; undo/redo - 数字に根拠無し
            (undo-limit                            . 200000)
            (undo-strong-limit                     . 260000)
            (history-length                        . t)  ;; 無制限(の筈)
            (create-lockfiles                      . nil)
            (use-dialog-box                        . nil)
            (use-file-dialog                       . nil)
            (frame-resize-pixelwise                . t)
            (enable-recursive-minibuffers          . t)
            (history-length                        . 1000)
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
            ;; auto-fill-modeを切る
            (auto-fill-mode                        . nil)
            ;; 補完で大文字小文字無視
            (read-file-name-completion-ignore-case . t)
            ;; ミニバッファの履歴を保存する
            (savehist-mode                         . 1)
            (history-length                        . 30000)
            ;;
            (history-delete-duplicates             . t)
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

            ;; キルリングの設定(scratchの設定に書いていた)
            (kill-ring-max                . 100)
            (kill-read-only-ok            . t)
            (kill-whole-line              . t)
            (eval-expression-print-length . nil)
            (eval-expression-print-level  . nil)
            (auto-revert-interval . 0.1)
            (global-auto-revert-mode . t))
  :config
  (set-face-background 'region "#555")
  (run-with-idle-timer 60.0 t #'garbage-collect)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (leaf *gc-cons-threshold-arch
    :when (string-match (system-name) "archlinuxhonda")
    :custom `((gc-cons-threshold . ,(* 1024 1024 1024))))
  (leaf *gc-cons-threshold-arch-laptop
    :when (string-match (system-name) "ArchLinuxonLaptopPC")
    :custom `((gc-cons-threshold . ,(* 64 1024 1024))))
  (leaf *gc-cons-threshold-mac
    :when (string= system-type "darwin")
    :custom `((gc-cons-threshold . ,(* 32 1024 1024))))
  (leaf *gc-cons-threshold-pi
    :when (string= (system-name) "RaspberryPi")
    :custom `((gc-cons-threshold . ,(* 16 1024 1024)))))

(leaf *fontSetting
  :config
  (leaf *forArchlinux
    :when (eq system-type 'gnu/linux)
    :when (string-match (system-name) "archlinuxhonda")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 140))
  (leaf *forLinux
    :when (eq system-type 'gnu/linux)
    :unless (string-match (system-name) "archlinuxhonda")
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 140))
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
    :when (string= (getenv "EXWM") "enable" )
    :config
    (set-face-attribute 'default nil
                        :family "HackGen"
                        :height 120)
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      (font-spec :family "HackGen"
                                 :height 120))))

(leaf *hooks
  :hook  ((before-save-hook . delete-trailing-whitespace))
  )

(leaf *scratch
  :hook  ((kill-buffer-query-functions . (lambda ()
                                           (if (string= "*scratch*" (buffer-name))
                                               (progn (my:make-scratch 0) nil)
                                             t)))
          (after-save-hook . (lambda ()
                               (unless (member "*scratch*" (my:buffer-name-list))
                                 (my:make-scratch 1)))))

  :preface
  (defun my:make-scratch (&optional arg)
    (interactive)
    (progn
      ;; "*scratch*" を作成して buffer-list に放り込む
      (set-buffer (get-buffer-create "*scratch*"))
      (funcall initial-major-mode)
      (erase-buffer)
      (when (and initial-scratch-message (not inhibit-startup-message))
        (insert initial-scratch-message))
      (or arg
          (progn
            (setq arg 0)
            (switch-to-buffer "*scratch*")))
      (cond ((= arg 0) (message "*scratch* is cleared up."))
            ((= arg 1) (message "another *scratch* is created")))))
  (defun my:buffer-name-list ()
    (mapcar (function buffer-name) (buffer-list))))

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
  (leaf dired-open
    :doc "Open files from dired using using custom actions"
    :req "dash-2.5.0" "dired-hacks-utils-0.0.1"
    :tag "files"
    :added "2021-09-05"
    :ensure t
    :require t
    :when (eq system-type 'gnu/linux)
    :custom ((dired-open-extensions .
                                    '(("mkv"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mp4"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("avi"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("wmv"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("webm"     . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mpg"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("flv"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("m4v"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mp3"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("wav"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("m4a"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("3gp"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("rm"       . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("rmvb"     . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mpeg"     . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("VOB"      . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
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
                                      ("jpg"      . "sxiv-rifle")
                                      ("png"      . "sxiv-rifle")
                                      ("jpeg"     . "sxiv-rifle")
                                      ("gif"      . "sxiv-rifle")
                                      ("png"      . "sxiv-rifle")))))
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

  :preface
  (defun kill-current-buffer-and/or-dired-open-file ()
    "In Dired, dired-open-file for a file. For a directory, dired-find-file and kill previously selected buffer."
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
  :hook (eshell-mode-hook . eshell-alias)
  :defvar eshell-command-aliases-list
  ;; :custom `((eshell-command-aliase-list . '(list '(list "ll" "ls -ltrh")
  ;;                                                 '(list "la" "ls -a")
  ;;                                                 '(list "o" "xdg-open")
  ;;                                                 '(list "emacs" "find-file $1")
  ;;                                                 '(list "m" "find-file $1")
  ;;                                                 '(list "mc" "find-file $1")
  ;;                                                 '(list "d" "dired .")
  ;;                                                 '(list "l" "eshell/less $1")
  ;;                                                 '(list "translate" "~/python/translate.py")
  ;;                                                 '(list "pacmandate" "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1")
  ;;                                                 '(list "manga" "wine ~/Documents/Software/picture/MangaMeeya_73/MangaMeeya.exe")
  ;;                                                 '(list "backup" "~/.emacs.d/script/backup.sh $1")
  ;;                                                 '(list "nvidiafix" "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
  ;;                                                 '(list "usbmount" "sudo mount -t vfat $1 $2 -o rw,umask=000")
  ;;                                                 '(list "dvd" "mpv dvd:// -dvd-device $1")
  ;;                                                 '(list "dvdCopy" "dvdbackup -i /dev/sr0 -o ~/Downloads/iso/ -M"))))
  :config
  (leaf *unixCommandEmu
    :unless (eq system-type 'windows)
    :config (eval-after-load "esh-module"
              '(defvar eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))))

  :preface
  (defun eshell-alias ()
    (interactive)
    "eshell alias set"
    (setq eshell-command-aliases-list
          (append
           (list
            (list "ll" "ls -ltrh")
            (list "la" "ls -a")
            (list "o" "xdg-open")
            (list "emacs" "find-file $1")
            (list "m" "find-file $1")
            (list "mc" "find-file $1")
            (list "d" "dired .")
            (list "l" "eshell/less $1")
            (list "translate" "~/python/translate.py")
            (list "pacmandate" "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1")
            (list "nvidiafix" "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
            (list "usbmount" "sudo mount -t vfat $1 $2 -o rw,umask=000")
            (list "dvd" "mpv dvd:// -dvd-device $1")
            (list "dvdCopy" "dvdbackup -i /dev/sr0 -o ~/Downloads/iso/ -M")
            (list "pkglist" "yay -Qe | cut -f 1 -d " " > ~/.emacs.d/pkglist")))))
  (leaf *pcomplete-func
    :preface
    (defun pcomplete/sudo ()
      "Completion rules for the `sudo' command."
      (let ((pcomplete-ignore-case t))
        (pcomplete-here (funcall pcomplete-command-completion-function))
        (while (pcomplete-here (pcomplete-entries)))))

    ;;systemctlの補完
    (defcustom pcomplete-systemctl-commands
      '("disable" "enable" "status" "start" "restart" "stop" "reenable"
        "list-units" "list-unit-files")
      "p-completion candidates for `systemctl' main commands"
      :type '(repeat (string :tag "systemctl command"))
      :group 'pcomplete)
    (defvar pcomplete-systemd-units
      (split-string
       (shell-command-to-string
        "(systemctl list-units --all --full --no-legend;systemctl list-unit-files --full --no-legend)|while read -r a b; do echo \" $a\";done;"))
      "p-completion candidates for all `systemd' units")

    (defvar pcomplete-systemd-user-units
      (split-string
       (shell-command-to-string
        "(systemctl list-units --user --all --full --no-legend;systemctl list-unit-files --user --full --no-legend)|while read -r a b;do echo \" $a\";done;"))
      "p-completion candidates for all `systemd' user units")

    (defun pcomplete/systemctl ()
      "Completion rules for the `systemctl' command."
      (pcomplete-here (append pcomplete-systemctl-commands '("--user")))
      (cond ((pcomplete-test "--user")
             (pcomplete-here pcomplete-systemctl-commands)
             (pcomplete-here pcomplete-systemd-user-units))
            (t (pcomplete-here pcomplete-systemd-units))))))

(leaf *globa-keybinding
  :hook (minibuffer-setup-hook . minibuffer-delete-backward-char)
  :bind (;; C-m : 改行プラスインデント
         ("C-m"           . newline-and-indent)
         ;; ;; exwm用
         ("C-h" . delete-backward-char)
         ;; C-x ? : help
         ("C-c ?"         . help-command)
         ;;折り返しトグルコマンド
         ("C-c l"         . toggle-truncate-lines)
         ;; ウィンドウサイズの変更のキーバインド
         ("C-c r"         . window-resizer)
         ;; 行番号を表示
         ("C-c t"         . display-line-numbers-mode)
         ;;スペース、改行、タブを表示する
         ("C-c w"         . whitespace-mode)
         ;; 検索結果のリストアップ
         ("C-c o"         . occur)
         ;; S式の評価
         ("C-c C-j"       . eval-print-last-sexp)
         ;; async shell command
         ("s-s"           . async-shell-command)
         ("C-x g"         . magit-status)
         ("C-S-n"         . scroll-up_alt)
         ("C-S-p"         . scroll-down_alt)
         ("<kp-divide>"   . insertBackslash)
         ("<kp-multiply>" . insertPipe)
         ("M-h" . backward-kill-word))

  :preface
  (defun scroll-up_alt ()
    (interactive)
    (scroll-up 1))
  (defun scroll-down_alt ()
    (interactive)
    (scroll-down 1))
  (defun insertBackslash ()
    (interactive)
    (insert "\\"))
  (defun insertPipe ()
    (interactive)
    (insert "|"))
  (defun output_toggle ()
    "Exchange output source."
    (interactive)
    (start-process-shell-command
     "output-toggle"
     nil
     (format "~/.emacs.d/script/output_toggle.sh")))
  (defun upper_volume ()
    "Volume up."
    (interactive)
    (start-process-shell-command
     "upper_volume"
     nil
     (format "~/.emacs.d/script/upper_volume.sh")))
  (defun lower_volume ()
    "Volume down."
    (interactive)
    (start-process-shell-command
     "lower_volume"
     nil
     (format "~/.emacs.d/script/lower_volume.sh")))
  (defun mute_toggle ()
    "Volume mute."
    (interactive)
    (start-process-shell-command
     "mute_toggle"
     nil
     (format "~/.emacs.d/script/mute_toggle.sh")))
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
  :init
  (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char))

(leaf *afterSave
  :hook (after-save-hook . flashAfterSave)
  :preface
  (defun flashAfterSave ()
    (interactive)
    (let ((orig-fg (face-background 'mode-line)))
      (set-face-background 'mode-line "dark green")
      (run-with-idle-timer 0.1 nil
                           (lambda (fg) (set-face-background 'mode-line fg))
                           orig-fg))))

(leaf *window-tools
  :custom ((scroll-preserve-screen-position . t)
           ;; スクロール開始のマージン
           (scroll-margin                   . 5)
           (scroll-conservatively           . 100)
           ;; 1画面スクロール時に重複させる行数
           (next-screen-context-lines       . 10)
           ;; 1画面スクロール時にカーソルの画面上の位置をなるべく変えない
           (scroll-preserve-screen-position . t)
           (windmove-wrap-around            . t))
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

  :config
  (leaf zoom-window
    :doc "Zoom window like tmux"
    :req "emacs-24.3"
    :tag "emacs>=24.3"
    :url "https://github.com/syohex/emacs-zoom-window"
    :added "2021-09-05"
    :emacs>= 24.3
    :ensure t
    :custom (zoom-window-mode-line-color . "DarkBlue"))

  (leaf *ForMac
    :when (eq system-type 'darwin)
    :bind (("s-n" . windmove-down)
           ("s-f" . windmove-right)
           ("s-b" . windmove-left)
           ("s-p" . windmove-up)
           ("s-a" . zoom-window-zoom)
           ("s-q" . kill-current-buffer)
           ("s-h" . delete-window)
           ("s-o" . ivy-switch-buffer)))

  (leaf *ForWindows
    :when (eq system-type 'windows-nt)
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
           ("M-d" . counsel-linux-app)
           ("M-o" . ivy-switch-buffer)))

    (leaf *ForCUI
    :unless window-system
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
           ("M-d" . counsel-linux-app)
           ("M-o" . ivy-switch-buffer))
    :config (global-hl-line-mode . t))

  (leaf *mySaveFrame
    :when (or (eq system-type 'darwin) (eq system-type 'windows-nt))
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
      "'my-save-fram-file'に保存されたフレームの位置、大きさを復元します"
      (interactive)
      (let ((file my-save-frame-file))
        (when (file-exists-p file)
          (load-file file))))
    :config
    (run-with-idle-timer 60 t 'my-save-frame-size)))


;; theme
(leaf doom-themes
  :doc "an opinionated pack of modern color-themes"
  :req "emacs-25.1" "cl-lib-0.5"
  :tag "faces" "custom themes" "emacs>=25.1"
  :url "https://github.com/hlissner/emacs-doom-themes"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :custom ((doom-themes-enable-italic . t)
           (doom-themes-enable-bold   . t))
  :custom-face ((doom-modeline-bar . '((t (:background "#6272a4")))))
  :config
  (load-theme 'doom-one t)
  (leaf doom-modeline
    :doc "A minimal and modern mode-line"
    :req "emacs-25.1" "all-the-icons-2.2.0" "shrink-path-0.2.0" "dash-2.11.0"
    :tag "mode-line" "faces" "emacs>=25.1"
    :url "https://github.com/seagle0128/doom-modeline"
    :added "2021-09-05"
    :emacs>= 25.1
    :ensure t
    ;; :after all-the-icons shrink-path
    :hook (after-init . doom-modeline-mode)
    :custom `((doom-modeline-buffer-file-name-style . 'truncate-with-project)
              (doom-modeline-icon                   . t)
              (doom-modeline-major-mode-icon        . nil)
              (doom-modeline-minor-modes            . nil)
              (line-number-mode                     . 0)
              (column-number-mode                   . 0)
              (doom-modeline-mode                   . t))))


;; メジャーモードの設定
(leaf ein
  :doc "Emacs IPython Notebook"
  :req "emacs-25" "websocket-1.12" "anaphora-1.0.4" "request-0.3.3" "deferred-0.5" "polymode-0.2.2" "dash-2.13.0" "with-editor-0.-1"
  :tag "reproducible research" "literate programming" "jupyter" "emacs>=25"
  :url "https://github.com/dickmao/emacs-ipython-notebook"
  :added "2021-09-05"
  :emacs>= 25
  :ensure t
  :after websocket anaphora deferred polymode with-editor)

(leaf rust-mode
  :doc "A major-mode for editing Rust source code"
  :req "emacs-25.1"
  :tag "languages" "emacs>=25.1"
  :url "https://github.com/rust-lang/rust-mode"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :config
  (leaf racer
    :doc "code completion, goto-definition and docs browsing for Rust via racer"
    :req "emacs-25.1" "rust-mode-0.2.0" "dash-2.13.0" "s-1.10.0" "f-0.18.2" "pos-tip-0.4.6"
    :tag "tools" "rust" "matching" "convenience" "abbrev" "emacs>=25.1"
    :url "https://github.com/racer-rust/emacs-racer"
    :added "2021-09-05"
    :emacs>= 25.1
    :ensure t
    :after rust-mode pos-tip))

(leaf csv
  :doc "Functions for reading and parsing CSV files."
  :tag "csv" "data" "extensions"
  :added "2021-09-05"
  :ensure t)

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

(leaf magit
  :doc "A Git porcelain inside Emacs."
  :req "emacs-25.1" "dash-20210330" "git-commit-20210806" "magit-section-20210806" "transient-20210701" "with-editor-20210524"
  :tag "vc" "tools" "git" "emacs>=25.1"
  :url "https://github.com/magit/magit"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :after git-commit magit-section with-editor
  :config
  (leaf gitignore-mode
    :doc "Major mode for editing .gitignore files"
    :req "emacs-24.3"
    :tag "git" "vc" "convenience" "emacs>=24.3"
    :url "https://github.com/magit/git-modes"
    :added "2021-09-05"
    :emacs>= 24.3
    :ensure t))

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
            (haskell-process-type          . 'stack-ghci)
            (haskell-process-path-ghci     . "stack")
            (haskell-process-args-ghcie    . "ghci")
            (haskell-indent-after-keywords . '(("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let"))
            (haskell-indent-offset         . 4)
            (haskell-indendt-spaces        . 4)
            (haskell-compile-stack-build-command . t))

  :bind `((haskell-mode-map
           ("C-c C-z" . haskell-interactive-bring)
           ("C-c C-l" . haskell-process-load-file)
           ("C-c C-," . haskell-mode-format-imports)
           ("<f5>" . haskell-compile)
           ("<f8>" . haskell-navigate-imports)
           ))
  :hook ((haskell-mode-hook . interactive-haskell-mode)
         (haskell-mode-hook . haskell-decl-scan-mode)
         (haskell-mode-hook . haskell-doc-mode)
         (haskell-mode-hook . haskell-indentation-mode)))

(leaf python-mode
  :doc "Python major mode"
  :tag "oop" "python" "processes" "languages"
  :url "https://gitlab.com/groups/python-mode-devs"
  :added "2021-09-11"
  :ensure t
  :hook lsp)

(leaf yatex
  :doc "Yet Another tex-mode for emacs //野鳥//"
  :added "2021-09-05"
  :ensure t
  :hook ((yatex-mode-hook . (lambda () (auto-fill-mode -1)))
         (yatex-mode-hook . reftex-mode))
  ;; :bind (("C-c C-z" . ebib))
  :mode (("\\.tex\\'" . yatex-mode)
         ("\\.ltx\\'"     . yatex-mode)
         ("\\.cls\\'"     . yatex-mode)
         ("\\.sty\\'"     . yatex-mode)
         ("\\.clo\\'"     . yatex-mode)
         ("\\.bbl\\'"     . yatex-mode))
  :custom `((YaTeX-inhibit-prefix-letter  .   t)
            (YaTeX-kanji-code                 .   4)
            (YaTeX-latex-message-code         .   'utf-8)
            (YaTeX-use-LaTeX2e            .   t)
            (YaTeX-use-AMS-LaTeX          .   t)
            (YaTeX-dvi2-command-ext-alist .   '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|atril\\|xreader\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|MicrosoftEdge\\|microsoft-edge\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
            (tex-command                  .   "uplatex -synctex=1")
            ;; (tex-command  . "ptex2pdf -u -l -ot '-synctex=1 -file-line-error'")
            ;; (tex-command  . "ptex2pdf -l -ot '-synctex=1")
            (bibtex-command               .   "upbibtex")
            ;; (makeindex-command  . "mendex")
            (dviprint-command-format      .   "open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")
            (YaTeX-nervous                .   nil)
            (YaTeX-close-paren-always         .   nil))
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
            (">" . YaTeX-comment-region)
            ("<" . YaTeX-uncomment-region)))))

(leaf ebib
  :doc "a BibTeX database manager"
  :req "parsebib-2.3" "emacs-25.1"
  :tag "bibtex" "text" "emacs>=25.1"
  :url "http://joostkremers.github.io/ebib/"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :after parsebib
  :custom ((ebib-preload-bib-files                . '("~/tex/references.bib"))
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
           (ebib-keywords-file                    . "~/tex/ebib-keywords.txt")
           (ebib-keywords-file-save-on-exit       . 'always)
           (ebib-file-search-dirs                 . '("~/tex/pdfs" "~/tex/papers" "~/tex/books")))
  :config
  (leaf *ebibForMac
    :when (eq system-type 'darwin)
    :custom ((ebib-file-associations . '(("pdf" . "open") ("ps"  . "open"))))
    )
  (leaf *ebibForLinux
    :when (eq system-type 'gnu/linux)
    :custom ((ebib-file-associations . '(("pdf" . "zathura") ("ps"  . "zathura"))))))

(leaf google-translate
  :ensure t
  :require t
  :disabled t
  :bind (("s-v" . google-translate-enja-or-jaen))
  :preface
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
  (defun google-translate--get-b-d1 ()
    (list 427110 1469889687)))

(leaf eww
  :doc "Emacs Web Wowser"
  :tag "builtin"
  :added "2021-09-05"
  ;; :disabled t
  :hook ((eww-mode-hook . eww-mode-hook-disable-image))
  :defun eww-reload
  :custom ((eww-search-prefix . "https://www.google.co.jp/search?btnl&q=")
           (eww-browse-with-external-link . t)
           (eww-disable-colorize . t))
  :bind (("C-c m" . browse-url-with-eww)
         (eww-mode-map
          ("f"     . ace-link-eww)
          ("s-l"   . eww-search-words)
          ("M"     . eww-open-in-new-buffer)
          ("s-w"   . eww-buffer-kill)
          ("C-s-v" . eww-enable-images)
          ("s-v"   . eww-disable-images)
          ("s-e"   . eww-browse-with-external-browser)
          ("r" . eww-reload)

          ;; vi風
          ("h"     . backward-char)
          ("j"     . next-line)
          ("k"     . previous-line)
          ("l"     . forward-char)
          ("g" . eww-top)
          ("/" . isearch-forward)
          ("n" . isearch-next)
          ("?" . isearch-backward)
          ;; vimium風
          ("J"     . View-scroll-line-forward)
          ("K"     . View-scroll-line-backward)
          ("H"     . eww-back-url)
          ("L"     . eww-forward-url)
          ("J"     . previous-buffer)
          ("K"     . next-buffer)
          ("d"     . scroll-up)
          ("u"     . scroll-down)))

  :preface
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
  (defun shr-put-image-alt (spec alt &optional flags)
    (insert alt))
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
  (advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
  (advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
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

(leaf org
  :doc "Export Framework for Org Mode"
  :tag "builtin"
  :added "2021-09-05"
  :custom ((org-agenda-files . '("~/Dropbox/org/todo.org"
                                 "~/Dropbox/org/todo_SonyLSI.org")))
  :bind (("C-c a" . org-agenda))
  :config
  (leaf org-plus-contrib
    :doc "Outline-based notes management and organizer"
    :added "2021-09-05"
    :ensure t
    :hook ((org-mode-hook . eldoc-mode))    :config
    (defadvice org-eldoc-documentation-function (around add-field-info activate)
      (or
       (ignore-errors (and (not (org-at-table-hline-p)) (org-table-field-info nil)))
       ad-do-it))
    (eldoc-add-command-completions
     "org-table-next-" "org-table-previous" "org-cycle")))

(leaf pdf-tools
  :doc "Support library for PDF documents"
  :req "emacs-24.3" "tablist-1.0" "let-alist-1.0.4"
  :tag "multimedia" "files" "emacs>=24.3"
  :url "http://github.com/vedang/pdf-tools/"
  :added "2021-09-05"
  :emacs>= 24.3
  :ensure t
  :after tablist
  :when (file-exists-p "/usr/bin/epdfinfo")
  :hook ((pdf-view-mode-hook . pdf-misc-size-indication-minor-mode)
         (pdf-view-mode-hook . pdf-links-minor-mode)
         (pdf-view-mode-hook . pdf-isearch-minor-mode)))

(leaf twittering-mode
  :doc "Major mode for Twitter"
  :tag "web" "twitter"
  :url "http://twmode.sf.net/"
  :added "2021-09-05"
  :ensure t
  :custom ((twittering-allow-insecure-server-cert . t)
           (twittering-use-master-password . t)))

(leaf shackle
  :doc "Enforce rules for popups"
  :req "emacs-24.3" "cl-lib-0.5"
  :tag "convenience" "emacs>=24.3"
  :url "https://depp.brause.cc/shackle"
  :added "2021-09-05"
  :emacs>= 24.3
  :ensure t
  :unless (string-match "RaspberryPi" (system-name))
  :custom `((shackle-rules . '((compilation-mode :align below :ratio 0.2)
                               ("*Google Translate*" :align right :ratio 0.3)
                               ("*Help*" :align right)
                               ("*online-judge*" :align below :ratio 0.5)
                               ("*haskell-compilation*" :align below :ratio 0.5)
                               ))
            (shackle-mode . 1)
            (winner-mode . 1)
            (shackle-lighter . ""))
  :bind (("C-z" . winner-undo)))


;; マイナーモードの設定

(leaf view
  :doc "peruse file or buffer without editing"
  :tag "builtin"
  :added "2021-09-05"
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

(leaf *cua
  :bind (("C-x SPC" . cua-set-rectangle-mark))
  :custom ((cua-mode . t)
           (cua-enable-cua-keys . nil)))

(leaf *hs-minor-mode
  :hook ((emacs-lisp-mode-hook . hs-minor-mode-active))
  :bind (("C-'" . hs-toggle-hiding))
  :preface
  (defun hs-minor-mode-active ()
    (interactive)
    (hs-minor-mode 1)))

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

(leaf page-ext
  :doc "extended page handling commands"
  :tag "builtin"
  :added "2021-09-05"
  :require t)

(leaf smartparens
  :doc "Automatic insertion, wrapping and paredit-like navigation with user defined pairs."
  :req "dash-2.13.0" "cl-lib-0.3"
  :tag "editing" "convenience" "abbrev"
  :url "https://github.com/Fuco1/smartparens"
  :added "2021-09-05"
  :ensure t
      :disabled t
    :when window-system
    :ensure t
    :require smartparens-config
    :custom ((sp-highlight-pari-overly . nil)
             (sp-navigate-interactive-always-progress-point . t)
             (smartparens-global-strict-mode . t))
    :bind ((smartparens-mode-map
            ;;;;
            ;;;; navigation

            ;; basic (fbnp-ae)
            ("C-M-f" . sp-forward-sexp)
            ("C-M-b" . sp-backward-sexp)
            ("C-M-n" . sp-next-sexp)
            ("C-M-p" . sp-previous-sexp)
            ("C-M-a" . sp-beginning-of-sexp)
            ("C-M-e" . sp-end-of-sexp)

            ;; checkin/checkout
            ("C-M-i" . sp-down-sexp)
            ("C-M-o" . sp-backward-up-sexp)

            ;; misc
            ("C-M-k"   . sp-kill-sexp)
            ("C-M-w"   . sp-copy-sexp)
            ("C-M-t"   . sp-transpose-sexp)
            ("C-M-SPC" . sp-mark-sexp)

            ;;;;
            ;;;; depth-changing commands

            ;; basic
            ("M-s"           . sp-splice-sexp)
            ("M-r"           . sp-splice-sexp-killing-around)
            ("M-<up>"        . nil)
            ("M-<down>"      . nil)
            ("C-M-u"         . sp-splice-sexp-killing-backward)
            ("C-M-d"         . sp-splice-sexp-killing-forward)
            ("M-("           . sp-wrap-round)
            ("M-["           . sp-wrap-square)
            ("M-{"           . sp-wrap-qurly)

            ;; barf/slurp
            ("C-)" . sp-forward-slurp-sexp)
            ("C-}" . sp-forward-barf-sexp)
            ("C-(" . sp-backward-slurp-sexp)
            ("C-{" . sp-backward-barf-sexp)

            ;; split/join
            ("M-S-s" . sp-split-sexp)
            ("M-j"   . sp-join-sexp)

            ;;;;
            ;;;; misc

            ;; change constructure
            ("M-?"     . sp-convolute-sexp)
            ("C-c s a" . sp-absorb-sexp)
            ("C-c s e" . sp-emit-sexp)
            ("C-c s p" . sp-convolute-sexp)
            ("C-c s t" . sp-transpose-hybrid-sexp)

            ;; change elements
            ("C-c s (" . sp-rewrap-sexp)
            ("C-c s r" . sp-change-inner)
            ("C-c s s" . sp-change-enclosing)))
    )

(leaf undo-tree
  :doc "Treat undo history as a tree"
  :tag "tree" "history" "redo" "undo" "files" "convenience"
  :url "http://www.dr-qubit.org/emacs.php"
  :added "2021-09-05"
  :ensure t
  :unless (string-match "RaspberryPi" (system-name))
  :custom ((global-undo-tree-mode . t))
)

(leaf align
  :doc "align text to a specific column, by regexp"
  :tag "builtin"
  :added "2021-09-05")

(leaf ddskk
  :doc "Simple Kana to Kanji conversion program."
  :req "ccc-1.43" "cdb-20141201.754"
  :added "2021-09-05"
  :ensure t
  :after ccc cdb
  :require skk skk-study
  :defvar skk-user-directory
  :defun skk-toggle-kana skk-hiragana-set skk-katakana-set
  :hook ((isearch-mode-hook . skk-isearch-mode-setup)
         (isearch-mode-end-hook . skk-isearch-mode-cleanup))
  :bind (("C-x j" . skk-mode)
         ("C-j" . nil)
         ("C-j" . skk-hiragana-set)
         ("C-l" . skk-latin-mode)
         (minibuffer-local-map
          ("C-j" . skk-kakutei)
          ("C-l" . skk-latin-mode)))
  :custom `((skk-user-directory . "~/.emacs.d/ddskk")
            (skk-initial-search-jisyo . "~/.emacs.d/ddskk/jisyo")
            (skk-large-jisyo . "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
            (skk-egg-like-newline . t)
            (skk-delete-implies-kakutei . t)
            (skk-henkan-strict-okuri-precedence . t)
            (skk-isearch-start-mode . 'latin)
            (skk-search-katakana . t))
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
           (dolist (skk-kakutei (skk-toggle-kana nil)))))))

;; (leaf *minor-mode
;;   :disabled t
;;   :config
;;   (leaf skk
;;     :ensure ddskk
;;     ;; :defun (skk-get)
;;     :require t skk-study
;;     :defvar skk-user-directory
;;     :defun skk-toggle-kana skk-hiragana-set skk-katakana-set
;;     :hook ((isearch-mode-hook . skk-isearch-mode-setup)
;;            (isearch-mode-end-hook . skk-isearch-mode-cleanup))
;;     :bind (("C-x j" . skk-mode)
;;            ("C-j" . nil)
;;            ("C-j" . skk-hiragana-set)
;;            ("C-l" . skk-latin-mode)
;;            (minibuffer-local-map
;;             ("C-j" . skk-kakutei)
;;             ("C-l" . skk-latin-mode)))
;;     :custom `((skk-user-directory . "~/.emacs.d/ddskk")
;;               (skk-initial-search-jisyo . "~/.emacs.d/ddskk/jisyo")
;;               (skk-large-jisyo . "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
;;               (skk-egg-like-newline . t)
;;               (skk-delete-implies-kakutei . t)
;;               (skk-henkan-strict-okuri-precedence . t)
;;               (skk-isearch-start-mode . 'latin)
;;               (skk-search-katakana . t))
;;     :preface
;;     (defun skk-hiragana-set nil
;;       (interactive)
;;       (cond (skk-katakana
;;              (skk-toggle-kana nil))
;;             (t
;;              (skk-kakutei))))
;;     (defun skk-katakana-set nil
;;       (interactive)
;;       (cond (skk-katakana
;;              (lambda))
;;             (skk-j-mode
;;              (skk-toggle-kana nil))
;;             (skk-latin-mode
;;              (dolist (skk-kakutei (skk-toggle-kana nil))))))))

(leaf calfw
  :doc "Calendar view framework on Emacs"
  :tag "calendar"
  :url "https://github.com/kiwanami/emacs-calfw"
  :added "2021-09-05"
  :ensure t
  :config
  (leaf japanese-holidays
    :doc "Calendar functions for the Japanese calendar"
    :req "emacs-24.1" "cl-lib-0.3"
    :tag "calendar" "emacs>=24.1"
    :url "https://github.com/emacs-jp/japanese-holidays"
    :added "2021-09-05"
    :emacs>= 24.1
    :ensure t
    :after calendar
    :require japanese-holidays
    :hook ((calendar-today-visible-hook . japanese-holiday-mark-weekend)
           (calendar-today-invisible-hook .  japanese-holiday-mark-weekend)
           (calendar-today-visible-hook . calendar-mark-today))
    :custom ((calendar-mark-holidays-flag . t)
             (japanese-holiday-weekend . '(0 6))
             (japanese-holiday-weekend-marker . '(holiday nil nil nil nil nil japanese-holiday-saturday))
             (org-agenda-include-diary . t))
    :config
    (let ((array ["日" "月" "火" "水" "木" "金" "土"]))
      (setq calendar-day-header-array array
            calendar-day-name-array array)))
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
                                          (append japanese-holidays local-holidays other-holidays))))))

(leaf online-judge
  :when (executable-find "oj")
  :el-get ROCKTAKEY/emacs-online-judge
  :require t
  :custom ((online-judge-directories . '("~/Dropbox/atcoder/"))
           (online-judge-command-name . nil)))

(leaf yasnippet
  :doc "Yet another snippet extension for Emacs"
  :req "cl-lib-0.5"
  :tag "emulation" "convenience"
  :url "http://github.com/joaotavora/yasnippet"
  :added "2021-09-05"
  :ensure t
  :diminish t
  :unless (string-match "Raspberrypi" (system-name))
  :custom ((yas-global-mode . t))
  :bind ((yas-minor-mode-map
          ("C-." . ivy-yasnippet)))
  :config
  (leaf yas_hook
    :require cl
    :config
    (defvar ivy-programing-hooks ()
      '(emacs-lisp-mode
        org-mode
        yatex-mode
        haskell-mode))
    (loop for hook in ivy-programing-hooks
          do (add-hook hook 'yas-minor-mode))))

(leaf rainbow-delimiters
  :doc "Highlight brackets according to their depth"
  :tag "tools" "lisp" "convenience" "faces"
  :url "https://github.com/Fanael/rainbow-delimiters"
  :added "2021-09-05"
  :ensure t
  :hook (emacs-lisp-mode-hook . rainbow-delimiters-mode))

(leaf hydra
  :doc "Make bindings that stick around."
  :req "cl-lib-0.5" "lv-0"
  :tag "bindings"
  :url "https://github.com/abo-abo/hydra"
  :added "2021-09-06"
  :ensure t
  :after lv
  :hydra
  (hydra-pinky
   (global-map "C-]")
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
   ("<" beginning-of-buffer)
   (">" end-of-buffer)
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
   ("g" text-scale-increase "in")
   ("l" text-scale-decrease "out")))

(leaf which-key
  :doc "Display available keybindings in popup"
  :req "emacs-24.4"
  :tag "emacs>=24.4"
  :url "https://github.com/justbur/emacs-which-key"
  :added "2021-09-12"
  :emacs>= 24.4
  :ensure t)

(leaf sudo-edit
  :doc "Open files as another user"
  :req "emacs-24" "cl-lib-0.5"
  :tag "convenience" "emacs>=24"
  :url "https://github.com/nflath/sudo-edit"
  :added "2021-09-10"
  :emacs>= 24
  :ensure t)


;; lsp 設定
(leaf lsp
  :tag "out-of-MELPA"
  :added "2021-09-05"
  ;; :el-get emacs-lsp/lsp-mode
  :require t
  ;; :unless (string-match "Raspberrypi" (system-name))
  :hook ((haskell-mode-hook . lsp)
         (haskell-literate-mode-hook . lsp)
<<<<<<< HEAD
         (lsp-mode-hook . (lambda ()
                            (company-mode t)
                            (corfu-mode nil))))
=======
         (python-mode-hook . lsp))
>>>>>>> origin/master
  :commands lsp
  :init
  (leaf lsp-ui
    :doc "UI modules for lsp-mode"
    :req "emacs-26.1" "dash-2.18.0" "lsp-mode-6.0" "markdown-mode-2.3"
    :tag "tools" "languages" "emacs>=26.1"
    :url "https://github.com/emacs-lsp/lsp-ui"
    :added "2021-09-05"
    :emacs>= 26.1
    :ensure t
    :after lsp-mode markdown-mode
    :commands lsp-ui-mode
    :custom
    ((lsp-ui-doc-header            . t)
     (lsp-ui-doc-include-signature . t)
     (lsp-ui-doc-position          . 'at-point)
     (lsp-ui-doc-max-width         . 150)
     (lsp-ui-doc-max-height        . 30)
     (lsp-ui-doc-use-childframe    . nil)
     (lsp-ui-doc-use-webkit        . nil)
     (lsp-ui-flycheck-enable       . t)
     (lsp-ui-peek-enable           . t)
     (lsp-ui-peek-peek-height      . 20)
     (lsp-ui-peek-list-width       . 50)
     (lsp-ui-peek-fontify          . 'on-demand))
    :hook ((lsp-mode-hook . lsp-ui-mode)))
  (leaf lsp-ivy
    :doc "LSP ivy integration"
    :req "emacs-25.1" "dash-2.14.1" "lsp-mode-6.2.1" "ivy-0.13.0"
    :tag "debug" "languages" "emacs>=25.1"
    :url "https://github.com/emacs-lsp/lsp-ivy"
    :added "2021-09-05"
    :emacs>= 25.1
    :ensure t
    :after lsp-mode ivy
    :commands lsp-ivy-workspace-symbol)
  (leaf lsp-treemacs
    :doc "LSP treemacs"
    :req "emacs-26.1" "dash-2.18.0" "f-0.20.0" "ht-2.0" "treemacs-2.5" "lsp-mode-6.0"
    :tag "languages" "emacs>=26.1"
    :url "https://github.com/emacs-lsp/lsp-treemacs"
    :added "2021-09-05"
    :emacs>= 26.1
    :ensure t
    :after treemacs lsp-mode
    :commands lsp-treemacs-errors-list)
  (leaf lsp-haskell
    :doc "Haskell support for lsp-mode"
    :req "emacs-24.3" "lsp-mode-3.0" "haskell-mode-1.0"
    :tag "haskell" "emacs>=24.3"
    :url "https://github.com/emacs-lsp/lsp-haskell"
    :added "2021-09-05"
    :emacs>= 24.3
    :ensure t
    :after lsp-mode haskell-mode)
  (leaf consult-lsp
    :doc "LSP-mode Consult integration"
    :req "emacs-27.1" "lsp-mode-5.0" "consult-0.9" "f-0.20.0"
    :tag "lsp" "completion" "tools" "emacs>=27.1"
    :url "https://github.com/gagbo/consult-lsp"
    :added "2021-09-06"
    :emacs>= 27.1
    :ensure t
    :after lsp-mode consult))


;; ivy 補完設定
(leaf ivy
  :disabled t
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :added "2021-09-05"
  :emacs>= 24.5
  :ensure t
  :leaf-defer nil
  :custom `((ivy-re-builders-alist        . '((t . ivy--regex-plus)))
            (ivy-use-selectable-prompt    . t)
            (ivy-mode                     . t)
            (counsel-mode                 . t)
            (dired-recent-mode            . t)
            (ivy-use-virtual-buffers      . t)
            (ivy-truncate-lines           . nil)
            (ivy-wrap                     . t)
            (enable-recursive-minibuffers . t)
            (ivy-height                   . 15)
            (ivy-extra-directories        . nil)
            (ivy-format-functions-alist   . '((t . ivy-format-function-arrow))))
  :bind (("C-x b" . ivy-switch-buffer)
         (ivy-minibuffer-map
          ;; ESC連打でミニバッファを閉じる
          ("<escape>" . minibuffer-keyboard-quit)
          ("C-m"      . ivy-alt-done)
          ("C-i"      . ivy-immediate-done)))
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.4"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :added "2021-09-05"
    :emacs>= 24.5
    :ensure t
    :after ivy
    ;; :unless (string= (system-name) "RaspberryPi")
    :defvar swiper-include-line-number-in-search
    :bind (("C-s" . swiper)
           ("C-r" . swiper)
           (swiper-map
            ("C-j" . skk-hiragana-set)
            ("C-l" . skk-latin-mode)))
    :custom (swiper-include-line-number-in-search . t))
  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "ivy-0.13.4" "swiper-0.13.4"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :added "2021-09-05"
    :emacs>= 24.5
    :ensure t
    :after ivy swiper
    :custom ((counsel-mode                    . 1)
             (counsel-find-file-ignore-regexp . (regexp-opt '("./" "../")))
             (recentf-max-saved-items         . 2000)
             (recentf-auto-cleanup            . 'never)
             (recentf-exclude                 . '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/" "/Geheimnis"))
             (recentf-mode                    . 1)
             (counsel-yank-pop-separator      . "\n-------\n"))
    :bind (("M-x"     . counsel-M-x)
           ("C-x C-f" . counsel-find-file)
           ("C-c h"   . counsel-recentf)
           ("C-c i"   . counsel-imenu)
           ("M-y"     . counsel-yank-pop)
           ("C-x C-b" . counsel-ibuffer)))
  (leaf counsel-osx-app
    :doc "launch osx applications via ivy interface"
    :req "ivy-0.8.0" "emacs-24.3"
    :tag "emacs>=24.3"
    :url "https://github.com/d12frosted/counsel-osx-app"
    :added "2021-09-05"
    :emacs>= 24.3
    :ensure t
    :after ivy
    :when (eq system-type 'darwin)
    :bind ("s-d" . counsel-osx-app)
    :custom ((counsel-osx-app-location . '("/Applications"
                                           "/Applications/Downloads"
                                           "/Applications/Flip4Mac"
                                           "/Applications/GoogleJapaneseInput.localized"
                                           ;; "/Applications/Igor Pro 6.1 Folder"
                                           "/Applications/Igor Pro 6.3 Folder"
                                           "/Applications/iWork '09"
                                           "/Applications/Microsoft Office 2011"
                                           "/Applications/Python 2.7"
                                           "/Applications/RIETAN_VENUS"
                                           "/Applications/Utilities"))))
  (leaf ivy-hydra
    :doc "Additional key bindings for Ivy"
    :req "emacs-24.5" "ivy-0.13.4" "hydra-0.14.0"
    :tag "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :added "2021-09-05"
    :emacs>= 24.5
    :ensure t
    :after ivy hydra
    :disabled t
    :custom (ivy-read-action-function . #'ivy-hydra-read-action)))


;; company 補完設定
(leaf company
  ;; :disabled t
  :doc "Modular text completion framework"
  :req "emacs-25.1"
  :tag "matching" "convenience" "abbrev" "emacs>=25.1"
  :url "http://company-mode.github.io/"
  :added "2021-09-05"
  :emacs>= 25.1
  :ensure t
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection)
          ("C-h" . nil)
          ("C-f" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom `((company-idle-delay            . 0)
            (company-minimum-prefix-length . 3)
            (company-transformers          . '(company-sort-by-occurrence))
            (company-tooltip-limit         . 12)
            (global-company-mode           . nil)
            (company-dabbrev-downcase      . nil)
            (company-backends . '(company-capf)))
;;  :global-minor-mode global-company-mode
  :config
  (leaf company-math
    :doc "Completion backends for unicode math symbols and latex tags"
    :req "company-0.8.0" "math-symbol-lists-1.3"
    :tag "completion" "symbols" "unicode"
    :url "https://github.com/vspinu/company-math"
    :added "2021-09-05"
    :ensure t
    :after company math-symbol-lists
    :disabled t
    :unless (eq system-type 'dawin)
    :defvar (company-backends)
    :preface
    (defun c/latex-mode-setup ()
      (setq-local company-backends
                  (append '((company-math-symbols-latex
                             company-math-symbols-unicode
                             company-latex-commands))
                          company-backends)))
    :hook ((org-mode-hook . c/latex-mode-setup)
           (tex-mode-hook . c/latex-mode-setup)
           (yatex-mode-hook . c/latex-mode-setup)))
  (leaf company-quickhelp
    :doc "Popup documentation for completion candidates"
    :req "emacs-24.3" "company-0.8.9" "pos-tip-0.4.6"
    :tag "quickhelp" "documentation" "popup" "company" "emacs>=24.3"
    :url "https://www.github.com/expez/company-quickhelp"
    :added "2021-09-05"
    :emacs>= 24.3
    :ensure t
    :after company pos-tip
    :disabled t
    :when (display-graphic-p)
    :custom ((company-quickhelp-delay . 0.8)
             (company-quickhelp-mode  . t))
    :bind (company-active-map
           ("M-h" . company-quickhelp-manual-begin))
    :hook ((company-mode-hook . company-quickhelp-mode)))
  (leaf company-tabnine
    :doc "A company-mode backend for TabNine"
    :req "emacs-25" "company-0.9.3" "cl-lib-0.5" "dash-2.16.0" "s-1.12.0" "unicode-escape-1.1"
    :tag "convenience" "emacs>=25"
    :url "https://github.com/TommyX12/company-tabnine/"
    :added "2021-09-05"
    :emacs>= 25
    :ensure t
    :after company unicode-escape
    :disabled t
    :config
    (add-to-list 'company-backends #'company-tabnine))
  (leaf company-prescient
    :doc "prescient.el + Company"
    :req "emacs-25.1" "prescient-5.1" "company-0.9.6"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :added "2021-09-05"
    :emacs>= 25.1
    :ensure t
    :after prescient company
    :disabled t)
  (leaf company-c-headers
    :doc "Company mode backend for C/C++ header files"
    :req "emacs-24.1" "company-0.8"
    :tag "company" "development" "emacs>=24.1"
    :added "2021-09-05"
    :emacs>= 24.1
    :ensure t
    :after company
    :config (add-to-list 'company-backends 'company-c-headers))
  (leaf company-box
    :doc "Company front-end with icons"
    :req "emacs-26.0.91" "dash-2.13" "dash-functional-1.2.0" "company-0.9.6" "frame-local-0.0.1"
    :tag "convenience" "front-end" "completion" "company" "emacs>=26.0.91"
    :url "https://github.com/sebastiencs/company-box"
    :added "2021-09-05"
    :emacs>= 26.0
    :ensure t
    :after company frame-local
    :diminish company-box-mode
    :defvar (company-box-icons-alist company-box-icons-all-the-icons)
    :disabled t
    :init
    (leaf all-the-icons
      :doc "A library for inserting Developer icons"
      :req "emacs-24.3"
      :tag "lisp" "convenient" "emacs>=24.3"
      :url "https://github.com/domtronn/all-the-icons.el"
      :added "2021-09-05"
      :emacs>= 24.3
      :ensure t)
    :custom ((company-box-max-candidates . 50)
             (company-box-icons-alist    . 'company-box-icons-all-the-icons))
    :hook ((company-mode-hook . company-box-mode))
    :config
    (when (memq window-system '(ns mac))
      (declare-function all-the-icons-faicon 'all-the-icons)
      (declare-function all-the-icons-material 'all-the-icons)
      (declare-function all-the-icons-octicon 'all-the-icons)
      (setq company-box-icons-all-the-icons
            `((Unknown       . ,(all-the-icons-material "find_in_page" :height 0.9 :v-adjust -0.2))
              (Text          . ,(all-the-icons-faicon "text-width" :height 0.85 :v-adjust -0.05))
              (Method        . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Function      . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Constructor   . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Field         . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
              (Variable      . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
              (Class         . ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Interface     . ,(all-the-icons-material "share" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Module        . ,(all-the-icons-material "view_module" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Property      . ,(all-the-icons-faicon "wrench" :height 0.85 :v-adjust -0.05))
              (Unit          . ,(all-the-icons-material "settings_system_daydream" :height 0.9 :v-adjust -0.2))
              (Value         . ,(all-the-icons-material "format_align_right" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Enum          . ,(all-the-icons-material "storage" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Keyword       . ,(all-the-icons-material "filter_center_focus" :height 0.9 :v-adjust -0.2))
              (Snippet       . ,(all-the-icons-material "format_align_center" :height 0.9 :v-adjust -0.2))
              (Color         . ,(all-the-icons-material "palette" :height 0.9 :v-adjust -0.2))
              (File          . ,(all-the-icons-faicon "file-o" :height 0.9 :v-adjust -0.05))
              (Reference     . ,(all-the-icons-material "collections_bookmark" :height 0.9 :v-adjust -0.2))
              (Folder        . ,(all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05))
              (EnumMember    . ,(all-the-icons-material "format_align_right" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Constant      . ,(all-the-icons-faicon "square-o" :height 0.9 :v-adjust -0.05))
              (Struct        . ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Event         . ,(all-the-icons-faicon "bolt" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-orange))
              (Operator      . ,(all-the-icons-material "control_point" :height 0.9 :v-adjust -0.2))
              (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.85 :v-adjust -0.05))
              (Template      . ,(all-the-icons-material "format_align_center" :height 0.9 :v-adjust -0.2))))
      (setq company-box-icons-alist 'company-box-icons-all-the-icons))))


;; Vertico お試し
(leaf vertico
  :doc "VERTical Interactive COmpletion"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/vertico"
  :added "2021-09-05"
  :emacs>= 27.1
  :ensure t
  :require t
  :bind (("M-g g" . consult-goto-line)
         ("C-c i" . consult-outline)
         ("M-y" . consult-yank-pop)
<<<<<<< HEAD
         ("C-c s" . consult-line)
=======
         ("C-o" . consult-line)
>>>>>>> origin/master
         ("C-c h" . consult-recent-file)
         ("C-s" . consult-isearch)
          ("?" . minibuffer-complition-help)
          ("M-RET" . minibuffer-force-complete-and-exit)
          ("M-TAB" . minibuffer-complete)
<<<<<<< HEAD
          ("C-," . up-to-dir))
  :custom `((vertico-count . 20)
            (consult-preview-key . ,(kbd "C-.")))
=======
          ("C-," . up-to-dir)))
  :custom ((vertico-count . 20))
>>>>>>> origin/master
  :preface
  (defun up-to-dir ()
    "Move to parent directory like \"cd ..\" in find-file."
    (interactive)
    (let ((sep (eval-when-compile (regexp-opt '("/" "\\")))))
      (save-excursion
        (left-char 1)
        (when (looking-at-p sep)
          (delete-char 1)))
      (save-match-data
        (when (search-backward-regexp sep nil t)
          (right-char 1)
          (filter-buffer-substring (point)
                                   (save-excursion (end-of-line) (point))
                                   #'delete)))))
  :config
  (vertico-mode)
  (leaf consult
    :doc "Consulting completing-read"
    :req "emacs-26.1"
    :tag "emacs>=26.1"
    :url "https://github.com/minad/consult"
    :added "2021-09-05"
    :emacs>= 26.1
    :ensure t
    :custom `((consult-buffer-sources . '(consult--source-hidden-buffer
                                          consult--source-buffer
                                          consult--source-file
                                          consult--source-bookmark
                                          consult--source-project-buffer
                                          consult--source-project-file))
              (consult-preview-key . ,(kbd "C-.")))
    :config (recentf-mode))
  (leaf marginalia
    :doc "Enrich existing commands with completion annotations"
    :req "emacs-26.1"
    :tag "emacs>=26.1"
    :url "https://github.com/minad/marginalia"
    :added "2021-09-06"
    :emacs>= 26.1
    :ensure t
    :unless (string= (system-name) "RaspberryPi")
    :config (marginalia-mode 1))
  (leaf orderless
    :doc "Completion style for matching regexps in any order"
    :req "emacs-26.1"
    :tag "extensions" "emacs>=26.1"
    :url "https://github.com/oantolin/orderless"
    :added "2021-09-05"
    :emacs>= 26.1
    :ensure t
    :custom ((completion-styles . '(orderless))
             (completion-category-defaults . nil)
             (completion-category-overrides . '((file (style . (partial-completion)))))))
  (leaf savehist
    :doc "Save minibuffer history"
    :tag "builtin"
    :added "2021-09-05"
    :config (savehist-mode))
  (leaf app-launcher
    :doc "Launch applications from Emacs"
    :req "emacs-27.1"
    :tag "out-of-MELPA" "emacs>=27.1"
    :url "https://github.com/sebastienwae/app-launcher"
    :added "2021-09-06"
    :emacs>= 27.1
    :el-get sebastienwae/app-launcher
    :require t)
  (leaf corfu
    :doc "Completion Overlay Region FUnction"
    :req "emacs-27.1"
    :tag "emacs>=27.1"
    :url "https://github.com/minad/corfu"
    :added "2021-09-11"
    :emacs>= 27.1
    :ensure t
    :require t
    :custom
    (corfu-cycle . t)
    (corfu-auto . t)
    (completion-cycle-threshold . 3)
    :config
    (corfu-global-mode)))


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
    :defun (exwm-workspace-rename-buffer exwm-workspace-toggle)
    :hook (exwm-update-class-hook . (lambda ()
                                      (exwm-workspace-rename-buffer exwm-class-name)))

    :custom `((use-dialog-box . nil)
              (window-divider-default-right-width . 1)
              (exwm-workspace-show-all-buffers . t)
              (exwm-layout-show-all-buffers . t)
              (exwm-workspace-number . 3)
              (exwm-input-global-keys . '(;; 自前の関数
                                          (,(kbd "s-r")     . exwm-reset)
                                          (,(kbd "s-<tab>") . exwm-workspace-toggle)
                                          (,(kbd "s-q")     . kill-current-buffer)
                                          (,(kbd "s-h")     . delete-window)
                                          (,(kbd "s-SPC")   . exwm-floating-toggle-floating)
                                          (,(kbd "s-e")     . exwm-input-toggle-keyboard)
                                          (,(kbd "s-r")     . exwm-reset)
                                          (,(kbd "C-j")     . ,(kbd "C-&"))
                                          (,(kbd "C-l")     . ,(kbd "C-^"))
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
                                          (,(kbd "s-i")     . output_toggle)
                                          (,(kbd "s-j")     . lower_volume)
                                          (,(kbd "s-k")     . upper_volume)
                                          (,(kbd "s-m")     . mute_toggle)
                                          (,(kbd "s-i")     . output_toggle)
                                          (,(kbd "C-s-i")   . output_toggle)
                                          (,(kbd "C-s-m")   . mute_toggle)
                                          (,(kbd "C-s-n")   . lower_volume)
                                          (,(kbd "C-s-p")   . upper_volume)
                                          (,(kbd "s-[")     . lowerLight)
                                          (,(kbd "s-]")     . upperLight)
                                          ;; (,(kbd "s-d")     . counsel-linux-app)
                                          (,(kbd "s-d")     . app-launcher-run-app)
                                          ;; (,(kbd "s-o")     . ivy-switch-buffer)
                                          (,(kbd "s-a")     . zoom-window-zoom)
                                          (,(kbd "s-o")     . consult-buffer)))
              (exwm-input-simulation-keys . '(
                                              ;; new version
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
                                              ;;
                                              ;;
                                              ;;
                                              (,(kbd "s-l")           . [C-k])
                                              (,(kbd "s-k")           . [C-l])
                                              ;;
                                              (,(kbd "C-x C-s")       . [C-s])
                                              (,(kbd "C-u C-/")       . [C-y]))))
    :bind (("C-&" . skk-hiragana-set)
           ("C-^" . skk-latin-mode))
    :preface
    (defun exwm-workspace-toggle ()
      (interactive)
      (if (= exwm-workspace-current-index 0)
          (exwm-workspace-switch 2)
        (exwm-workspace-switch 0)))

    :config
    ;; (exwmx-floating-smart-hide)
    ;; (exwmx-button-enable)
    (leaf exwm-systemtray
      :require t
      :defun exwm-systemtray-enable
      :config
      (exwm-systemtray-enable))
    (leaf exwm-randr
      :require t
      :when (string= (system-name) "archlinuxhonda")
      :custom ((exwm-randr-workspace-monitor-plist . '(0 "DP-0" 1 "HDMI-0" 2 "DP-0" 3 "DP-0" 4 "DP-0" 5 "DP-0")))
      :config
      (exwm-randr-enable))
    (leaf exwm-enable
      :defun (exwm-enable)
      :config
      (exwm-enable))
    (leaf *fix_ediff
      :after ediff-wind
      :custom `((ediff-window-setup-function . 'ediff-setup-windows-plain)))))
