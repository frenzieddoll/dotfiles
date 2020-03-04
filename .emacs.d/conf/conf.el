;; leaf 起動前の設定
(prog1 "prepare leaf"
  (prog1 "package"
	;; (when (eq system-type 'darwin)
	;;   (custom-set-variables
	;;    '(package-archives '(("org"   . "http://orgmode.org/elpa/")
	;; 						("melpa" . "http://melpa.org/packages/")
	;; 						("gnu"	 . "http://elpa.gnu.org/packages/"))))
	;;   (custom-set-variables
	;;    '(package-archives '(("org"   . "https://orgmode.org/elpa/")
	;; 						("melpa" . "https://melpa.org/packages/")
	;; 						("gnu"	 . "https://elpa.gnu.org/packages/"))))
	;;   )
	(custom-set-variables
	 '(package-archives '(("org"   . "http://orgmode.org/elpa/")
						  ("melpa" . "http://melpa.org/packages/")
						  ("gnu"   . "http://elpa.gnu.org/packages/"))))

    (package-initialize))

  (prog1 "leaf"
    (unless (package-installed-p 'leaf)
      (unless (assoc 'leaf package-archive-contents)
        (package-refresh-contents))
      (condition-case err
          (package-install 'leaf)
        (error
         (package-refresh-contents)       ; renew local melpa cache if fail
         (package-install 'leaf))))

    (leaf leaf-keywords
      :ensure t
      :config (leaf-keywords-init)))

  (prog1 "optional packages for leaf-keywords"
    ;; optional packages if you want to use :hydra, :el-get,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone  . t)))))


;; 初回起動の設定
(leaf *initialize-emacs
  :config
  (leaf cus-edit
	:preface (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
	:custom `((custom-file . ,(expand-file-name "custom.el" user-emacs-directory)))
	:hook `(kill-emacs-hook . (lambda ()
				    (if (file-exists-p custom-file)
					(delete-file custom-file))))
	)

  (leaf exec-path-from-shell
    :ensure t
    :defun (exec-path-from-shell-initialize)
    :custom ((exec-path-from-shell-check-startup-files . nil)
			 (exec-path-from-shell-variables . '("SHELL" "PATH"))
			 ;; (exec-path-from-shell-initialize . t)
			 )
	:config
	(exec-path-from-shell-initialize)
	)
  )

(leaf *init_system
  :config
  (leaf cus-start
    :doc "define customization properties of builtins"
    :url "http://handlename.hatenablog.jp/entry/2011/12/11/214923" ; align sumple
    :defvar show-paren-deley
    :custom `(;; GC
			  ;; (gc-cons-threshold . ,(* 128 1024 1024))
			  (garbage-collection-messages . t)
			  ;; 表示
			  (tool-bar-mode . nil)
			  (scroll-bar-mode . nil)
			  (menu-bar-mode . nil)
			  (blink-cursor-mode . nil)
			  (column-number-mode . nil)
			  (ring-bell-function . 'ignore)
			  ;; 編集
              (tab-width . 4)
              (indent-tabs-mode . t)
			  (fill-column            . 72)   ;; RFC2822 風味
			  (truncate-lines         . t)  ;; 折り返し無し
			  (truncate-partial-width-windows . nil)
			  (paragraph-start        . '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")
			  (auto-fill-mode         . nil)
			  (next-line-add-newlines . nil)  ;; バッファ終端で newline を入れない
			  (read-file-name-completion-ignore-case . t)  ; 大文字小文字区別無し
			  ;; undo/redo - 数字に根拠無し
			  (undo-limit              . 200000)
			  (undo-strong-limit       . 260000)
			  (history-length          . t)  ;; 無制限(の筈)

              (create-lockfiles                . nil)
              (use-dialog-box                  . nil)
              (use-file-dialog                 . nil)
              (frame-resize-pixelwise          . t)
              (enable-recursive-minibuffers    . t)
              (history-length                  . 1000)
              (history-delete-duplicates       . t)
              (scroll-preserve-screen-position . t)
              (scroll-conservatively           . 100)
              (mouse-wheel-scroll-amount       . '(1 ((control) . 5)))
              (text-quoting-style              . 'straight)


              ;; システムの時計をCにする
              (system-time-locale . "C")
              ;; 改行コードを表示する
              (eol-mnemonic-dos . "(CRLF)")
              (eol-mnemonic-mac . "(CR)")
              (eol-mnemonic-unix . "(LF)")
              ;; 右から左に読む言語に対応させないことで描画高速化
              (bidi-display-reordering . nil)
              ;; 同じ内容を履歴に記録しない
              (history-delete-duplicates . t)
              ;; バックアップファイ及び、自動セーブの無効
              (make-backup-files . nil)
              (delete-auto-save-files . t)
              (auto-save-default . nil)
              ;; バッファの最後でnewlineで新規行を追加するのを禁止する
              (next-line-add-newlines . nil)
              ;; auto-fill-modeを切る
              (auto-fill-mode . nil)
              ;; 補完で大文字小文字無視
              (read-file-name-completion-ignore-case . t)
              ;; ミニバッファの履歴を保存する
              (savehist-mode . 1)
              (history-length . 30000)
              ;; 同じ内容を履歴に記録しない
              (history-delete-duplicates . t)
              ;; 対応する括弧を光らせる
              (show-paren-mode . 1)
              (show-paren-delay . 0.125)
              ;; シンボリック経由でファイルを開く
              (vc-follow-symlinks . t)
			  (display-time-mode . t)
			  (display-time-string-forms . '((format "%s/%s(%s)%s:%s"
    												 month day dayname
    												 24-hours minutes
													 ))))
	:config
    (set-face-background 'region "#555")
    (defalias 'yes-or-no-p 'y-or-n-p)
	(leaf *gc-cons-threshold-arch
	  :when (string-match "archlinuxhonda" (system-name))
	  :custom `((gc-cons-threshold . ,(* 128 1024 1024)))
	  )
	(leaf *gc-cons-threshold-mac
	  :when (eq system-type 'darwin)
	  :custom `((gc-cons-threshold . ,(* 32 1024 1024)))
	  )

	(leaf startup
	  :doc "起動を静かに"
	  :custom ((inhibit-splash-screen . t)
			   (inhibit-startup-screen . t)
               (inhibit-startup-message . t)
			   (inhibit-startup-echo-area-message . t)
			   (initial-buffer-choice . t)
			   (initial-scratch-message . nil)
			   )
	  )

	(leaf *fontSetting
      :config
      (leaf *forArchlinux
		:when (eq system-type 'gnu/linux)
		:when (string-match (system-name) "archlinuxhonda")
		:config
		(set-face-attribute 'default nil
							:family "Hackgen"
							:height 150))
      (leaf *forLinux
		:when (eq system-type 'gnu/linux)
		:unless (string-match (system-name) "archlinuxhonda")
		:config
		(set-face-attribute 'default nil
							:family "Hackgen"
							:height 100))
      (leaf *forMac
		:when (eq system-type 'darwin)
		:config
		(set-face-attribute 'default nil
							:family "Hackgen"
							:height 150)
		(set-fontset-font (frame-parameter nil 'font)
				  'japanese-jisx0208
				  (font-spec :family "Hackgen" :height 150))

		)
	  )

	(leaf *byte-compile
	  :init
	  (leaf development
		:custom
		((debug-on-error . nil)
		 (byte-compile-no-warnings . t))
		)
	  )

	:preface
	(defun reopen-with-sudo ()
      "Reopen current buffer-file with sudo using tramp."
      (interactive)
      (let ((file-name (buffer-file-name)))
		(if file-name
			(find-alternate-file (concat "/sudo::" file-name))
          (error "Cannot get a file name"))))

	(leaf *lisp
      :config
      (leaf simple
		:custom ((kill-ring-max . 100)
				 (kill-read-only-ok . t)
				 (kill-whole-line . t)
				 (eval-expression-print-length . nil)
				 (eval-expression-print-level  . nil))
		;; :hook ((before-save-hook . delete-trailing-whitespace))
		)


	  (leaf autorevert
		:custom ((auto-revert-interval . 0.1)
				 (global-auto-revert-mode . t)))

	  (leaf delete-trailing-whitespace
		:hook (before-save-hook . delete-trailing-whitespace))

	  (leaf rainbow-delimiters
		:ensure t
		:hook (emacs-lisp-mode-hook . rainbow-delimiters-mode))

	  (leaf *keepscratchbuffer
		:doc "不死鳥と化したscratch buffer"
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
		;;
		(defun my:buffer-name-list ()
		  (mapcar (function buffer-name) (buffer-list)))
		:hook  ((kill-buffer-query-functions
				 . (lambda ()
					 (if (string= "*scratch*" (buffer-name))
						 (progn (my:make-scratch 0) nil)
					   t)))
				(after-save-hook
				 . (lambda ()
					 (unless (member "*scratch*" (my:buffer-name-list))
					   (my:make-scratch 1)))))
		)


	  (leaf dired
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
		:custom `((dired-recursive-copies    . 'always)
				  (dired-recursive-deletes   . 'always)
				  (dired-copy-preserve-time  . t)
				  (dired-auto-revert-buffer  . t)
				  (dired-dwim-target         . t)
				  ;; (delete-by-moving-to-trash . t)
				  ;; (dired-listing-switches    . "-Alhv --group-directories-first")
				  ;; 追加
				  (dired-launch-mailcap-frend . '("env" "xdg-open"))
				  (dired-launch-enable . t)
				  (dired-isearch-filenames . t)
				  (dired-listing-switches . ,(purecopy "-alht"))
				  )
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
		  (dired-up-directory t))

		:config
		(leaf dired-x :require t)
		(leaf wdired
		  :custom ((wdired-allow-to-change-permissions . t))
		  :bind ((dired-mode-map
				  :package dired
				  ("e" . wdired-change-to-wdired-mode)))
		  )
		(leaf dired-filter
		  :ensure t
		  :require t
		  ;; :hook ((dired-mode-hook . dired-filter-mode))
		  :bind ((dired-mode-map
				  :package dired
				  ("/" . dired-filer-map)))
		  )
		(leaf peep-dired
		  ;; :disabled t
		  :ensure t
		  :bind ((dired-mode-map
				  :package dired
				  ("P" . peep-dired)))
		  )
		(leaf async
		  :ensure t
		  :custom ((dired-async-mode . 1)
				   (async-bytecomp-package-mode . 1)
				   (async-bytecomp-allowed-packages . '(all)))
		  )
		(leaf dired-open
		  :ensure t
		  :require t
		  :when (eq system-type 'gnu/linux)
		  :custom ((dired-open-extensions . '(("mkv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("mp4"  . "~/projects/dotfilesotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("avi"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("wmv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("webm" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("mpg"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("flv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("m4v"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("mp3"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("wav"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("m4a"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("3gp"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("rm"   . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("rmvb" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("mpeg" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("VOB" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
											  ("iso" . "mpv dvd:// -dvd-device")
											  ("playlist" . "mpv --playlist")
											  ("exe"  . "wine")
											  ;; ("pdf"  . "YACReader")
											  ("zip"  . "YACReader")
											  ("rar"  . "YACReader")
											  ("tar"  . "YACReader")
											  ("xls"  . "xdg-open")
											  ("xlsx" . "xdg-open")
											  ("jpg"  . "sxiv-rifle")
											  ("png"  . "sxiv-rifle")
											  ("jpeg" . "sxiv-rifle")
											  ("gif"  . "sxiv-rifle")
											  ("png"  . "sxiv-rifle"))))
		  )
		(leaf dired-open
		  :ensure t
		  :require t
		  :when (eq system-type 'darwin)
		  :custom ((dired-open-extensions . '(("key" . "open")
											  ("docx" . "open")
											  ("pdf" . "open")
											  ("cmdf" . "open")
											  ("xlsx" . "open")
											  ("pxp" . "open")
											  ("bmp" . "open")
											  ))))

		)
	  )
	)

  (leaf *eshell-tools
	:bind (("C-c e" . eshell))
	:hook (eshell-mode-hook . eshell-alias)
	:defvar eshell-command-aliases-list
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
              (list "manga" "wine ~/Documents/Software/picture/MangaMeeya_73/MangaMeeya.exe")
              (list "backup" "~/.emacs.d/script/backup.sh $1")
              (list "nvidiafix" "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
              (list "usbmount" "sudo mount -t vfat $1 $2 -o rw,umask=000")
              (list "dvd" "mpv dvd:// -dvd-device $1")
              (list "dvdCopy" "dvdbackup -i /dev/sr0 -o ~/Downloads/iso/ -M")
              ))))
	(defun pcomplete/sudo ()
      "Completion rules for the `sudo' command."
      (let ((pcomplete-ignore-case t))
		(pcomplete-here (funcall pcomplete-command-completion-function))
		(while (pcomplete-here (pcomplete-entries)))))

	:config
	(leaf *unixCommandEmu
      :when (eq system-type 'gnu/linux)
      :config (eval-after-load "esh-module"
				'(defvar eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))))
	)

  (leaf *keybinding
	:bind (;; C-m : 改行プラスインデント
		   ("C-m" . newline-and-indent)
		   ;; ;; exwm用
		   ;; ("C-h" . delete-backward-char)
		   ;; C-x ? : help
		   ("C-c ?" . help-command)
		   ;;折り返しトグルコマンド
		   ("C-c l" . toggle-truncate-lines)
		   ;; ウィンドウサイズの変更のキーバインド
		   ("C-c r" . window-resizer)
		   ;; 行番号を表示
		   ("C-c t" . display-line-numbers-mode)
		   ;;スペース、改行、タブを表示する
		   ("C-c w" . whitespace-mode)
		   ;; 検索結果のリストアップ
		   ("C-c o" . occur)
		   ;; S式の評価
		   ("C-c C-j" . eval-print-last-sexp)
		   ;; async shell command
		   ("s-s" . async-shell-command)
		   ("C-x g" . magit-status)
		   ("C-S-n" . scroll-up_alt)
		   ("C-S-p" . scroll-down_alt)
		   ("<kp-divide>" . insertBackslash)
		   ("<kp-multiply>" . insertPipe)
		   ;; (isearch-mode-map
		   ;; 	("C-h" . isearch-del-char))
		   )

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

	:config
	;; (leaf *minibufferBackward
    ;;   :hook (minibuffer-setup-hook . minibuffer-delete-backward-char)
    ;;   :preface
    ;;   (defun minibuffer-delete-backward-char ()
	;; 	(local-set-key (kbd "C-h") 'delete-backward-char))
	;;   :bind ((isearch-mode-map
	;; 		  ("C-h" . isearch-delete-char)))
	;;   )
	:init
	(leaf *c-hSetting
	  :config
	  (global-set-key (kbd "C-h") 'delete-backward-char)
	  (defun minibuffer-delete-backward-char ()
		(local-set-key (kbd "C-h") 'delete-backward-char))
	  (add-hook 'minibuffer-setup-hook 'minibuffer-delete-backward-char)
	  (define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
	  )
	)
  (leaf *originalKeybingd
	:disabled t
	:config
	(load "init-keybinding" t)
	)
  )

(leaf *visual
  :when window-system
  :config
  (leaf doom-themes
	;; :disabled t
    :ensure t
    :custom ((doom-themes-enable-italic . t)
             (doom-themes-enable-bold . t))
	:custom-face ((doom-modeline-bar . '((t (:background "#6272a4")))))
	:config
	(load-theme 'doom-one t)
	)

  (leaf doom-modeline
	;; :disabled t
	:require t
    :ensure t
    :custom `((doom-modeline-buffer-file-name-style . 'truncate-with-project)
              (doom-modeline-icon . nil)
              (doom-modeline-major-mode-icon . nil)
              (doom-modeline-minor-modes . nil)
			  (line-number-mode . 0)
			  (column-number-mode . 0)
			  (doom-modeline-mode . t))
    )

  (leaf *afterSave
    :hook (after-save-hook . flashAfterSave)
    :preface
    (defun flashAfterSave ()
	  (interactive)
	  (let ((orig-fg (face-background 'mode-line)))
        (set-face-background 'mode-line "dark green")
        (run-with-idle-timer 0.1 nil
                             (lambda (fg) (set-face-background 'mode-line fg))
                             orig-fg)))
    )
  )


;; メジャーモードの設定
(leaf *major_mode
  :config
  (leaf ein :ensure t)

  (leaf rust-mode
	:ensure t
	:config
	(leaf racer :ensure t)
	)

  (leaf csv-mode :ensure t)

  (leaf vlf
	:ensure t
	:require vlf-setup)

  (leaf yaml-mode)

  (leaf *git-tool
	:config
	(leaf magit
	 :when (version<= "25.1" emacs-version)
	 :ensure t
	 )

	(leaf gitignore-mode :ensure t)
	)

  (leaf neotree :ensure t
	)

  )

(leaf *tex
  :config
  (leaf *original
	:disabled t
	:config
	(load "init-yatex" t))
  (leaf yatex
	;; :disabled t
    :ensure t
	:hook (yatex-mode-hook . (lambda () (auto-fill-mode -1)))
	:hook (yatex-mode-hook . reftex-mode)
	:bind (("C-c C-z" . ebib))
    :mode (("\\.tex\\'" . yatex-mode)
		   ("\\.ltx\\'"	. yatex-mode)
		   ("\\.cls\\'"	. yatex-mode)
		   ("\\.sty\\'"	. yatex-mode)
		   ("\\.clo\\'"	. yatex-mode)
		   ("\\.bbl\\'"	. yatex-mode))
    :custom `((YaTeX-inhibit-prefix-letter . t)
              (YaTeX-kanji-code . 4)
              (YaTeX-latex-message-code . 'utf-8)
              (YaTeX-use-LaTeX2e . t)
              (YaTeX-use-AMS-LaTeX . t)
              (YaTeX-dvi2-command-ext-alist . '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|atril\\|xreader\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|MicrosoftEdge\\|microsoft-edge\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
              (tex-command . "uplatex -synctex=1")
              ;; (tex-command  . "ptex2pdf -u -l -ot '-synctex=1 -file-line-error'")
              ;; (tex-command  . "ptex2pdf -l -ot '-synctex=1")
              (bibtex-command . "upbibtex")
              ;; (makeindex-command  . "mendex")
              (dviprint-command-format . "open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")
              (YaTeX-nervous . nil)
              (YaTeX-close-paren-always . nil))
	:init
	(leaf *YatexforMac
	  ;; :disabled t
	  :when (eq system-type 'darwin)
	  :custom ((dvi2-command . "open -a Skim")
			   (tex-pdfview-command . "open -a Skim")
			   )
	  :init
	  ;; (setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:/Applications/Skim.app/Contents/SharedSupport:$PATH" t)
	  ;; (setq exec-path (append '("/usr/local/bin" "/Library/TeX/texbin" "/Applications/Skim.app/Contents/SharedSupport") exec-path))

	  )


    :config
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

    ;; (leaf *forMac
    ;;   :when (eq system-type 'darwin)
    ;;   :custom ((exec-path . (append '("/usr/local/bin" "/Library/TeX/texbin" "/Applications/Skim.app/Contents/SharedSupport") exec-path))
    ;;            (dvi2-command . "open -a Skim")
    ;;            (tex-pdfview-command . "open -a Skim"))
    ;;   :config
    ;;   (setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:/Applications/Skim.app/Contents/SharedSupport:$PATH" t))

    (leaf reftex
      ;; :ensure t
      :hook (yatex-mode . reftex-mode)
      :custom ((reftex-mode . 1)
               (reftex-label-alist . '((nil ?e nil "\eqref{%s}" nil nil)))
               (reftex-default-bibliography . '("~/tex/references.bib"))
               (reftex-bibliography-commands . '("bibliography" "nobibliography" "addbibresorce")))

      :bind ((reftex-mode-map
              (">" . YaTeX-comment-region)
              ("<" . YaTeX-uncomment-region))))

	(leaf ebib
      :ensure t
      ;; :bind (("C-c C-z" . ebib))
      :custom ((ebib-preload-bib-files . "~/tex/references.bib")
               (bibtex-autokey-name-case-convert  . capitalize)
               (bibtex-autokey-titleword-case-convert  . capitalize)
               (bibtex-autokey-titleword-separator  . "")
               (bibtex-autokey-titleword-length  . nil)
               (bibtex-autokey-titlewords  . 1)
               (bibtex-autokey-year-length  . 4)
               (bibtex-autokey-year-title-separator  . "_")
               (bibtex-autokey-titleword-ignore . '("A" "An" "On" "The" "a" "an" "on" "the" "Le" "La" "Les" "le" "la" "les" "Zur" "zur" "Des" "Dir" "Die"))
               (ebib-keywords-use-only-file . t)
               (ebib-keywords-file . "~/tex/ebib-keywords.txt")
               (ebib-keywords-file-save-on-exit . always)

               (ebib-file-search-dirs . '("~/tex/papers" "~/tex/books"))
               (ebib-file-associations . '(("pdf" . "open") ("ps"  . "open")))))
	)
  )

(leaf google-translate
  :ensure t
  :require t
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

(leaf *window-tools
  :custom (;; スクロールした際のカーソルの移動行数
           (scroll-conservatively . 1)
           ;; スクロール開始のマージン
           (scroll-margin . 5)
           ;; 1画面スクロール時に重複させる行数
           (next-screen-context-lines . 10)
           ;; 1画面スクロール時にカーソルの画面上の位置をなるべく変えない
           (scroll-preserve-screen-position . t)
           (windmove-wrap-around . t)
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

  :config
  (leaf zoom-window
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
           ("s-o" . ivy-switch-buffer))
	)

  (leaf *mySaveFrame
	:when (eq system-type 'darwin)
    :hook ((emacs-startup-hook . my-load-frame-size)
	  	   (kill-emacs-hook . my-save-frame-size))
	:defun my-save-frame-size my-load-frame-size
	:defvar my-save-frame-file
	:custom ((my-save-frame-file . "~/.emacs.d/.framesize"))
    :preface
    ;; (defconst my-save-frame-file
    ;;   "~/.emacs.d/.framesize"
    ;;   "フレームの位置、大きさを保存するファイルのパス")

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
             (file my-save-frame-file)
             )
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
	;; (add-hook 'emacs-startup-hook 'my-load-frame-size)
	;; (add-hook 'kill-emacs-hook 'my-save-frame-size)
	:config
    (run-with-idle-timer 60 t 'my-save-frame-size)

    )

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
    :config (global-hl-line-mode)
	)
  )

(leaf *view_mode
  :config
  (leaf view
	;; (leaf keys-in-view-mode
    ;; :ensure t
    :custom ((view-read-only . t))
    :bind
    (("C-;" . view-mode)
     (view-mode-map
      ("SPC" . ignore)
      ("C-m" . ignore)
      ("h" . backward-char)
      ("j" . next-line)
      ("k" . previous-line)
      ("l" . forward-char)
      ("J" . View-scroll-line-forward)
      ("K" . View-scroll-line-backward)
      ("b" . backward-char)
      ("n" . next-line)
      ("p" . previous-line)
      ("f" . forward-char)
      ("C-;" . ignore)
      ("a" . vim-forward-char-to-insert)
      ("A" . vim-end-of-line-to-insert)
      ("I" . vim-beginning-of-line-to-insert)
      ("i" . View-exit)
      ("x" . vim-del-char)
      ("X" . vim-backward-kill-line)
      ("0" . beginning-of-line)
      ("$" . move-end-of-line)
      ("e" . end-of-line)
      ("o" . vim-o)
      ("O" . vim-O)
      ("y" . copy-region-as-kill)
      ("Y" . vim-copy-line)
      ("w" . forward-word+1)
      ("W" . backward-word)
      ;; ("P" . vim-P)
      ("D" . vim-kill-line)
      (":" . save-buffer)
      ("u" . ignore)
      ("u" . vim-undo)
      ("r" . vim-redo)
      ("d" . vim-kill-whole-line)
      ("c" . vim-kill-whole-line-to-insert)
      ("g" . View-goto-line)
      ("G" . View-goto-percent)))))

(leaf multi-term
  :disabled t
  :ensure t
  :custom ((multi-term-program . shell-file-name))
  :config
  ;; キーを取り戻す
  (add-to-list 'term-unbind-key-list '"M-x")
  (add-to-list 'term-unbind-key-list '"C-j")
  (add-to-list 'term-unbind-key-list '"C-l")
  (add-to-list 'term-unbind-key-list '"C-o")
  (add-hook 'term-mode-hook
            '(lambda ()
               ;; C-hをterm内文字削除にする
               (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
               ;; C-yをterm内ペーストにする
               (define-key term-raw-map (kbd "C-y") 'term-paste)
               (define-key term-raw-map (kbd "C-j") 'skk-hiragana-set)
               (define-key term-raw-map (kbd "C-q") 'skk-katakana-set)
               (define-key term-raw-map (kbd "C-l") 'skk-latin-mode-on)
               ))
  (global-set-key (kbd "C-c q")
                  '(lambda ()
					 (interactive)
					 (if (get-buffer "*terminal<1>*")
						 (switch-to-buffer "*terminal<1>*")
                       (multi-term)))))

(leaf eww
  ;; :disabled t
  :hook (eww-mode-hook . eww-mode-hook--disable-image)
  :defvar eww-disable-colorize shr-put-image-function
  :defun eww-reload
  :custom ((eww-search-prefix . "https://www.google.co.jp/search?btnl&q=")
           (eww-browse-with-external-link . t)
           (eww-disable-colorize . t))
  :bind (("C-c m" . browse-url-with-eww)
         (eww-mode-map
          ("f" . ace-link-eww)
          ("s-l" . eww-search-words)
          ("M" . eww-open-in-new-buffer)
          ("s-w" . eww-buffer-kill)
          ("C-s-v" . eww-enable-images)
          ("s-v" . eww-disable-images)
          ("s-e" . eww-browse-with-external-browser)
          ("h" . backward-char)
          ("j" . next-line)
          ("k" . previous-line)
          ("l" . forward-char)
          ("J" . View-scroll-line-forward)
          ("K" . View-scroll-line-backward)
          ("H" . eww-back-url)
          ("L" . eww-forward-url)
          ("J" . previous-buffer)
          ("K" . next-buffer)
          ("d" . scroll-up)
          ("u" . scroll-down)))

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
  (defun eww-mode-hook--disable-image ()
    (setq-local shr-put-image-function 'shr-put-image-alt))
  (defun browse-url-with-eww ()
    (interactive)
    (let ((url-region (bounds-of-thing-at-point 'url)))
      ;; url
      (if url-region
          (eww-browse-url (buffer-substring-no-properties (car url-region)
                                                          (cdr url-region))))
      ;; org-link
      (setq browse-url-browser-function 'eww-browse-url)
      ;; (org-open-at-point)
	  )
	)
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

(leaf *org_tools
  :disabled t
  :config
  (leaf org-mode
    :custom ((org-todo-keywords . '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)"))))
    ))

(leaf pdf-tools
  :when (file-exists-p "/usr/bin/epdfinfo")
  :ensure t
  :require pdf-tools pdf-annot pdf-history pdf-info pdf-isearch pdf-links pdf-misc pdf-occur pdf-outline pdf-sync tablist-filter tablist
  :hook ((pdf-view-mode-hook . pdf-misc-size-indication-minor-mode)
		 (pdf-view-mode-hook . pdf-links-minor-mode)
		 (pdf-view-mode-hook . pdf-isearch-minor-mode))
  )


;; マイナーモードの設定
(leaf *minor-mode
  :config

  (leaf skk
    :ensure ddskk
	;; :defun (skk-get)
    :require t skk-study
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
             (dolist (skk-kakutei (skk-toggle-kana nil))))))
    )

  (leaf cua
	:bind (("C-x SPC" . cua-set-rectangle-mark))
	:custom ((cua-mode . t)
			 (cua-enable-cua-keys . nil)))

  (leaf company
    :ensure t
    :leaf-defer nil
    :diminish company-mode
    :bind ((company-active-map
            ("M-n" . nil)
            ("M-p" . nil)
            ("C-s" . company-filter-candidates)
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)
            ("<tab>" . company-complete-selection)
			("C-h" . nil)
			("C-f" . company-complete-selection)
			)
           (company-search-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)))
    :custom `((company-tooltip-limit         . 12)
              (company-idle-delay            . 0)
              (company-minimum-prefix-length . 3)
              (company-transformers          . '(company-sort-by-occurrence))
              (global-company-mode           . t))
    :config
    (leaf company-math
	  :ensure t
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
			 (yatex-mode-hook . c/latex-mode-setup))
	  )

	(leaf company-quickhelp
	  :disabled t
	  :when (display-graphic-p)
	  :ensure t
	  :custom ((company-quickhelp-delay . 0.8)
			   (company-quickhelp-mode  . t))
	  :bind (company-active-map
             ("M-h" . company-quickhelp-manual-begin))
	  :hook ((company-mode-hook . company-quickhelp-mode))
	  )

	(leaf *companyFor
	  :disabled t
	  :when (eq system-type 'gnu/linux)
	  :config
      (leaf company-tabnine
		:doc "M-x company-tabnine-install-binary to install binary"
		:disabled t
		:ensure t
		:config
		(add-to-list 'company-backends #'company-tabnine))

      (leaf company-prescient
		:ensure t
		:custom ((company-prescient-mode . t)))

      (leaf company-c-headers
		:ensure t
		:config (add-to-list 'company-backends 'company-c-headers))

      (leaf company-box
		:url "https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-company.el"
		:when (version<= "26.1" emacs-version)
		:disabled (eq window-system 'x)
		:ensure t
		:diminish company-box-mode
		:defvar (company-box-icons-alist company-box-icons-all-the-icons)
		:init (leaf all-the-icons :ensure t :require t)
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
          (setq company-box-icons-alist 'company-box-icons-all-the-icons)))
	  )
	)

  (leaf ivy
	:ensure t
	:leaf-defer nil
    ;; :disabled t
    :custom `((ivy-re-builders-alist . '((t . ivy--regex-plus)))
			  (ivy-use-selectable-prompt . t)
			  (ivy-mode . t)
			  (counsel-mode . t)
			  (dired-recent-mode . t)
			  (ivy-use-virtual-buffers . t)
			  (ivy-truncate-lines . nil)
			  (ivy-wrap . t)
			  (enable-recursive-minibuffers . t)
			  (ivy-height . 15)
			  (ivy-extra-directories . nil)
			  (ivy-format-functions-alist . '((t . ivy-format-function-arrow)))
			  )

    :bind (("C-x b" . ivy-switch-buffer)
		   (ivy-minibuffer-map
            ;; ESC連打でミニバッファを閉じる
            ("<escape>" . minibuffer-keyboard-quit)
            ("C-m" . ivy-alt-done)
            ("C-i" . ivy-immediate-done)))
	:init
	(leaf counsel
	  ;; :ensure t
	  :defvar counsel-find-file-ignore-regexp
	  :custom ((counsel-mode . 1)
			   (counsel-find-file-ignore-regexp . (regexp-opt '("./" "../")))
			   (recentf-max-saved-items . 2000)
			   (recentf-auto-cleanup .'never)
			   (recentf-exclude .'("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
			   (recentf-mode . 1)
			   (counsel-yank-pop-separator . "\n-------\n")
			   )

	  :bind
	  (("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file)
	   ("C-c h" . counsel-recentf)
	   ("C-c i" . imenus)
	   ("M-y" . counsel-yank-pop)
	   ("C-x C-b" . counsel-ibuffer)
	   ("C-M-f" . counsel-ag))
	  :config

	  (leaf counsel-osx-app
        ;; :ensure t
        :when (eq system-type 'darwin)
        :bind ("s-d" . counsel-osx-app)
        :custom
        ((counsel-osx-app-location.
		  '("/Applications"
            "/Applications/Downloads"
            "/Applications/Flip4Mac"
            "/Applications/GoogleJapaneseInput.localized"
            ;; "/Applications/Igor Pro 6.1 Folder"
            "/Applications/Igor Pro 6.3 Folder"
            "/Applications/iWork '09"
            "/Applications/Microsoft Office 2011"
            "/Applications/Python 2.7"
            "/Applications/RIETAN_VENUS"
            "/Applications/Utilities")))
		)
	  )

    (leaf swiper
	  :ensure t
	  :defvar swiper-include-line-number-in-search
	  :bind ("C-c C-;" . swiper)
	  :custom (swiper-include-line-number-in-search . t))

    :config
    (leaf ivy-hidra
	  :ensure t
	  :disabled t
	  :custom (ivy-read-action-function . #'ivy-hydra-read-action)
	  )

    (leaf ivy-dired-history
	  ;; :disabled t
	  :require t
	  :ensure t
	  :defvar session-globals-include
	  :bind ((dired-mode-map
			  ("," . dired))
             (ivy-dired-history-map
			  ("C-m" . ivy-alt-done)))
	  :config
	  (leaf *afterLoad
        :after session
        :config (add-to-list 'session-globals-include 'ivy-dired-history-variable))
	  )
	)

  (leaf *hs-minor-mode
	:hook ((emacs-lisp-mode-hook . hs-minor-mode))
	:custom ((hs-minor-mode . t))
	:bind (("C-'" . hs-toggle-hiding))
	)

  (leaf highlight-indent-guides-mode
	:hook ((prog-mode-hook . highlight-indent-guides-mode))
	:custom '((highlight-indent-guides-method . 'column)
			  ;; (highlight-indent-guides-auto-enable . t)
			  ;; (highlight-indent-guides-responsive . t)
			  ;; (highlight-indent-guides-mode . t)
			  )
	)

  (leaf visual-regexp-steroids
	:ensure t
	:require t
	:bind (("M-%" . vr/query-replace)
		   ;; multiple-cursorsを使っているならこれで
           ("C-c m" . vr/mc-mark)
           ;; 普段の正規表現isearchにも使いたいならこれを
           ("C-M-r" . vr/isearch-backward)
           ("C-M-s" . vr/isearch-forward))
	:custom `((vr/engine . 'python))
	)

  (leaf page-ext
	;; :disabled t
	:require t)

  )


;; 途中の設定
(leaf mew
  :disabled t
  :when (file-exists-p '"/usr/bin/stunell")
  :ensure t
  :defvar mew-fcc mew-smtp-server mew-smtp-auth
  :custom ((exec-path . '(cons "/usr/bin" exec-path))
  		   (user-mail-address . "frenzieddoll@gmail.com")
  		   (user-full-name . "frenzieddoll")
  		   (mew-smtp-server . "smtp.gmail.com")
  		   (mail-user-agent . 'mew-user-agent)
  		   ;; Stunnel
  		   (mew-prog-ssl . "/usr/bin/stunnel")
  		   ;; IMAP for Gmail
  		   (mew-proto . "%")
  		   (mew-imap-server . "imap.gmail.com")
  		   (mew-imap-user . "frenzieddoll@gmail.com")
  		   (mew-imap-auth .  t)
  		   (mew-imap-ssl . t)
  		   (mew-imap-ssl-port . "993")
  		   (mew-smtp-auth . t)
  		   (mew-smtp-ssl . t)
  		   (mew-smtp-ssl-port . "465")
  		   (mew-smtp-user . "frenzieddoll@gmail.com")
  		   (mew-smtp-server . "smtp.gmail.com")
  		   (mew-fcc . "%Sent")
  		   (mew-imap-trash-folder . "%[Gmail]/Trash")
  		   (mew-use-cached-passwd . t)
  		   (mew-ssl-verify-level . 0)

  		   (mew-use-cached-passwd . t)
  		   (mew-use-master-passwd . t)
  		   ;; 未読メールにUマークを付ける
  		   (mew-use-unread-mark . t))
  :config
  (define-mail-user-agent
	'mew-user-agent
	'mew-user-agent-compose
	'mew-draft-send-message
	'mew-draft-kill
	'mew-send-hook)
  )


(leaf *lsp-tools
  :when (eq system-type 'gnu/linux)
  :config
  (leaf eglot
	:ensure t
	:custom `((lsp-document-sync-method . 'full)
			  (haskell-indent-after-keywords . '(("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let"))
			  (haskell-indent-offset . 4)
			  (haskell-indendt-spaces . 4)
			  )
	:config
	(fset #'eglot--snippet-expansion-fn #'ignore)

	(leaf haskell-mode
	  :disabled t
	  :after eglot
	  :ensure t
	  :defvar haskell-process-args-ghcie
	  :custom `(;; (flymake-proc-allowed-file-name-masks . ,(delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
	  			(haskell-process-type . 'stack-ghci)
	  			(haskell-process-path-ghci . "stack")
	  			(haskell-process-args-ghcie . "ghci")
	  			)

	  :bind ((haskell-mode-map
			  :package eglot
			  ("C-c C-j" . eglot-help-at-point)
			  ("C-c C-c" . eglot-rename)
			  )
			 )
	  :hook ((haskell-mode-hook . eglot-ensure)
	  		 (haskell-mode-hook . interactive-haskell-mode)
	  		 (haskell-mode-hook . haskell-decl-scan-mode)
	  		 (haskell-mode-hook . haskell-doc-mode)
	  		 (haskell-mode-hook . haskell-indentation-mode)
	  		 )
	  :config

	  (leaf *flaymakeFileAutoRemove
		:after haskell-mode
		:custom `((flymake-proc-allowed-file-name-masks . ,(delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
				  )

		)

	  (add-to-list 'company-backends 'company-ghci)

	  )

	)
  )

(leaf *news
  :disabled t
  :custom `((newsticker-url-list . '(("GIGAZIN" "http://gigazine.net/news/rss_2.0/")
                                     ("CNN" "http://feeds.cnn.co.jp/cnn/rss")
                                     ("痛いニュース" "http://blog.livedoor.jp/dqnplus/index.rdf")
                                     ("ねとらぼ" "https://rss.itmedia.co.jp/rss/2.0/netlab.xml")
                                     ("カオスちゃんねる" "http://chaos2ch.com/index.rdf")
                                     ("不思議.net" "http://world-fusigi.net/index.rdf")
                                     ))
			(newsticker-url-list-defaults . '(("オレ的ゲーム速報JIN" "http://jin115.com/index.rdf")))
			(newsticker-retrieval-interval . 0)
			(newsticker-html-renderer . 'shr-render-region)
			)
  :bind ((newsticker-treeview-mode-map
		  ("b" . newsticker-treeview-prev-feed)
		  )
		 )
  :config
  ;; (setq-default newsticker-url-list-defaults
  ;;             '(("オレ的ゲーム速報JIN" "http://jin115.com/index.rdf")))

  )

(leaf exwm
  ;; :disabled t
  :ensure t
  ;; :when (string= "yes" (getenv "exwm_enable"))
  :when (eq system-type 'gnu/linux)
  :init
  (server-start)
  :config
  (leaf *exwm-config
	:require exwm
	:defun (exwm-workspace-rename-buffer exwm-workspace-toggle)
	:hook (exwm-update-class-hook . (lambda ()
									  (exwm-workspace-rename-buffer exwm-class-name)))

	:hook (exwm-manage-finish-hook . (lambda ()
									   (when (and exwm-class-name
												  (string= "Alacritty" exwm-class-name))
										 (exwm-input-release-keyboard))))
	:custom `((use-dialog-box . nil)
			  (window-divider-default-right-width . 1)
			  (exwm-workspace-show-all-buffers . t)
			  (exwm-layout-show-all-buffers . t)
			  (exwm-workspace-number . 3)
			  (exwm-input-global-keys . '((,(kbd "s-r") . exwm-reset)
										  (,(kbd "s-d") . counsel-linux-app)
										  (,(kbd "s-n") . windmove-down)
										  (,(kbd "s-f") . windmove-right)
										  (,(kbd "s-b") . windmove-left)
										  (,(kbd "s-p") . windmove-up)
										  (,(kbd "s-<tab>") . exwm-workspace-toggle)
										  (,(kbd "s-a") . zoom-window-zoom)
										  (,(kbd "C-s-i") . output_toggle)
										  (,(kbd "C-s-m") . mute_toggle)
										  (,(kbd "C-s-n") . lower_volume)
										  (,(kbd "C-s-p") . upper_volume)
										  (,(kbd "s-q") . kill-current-buffer)
										  (,(kbd "s-h") . delete-window)
										  (,(kbd "s-SPC") . exwm-floating-toggle-floating)
										  (,(kbd "s-e") . exwm-input-toggle-keyboard)
										  (,(kbd "s-o") . ivy-switch-buffer)
										  (,(kbd "s-r") . exwm-reset)
										  (,(kbd "s-d") . counsel-linux-app)
										  (,(kbd "C-j") . ,(kbd "C-&"))
										  (,(kbd "C-l") . ,(kbd "C-^"))
										  ,@(mapcar (lambda (i)
													  `(,(kbd (format "s-%d" i)) .
														(lambda ()
														  (interactive)
														  (exwm-workspace-switch-create ,i))))
													(number-sequence 0 9))
										  )
									  )
			  (exwm-input-simulation-keys . '(
											  ;; new version
											  (,(kbd "C-b") . [left])
											  (,(kbd "M-b") . [C-left])
											  (,(kbd "C-f") . [right])
											  (,(kbd "M-f") . [C-right])
											  (,(kbd "C-p") . [up])
											  (,(kbd "C-n") . [down])
											  (,(kbd "C-a") . [home])
											  (,(kbd "C-e") . [end])
											  (,(kbd "M-v") . [prior])
											  (,(kbd "C-v") . [next])
											  (,(kbd "C-d") . [delete])
											  (,(kbd "C-k") . [S-end ?\C-x])
											  (,(kbd "M-<") . [C-home])
											  (,(kbd "M->") . [C-end])
											  (,(kbd "C-/") . [C-z])
											  ;; C-h は特別扱い扱い
											  ([?\C-h] . [backspace])
											  (,(kbd "C-m") . [return])
											  (,(kbd "C-/") . [C-z])
											  (,(kbd "C-S-f") . [S-right])
											  (,(kbd "C-S-b") . [S-left])
											  (,(kbd "C-S-p") . [S-up])
											  (,(kbd "C-S-n") . [S-down])
											  (,(kbd "C-w") . ,(kbd "C-x"))
											  (,(kbd "M-w") . ,(kbd "C-c"))
											  (,(kbd "C-y") . ,(kbd "C-v"))
											  (,(kbd "s-v") . ,(kbd "C-v"))
											  (,(kbd "C-x h") . ,(kbd "C-a"))
											  (,(kbd "M-d") . [C-S-right ?\C-x])
											  (,(kbd "M-<backspace>") . [C-S-left ?\C-x])
											  ;; search
											  (,(kbd "C-s") . ,(kbd "C-f"))
											  ;; escape
											  (,(kbd "C-g") . [escape])
											  ;; like mac
											  (,(kbd "s-w") . [C-w])
											  ([s-left] . [C-S-tab])
											  ([s-right] . [C-tab])
											  ;; ([s-up] . [C-tab])
											  ;; ([s-down] . [C-tab])
											  (,(kbd "s-t") . [C-t])
											  (,(kbd "s-T") . [C-T])
											  ;; skk switch change
											  ;; (,(kbd "C-j") . [C-&])
											  ;; (,(kbd "C-l") . [C-^])
											  (,(kbd "s-l") . [C-k])
											  (,(kbd "s-k") . [C-l])
											  ;; test
											  (,(kbd "C-x C-s") . [C-s])
											  (,(kbd "C-u C-/") . [C-y])
											  ))
			  )
	:bind (("C-&" . skk-hiragana-set)
		   ("C-^" . skk-latin-mode))
	:preface
	(defun exwm-workspace-toggle ()
	  (interactive)
	  (if (= exwm-workspace-current-index 0)
		  (exwm-workspace-switch 2)
		(exwm-workspace-switch 0)))
	:config
	(exwmx-floating-smart-hide)
    (exwmx-button-enable)
	)

  (leaf exwm-systemtray
	:require t
	:defun exwm-systemtray-enable
	:config
	(exwm-systemtray-enable)
	)

  (leaf exwm-randr
	:require t
	:custom (
			 (exwm-randr-workspace-monitor-plist . '(0 "DP-0" 1 "HDMI-0" 2 "DP-0" 3 "DP-0" 4 "DP-0" 5 "DP-0"))

			 )
	:config
	(exwm-randr-enable)

	)

  ;; (leaf *exwm-keybinding
  ;; 	:custom
  ;; 	:config)

  (leaf exwm-enable
	:defun (exwm-enable)
	:config
	(exwm-enable)
	;; (provide 'init-exwm)
	)

  (leaf *fix_ediff
	:after ediff-wind
	:custom `((ediff-window-setup-function . 'ediff-setup-windows-plain)
			  ;; (ediff-control-frame-parameters . (cons '(unsplittable . t) ediff-control-frame-parameters))
			  )
	)
  )
