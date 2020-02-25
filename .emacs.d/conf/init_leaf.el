(prog1 "prepare leaf"
  (prog1 "package"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
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

(leaf init_system
  :defvar show-paren-deley
  :custom (
           ;; システムの時計をCにする
           (system-time-locale . "C")
           ;; 改行コードを表示する
           (eol-mnemonic-dos . "(CRLF)")
           (eol-mnemonic-mac . "(CR)")
           (eol-mnemonic-unix . "(LF)")
           ;; 右から左に読む言語に対応させないことで描画高速化
           (bidi-display-reordering . nil)
           ;; splash screen を無効化
           (inhibit-splash-screen . t)
           ;; 同じ内容を履歴に記録しない
           (history-delete-duplicates . t)
           ;; バックアップファイ及び、自動セーブの無効
           (make-backup-files . nil)
           (delete-auto-save-files . t)
           (auto-save-default . nil)
           ;;列番号を表示
           (column-number-mode . t)
           ;; スタートアップメッセージを表示させない
           (inhibit-startup-message . t)
           ;; 起動時に*scratch*バッファを表示する
           (initial-buffer-choice . t)
           (initial-scratch-message . "")
           ;; beep音を消す
           (ring-bell-function . 'ignore)
           ;; タブにスペースを使用する
           (tab-width . 4)
           (indent-tabs-mode . t)
           ;; カーソルの点滅をやめる
           (blink-cursor-mode . nil)
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
           ;; 折り返し禁止
           (truncate-lines . t)
           ;; シンボリック経由でファイルを開く
           (vc-follow-symlinks . t)
           )

  :preface
  (defun reopen-with-sudo ()
    "Reopen current buffer-file with sudo using tramp."
    (interactive)
    (let ((file-name (buffer-file-name)))
      (if file-name
          (find-alternate-file (concat "/sudo::" file-name))
        (error "Cannot get a file name"))))

  :config
  (leaf delete-space
    :hook (before-save-hook . delete-trailing-whitespace))

  (leaf rainbow-delimiters
    :ensure t
    :hook (emacs-lisp-mode-hook . rainbow-delimiters-mode))

  (leaf uniquify
    :require t
    :custom ((uniquify-buffer-name-style . 'post-forward-angle-brackets)
             (uniquify-ignore-buffer-re . "[^*]+")))

  (leaf exec-path-from-shell
    :ensure t
    :custom ((exec-path-from-shell-initialize . t)))

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
						  :height 150)))

  (leaf *mics
    :config
    (display-time)
    (setq display-time-string-forms
          '((format "%s/%s(%s)%s:%s"
    	            month day dayname
    	            24-hours minutes
                    )))
    (set-face-background 'region "#555")
    (fset 'yes-or-no-p 'y-or-n-p)
    ;; メニューバー、ツールバー、スクロールバーの非表示
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1))
  )

(leaf *skk-tools
  :config
  (leaf skk
    :ensure ddskk
    :require t skk-study
    :defvar skk-user-directory
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
              (skk-rom-kana-rule-list . (append skk-rom-kana-rule-list
                                                '(("ll" nil "っ")
                                                  ("xn" nil "ん")
                                                  ("xx" nil "っ")
                                                  ("z," nil ",")
                                                  ("z." nil ".")
                                                  ("z[" nil "[")
                                                  ("z]" nil "]")
                                                  ("z-" nil "-")
                                                  ("!" nil "!")
                                                  ("." nil "。")
                                                  ("," nil "、")
                                                  (":" nil ":")
                                                  (";" nil ";")
                                                  ("?" nil "?")
                                                  ("la" nil "ぁ" )
                                                  ("li" nil "ぃ" )
                                                  ("lu" nil "ぅ" )
                                                  ("le" nil "ぇ" )
                                                  ("lo" nil "ぉ" )))))

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
  )

(leaf *cua
  :bind (("C-x SPC" . cua-set-rectangle-mark))
  :custom ((cua-mode . t)
           (cua-enable-cua-keys . nil)))

(leaf *eshell-tools
  :bind (("C-c e" . eshell))
  :hook (eshell-mode-hook . eshell-alias)
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

(leaf *dired-tools
  :config

  (leaf *dired
    :custom ((dired-dwim-target . t)
             (dired-launch-mailcap-frend . '("env" "xdg-open"))
             (dired-launch-enable . t)
             (dired-isearch-filenames . t))

    :bind ((dired-mode-map
            :package dired
            ("j" . dired-next-line)
            ("k" . dired-previous-line)
            ("h" . kill-current-buffer-and-dired-up-directory)
            ("l" . kill-current-buffer-and/or-dired-open-file)
            ("f" . kill-current-buffer-and/or-dired-open-file)
            ("b" . kill-current-buffer-and-dired-up-directory)
            ("q" . kill-current-buffer-and-dired-up-directory)))

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
    (setq dired-listing-switches (purecopy "-alht"))
    (setq dired-recursive-copies 'always))

  (leaf dired-filter
    :ensure t
    :bind ((dired-mode-map
            ("/" . dired-filter-map))))

  (leaf wdired
    :ensure t
    :custom ((wdired-allow-to-change-permissions . t))
    :bind (dired-mode-map ("e" . wdired-change-to-wdired-mode)))

  (leaf peep-dired
     :ensure t
     :bind ((dired-mode-map
             ("P" . peep-dired))))

  (leaf async
    :ensure t
    :custom ((dired-async-mode . 1)
             (async-bytecomp-package-mode . 1)
             (async-bytecomp-allowed-packages . '(all))))

  (leaf dired-open
    :ensure t
    :when (eq system-type 'gnu/linux)
    :custom ((dired-open-extensions '(("mkv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
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
                                      ("pdf"  . "YACReader")
                                      ("zip"  . "YACReader")
                                      ("rar"  . "YACReader")
                                      ("tar"  . "YACReader")
                                      ("xls"  . "xdg-open")
                                      ("xlsx" . "xdg-open")
                                      ("jpg"  . "sxiv-rifle")
                                      ("png"  . "sxiv-rifle")
                                      ("jpeg" . "sxiv-rifle")
                                      ("gif"  . "sxiv-rifle")
                                      ("png"  . "sxiv-rifle")))))
  (leaf dired-open
    :ensure t
    :when (eq system-type 'darwin)
    :custom ((dired-open-extensions '(("key" . "open")
                                      ("docx" . "open")
                                      ("pdf" . "open")
                                      ("cmdf" . "open")
                                      ("xlsx" . "open")
                                      ("pxp" . "open")
                                      ("bmp" . "open")
                                      ))))

  (leaf dired-subtree
    :ensure t
    :bind ((dired-mode-map
            ("<right>" . dired-subtree-insert)
            ("<left>" . dired-subtree-remove)
            ("C-x n n" . dired-subtree-narrow))))

  )

(leaf *keybinding
  :bind ((;; C-m : 改行プラスインデント
          ("C-m" . newline-and-indent)
          ;;exwmを使う時はこっち
          ("C-h" . delete-backward-char)
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
          (isearch-mode-map
           ("C-h" . isearch-delete-char)
          )))

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
  (leaf *minibufferBackward
    :hook (minibuffer-setup-hook . delete-backward-char)
    :preface
    (defun minibuffer-delete-backward-char ()
      (local-set-key (kbd "C-h") 'delete-backward-char)))
  )

(leaf *visual
  :when window-system
  :config
  (leaf smart-mode-line
    :ensure t
    :custom
    (;; この変数を定義しておかないとエラーになるバグあり
     (sml/active-background-color . "gray60")
     ;; 読み込み専用バッファは%で表示
     (sml/read-only-char . "%%")
     ;; 修正済みバッファは*で表示
     (sml/modified-char . "*")
     ;; これがないと表示がはみでる
     (sml/extra-filler . -10)
     (sml/no-confirm-load-theme . t))
    :config
    ;; sml/replacer-regexp-listはモードラインでのファイル名表示方法を制御
    ;; (add-to-list 'sml/replacer-regexp-list '("^.+/junk/[0-9]+/" ":J:") t)
    (sml/setup)
    (sml/apply-theme 'respectful))

  (leaf doom-themes
    :ensure t
    :custom
    ((doom-themes-enable-bold . t)
     (doom-themes-enable-italic . t))
    :config
    (load-theme 'doom-one t))

  (leaf *afterSave
    :hook (after-save-hook . (lambda ()
                               (let ((orig-fg (face-background 'mode-line)))
                                 (set-face-background 'mode-line "dark green")
                                 (run-with-idle-timer 0.1 nil
                                                      (lambda (fg) (set-face-background 'mode-line fg))
                                                      orig-fg))))))

(leaf *completions
  :config
  (leaf company
	:ensure t
	:custom ((company-transformers . company-sort-by-backend-importance) ;; ソート順
             ;; デフォルトは0.5,nil:手動補完
             (company-idle-delay . 0.01)
             ;; デフォルトは4
             (company-minimum-prefix-length . 3)
             (company-selection-wrap-around . t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
             (completion-ignore-case . t)
             (company-dabbrev-downcase . nil)
			 )
	:bind (("C-M-i" . company-complete)
		   (company-active-map
			("C-n" . company-select-next)
			("C-p" . company-select-previous)
			("C-s" . company-filter-candidates) ;; C-sで絞り込む
			("C-i" . company-complete-selection) ;; TABで候補を設定
		   	("C-f" . company-complete-selection) ;; C-fで候補を設定
			;; ("<tab>" . company-complete-selection) ;; TABで候補を設定
			("C-h" . nil)) ;; バックスペースを取り
		   (company-search-map
			("C-n" . company-select-next)
			("C-p" . company-select-previous))
		   (emacs-lisp-mode-map
			("C-i" . company-complete))) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
	:preface
	(defun company-mode/backend-with-yas (backend)
	  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
		  backend
		(append (if (consp backend) backend (list backend))
				'(:with company-yasnippet))))

    :config
	(global-company-mode)
	(leaf *company-yas
	  :custom ((company-mode/enable-yas . t)
			   (company-backends . (mapcar #'company-mode/backend-with-yas company-backends))))
	;; (load "init-company" t)
	)

  (leaf ivy
    ;; :ensure t
    :custom
    (;; ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
     (ivy-use-virtual-buffers . t)
     ;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
     (ivy-truncate-lines . nil)
     (ivy-wrap . t)
     (enable-recursive-minibuffers . t)
     (ivy-height . 15)
     (ivy-extra-directories . nil)
     (ivy-re-builders-alist . '((t . ivy--regex-plus)))
     (ivy-mode . t))

    :bind
    (("C-x b" . ivy-switch-buffer)
     (ivy-minibuffer-map
     ;; ESC連打でミニバッファを閉じる
      ("<escape>" . minibuffer-keyboard-quit)
      ("C-m" . ivy-alt-done)
      ("C-i" . ivy-immediate-done)))
    :config

    (leaf ivy-hidra
      ;; :ensure t
      :custom (ivy-read-action-function . #'ivy-hydra-read-action))

    (leaf ivy-dired-history
      ;; :ensure t
      :bind ((dired-mode-map
              ("," . dired))
             (ivy-dired-history-map
              ("C-m" . ivy-alt-done))))

    (leaf counsel
      ;; :ensure t
      :defvar counsel-find-file-ignore-regexp
      :custom ((counsel-mode . 1)
               (counsel-find-file-ignore-regexp . (regexp-opt '("./" "../")))
               (recentf-max-saved-items . 2000)
               (recentf-auto-cleanup .'never)
               (recentf-exclude .'("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
               (recentf-mode . 1))

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
            "/Applications/Utilities"))))
      )

    (leaf swiper
      :ensure t
      :defvar swiper-include-line-number-in-search
      :bind ("C-c C-;" . swiper)
      :custom (swiper-include-line-number-in-search . t)))

  (leaf yasnippet
    :ensure t
    :bind
    ((yas-minor-mode-map
      ("C-c s i" . yas-insert-snippet)
      ("C-c s n" . yas-new-snippet)
      ("C-c s v" . yas-visit-snippet-file)
      ("C-c s l" . yas-describe-tables)
      ("C-c s g" . yas-reload-all)))
    :config
    (leaf yas-minor-mode
      :hook emacs-lisp-mode org-mode yatex-mode)))

(leaf *tex
  :config
  (leaf yatex
    :ensure t
    :mode "\\.tex\\'" "\\.ltx\\'" "\\.cls\\'" "\\.sty\\'" "\\.clo\\'" "\\.bbl\\'"
    :custom (
             ;; (auto-mode-alist . (append '(("\\.tex$" . yatex-mode)
             ;;                              ("\\.ltx$" . yatex-mode)
             ;;                              ("\\.cls$" . yatex-mode)
             ;;                              ("\\.sty$" . yatex-mode)
             ;;                              ("\\.clo$" . yatex-mode)
             ;;                              ("\\.bbl$" . yatex-mode)) auto-mode-alist))
             (YaTeX-inhibit-prefix-letter . t)
             (YaTeX-kanji-code . nil)
             ;; (YaTeX-latex-message-code . utf-8)
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
    :config
    (leaf reftex
      :ensure t
      :hook yatex-mode-hook
      :custom ((reftex-mode . 1)
               (reftex-label-alist . '((nil ?e nil "~\eqref{%s}" nil nil)))
               (reftex-default-bibliography . '("/Users/hondatoshiaki/tex/references.bib"))
               (reftex-bibliography-commands . '("bibliography" "nobibliography" "addbibresorce")))

      :bind ((reftex-mode-map
              (">" . YaTeX-comment-region)
              ("<" . YaTeX-uncomment-region))))

	(leaf ebib
      :ensure t
      :bind (("C-c C-z" . ebib))
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
    :config
    (leaf *mySaveFrame
      ;; :hook (emacs-startup-hook . my-load-frame-size) (kill-emacs-hook . my-save-frame-size)
      :preface
      (defconst my-save-frame-file
        "~/.emacs.d/.framesize"
        "フレームの位置、大きさを保存するファイルのパス")

      (defun my-save-frame-size()
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
      (defun my-load-frame-size()
        "'my-save-fram-file'に保存されたフレームの位置、大きさを復元します"
        (interactive)
        (let ((file my-save-frame-file))
          (when (file-exists-p file)
            (load-file file))))
      :config
      (run-with-idle-timer 60 t 'my-save-frame-size)
      ))

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
    :config (global-hl-line-mode)))

(leaf visual-regexp-steroids
  :ensure t
  :bind (("M-%" . vr/query-replace)
         ;; multiple-cursorsを使っているならこれで
         ("C-c m" . vr/mc-mark)
         ;; 普段の正規表現isearchにも使いたいならこれを
         ("C-M-r" . vr/isearch-backward)
         ("C-M-s" . vr/isearch-forward))
  :config (setq vr/engine 'python))

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
  :hook (eww-mode-hook . eww-mode-hook--disable-image)
  :defvar eww-disable-colorize
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
      (org-open-at-point)))
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
  :disabled
  :config
  (leaf org-mode
    :custom ((org-todo-keywords . '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)"))))
    ))

(leaf *miner-mode
  :config
  (leaf hs-minor-mode
	:hook emacs-lisp-mode
	:custom ((hs-minor-mode . t))
	:bind ((hs-minor-mode-map
			("C-'" . hs-toggle-hiding)))))
