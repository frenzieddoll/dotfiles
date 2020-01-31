;;; init.el --- setting for emacs
;;; Commentary:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:
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

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)


;; init-system.el
(load "init-system" t)

;; init-keybinding.el
(load "init-keybinding" t)
(load "init-viewMode" t)

;; init-cua.el
(load "init-cua" t)

;; ddskk の設定
;; init-ddskk.el
(load "init-skk" t)
(defvar skk-byte-compile-init-file t)

;; multi-termの設定
(load "init-term" t)

;; init-eshell.el
(load "init-eshell" t)

;; 補完パッケージ
(load "init-ivy" t)

;; init-shackle
(load "init-shackle" t)

;; init-window.el
(load "init-window" t)

;; init-dired.el
(load "init-dired" t)

;; init-regexp.el
(load "init-regexp" t)

;; init-googletranslate.el
(load "init-googletranslate" t)

;; init-company.el
(load "init-company" t)

(add-hook 'newsticker-treeview-mode-hook
          '(lambda ()
             (load "init-rss" t)))

(load "init-auto-ansyc-byte-compile" t)

(load "init-org" t)

(defun load-tex ()
  "Load tex setting."
  (interactive)
  ;; (cond
  ;;  ((eq system-type 'gnu/linux)
  ;;   (load "init-tex" t))
  ;;  ((eq system-type 'darwin)
  ;;   (load "init-tex_for_mac")))
  (load "init-tex" t)
  (load "init-ebib" t)
  (load "init-yatex" t))

(defun load-add-setting ()
  "Add setting."
  (interactive)
  (load "init-flycheck" t)
  (load "init-eww" t)
  (add-hook 'picture-mode-hook 'picture-mode-init)
  (autoload 'picture-mode-init "init-picture")
  (load "init-yasnippet")
  ;; linux環境でのみ読み込み
  (when (eq system-type 'gnu/linux)
      (load "init-pdftools" t)
      (load "init-rust" t)
      (load "init-lspmode" t)
      ;; (load "init-haskell" t)
      ;; (load "init-mail" t)
      ;; (load "init-mew" t)
      (load "init-quickrun" t)
      (require 'ein)
      ))

;; init-visual.el
;; GUI環境でのみ見た目の設定を読み込む
(if window-system
    (progn
      (load "init-visual" t)
      ))
;; CUI環境
(if (not window-system)
    (progn
      (load "init-eww" t)))

;; linux用の設定
(when (eq system-type 'gnu/linux)
  (if window-system (progn
                      (load "init-exwm" t)
                      )))

;; mac用の設定
(when (eq system-type 'darwin)
  (load "init-mySaveFrame" t))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ca849ae0c889eb918785cdc75452b1e11a00848a5128a95a23872e0119ccc8f4" "a2286409934b11f2f3b7d89b1eaebb965fd63bc1e0be1c159c02e396afb893c8" "669e02142a56f63861288cc585bee81643ded48a19e36bfdf02b66d745bcc626" "2a3ffb7775b2fe3643b179f2046493891b0d1153e57ec74bbe69580b951699ca" "f30aded97e67a487d30f38a1ac48eddb49fdb06ac01ebeaff39439997cbdd869" "f2b83b9388b1a57f6286153130ee704243870d40ae9ec931d0a1798a5a916e76" "cdb4ffdecc682978da78700a461cdc77456c3a6df1c1803ae2dd55c59fa703e3" default)))
 '(haskell-indent-after-keywords
   (quote
    (("where" 4 0)
     ("of" 4)
     ("do" 4)
     ("mdo" 4)
     ("rec" 4)
     ("in" 4 0)
     ("{" 4)
     "if" "then" "else" "let")))
 '(haskell-indent-offset 4)
 '(haskell-indent-spaces 4)
 '(org-agenda-files nil t)
 '(package-selected-packages
   (quote
    (restart-emacs neotree counsel-osx-app ivy-hydra visual-regexp-steroids pcre2el dired-recent lsp-ui lsp-haskell org-ref ivy-dired-history pkgbuild-mode image-dired+ peep-dired undo-tree lsp-mode ivy-yasnippet auto-async-byte-compile yasnippet lua-mode yaml-mode gitignore-mode recentf-ext smart-mode-line doom-themes iflipb counsel-notmuch notmuch abyss-theme counsel swiper selected google-this smart-mode-line-atom-one-dark-theme company-ghci eglot image+ dimmer exec-path-from-shell flycheck-haskell haskell-mode ox-pandoc company-jedi shackle popwin quickrun company-racer flycheck-rust racer imenus browse-kill-ring smex smooth-scroll dired-subtree let-alist google-translate org-plus-contrib org-preview-html ace-link dired-open dired-launch dired-filter company zoom-window ein rainbow-delimiters powerline multi-term exwm edit-server ddskk)))
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
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
