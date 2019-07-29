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

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
 (package-initialize)


;; init-system.el
(load "init-system" t)

;; init-keybinding.el
(load "init-keybinding" t)

;; init-cua.el
(load "init-cua" t)

;; exwmの設定
;; (load "init-exwm" t)
(when (eq system-type 'gnu/linux)
  (if window-system (progn
                      (load "init-exwm" t)
                      )))

;; ddskk の設定
;; init-ddskk.el
(load "init-skk" t)

;; multi-termの設定
(load "init-term" t)

;; init-eshell.el
(load "init-eshell" t)

;; 補完パッケージ
;; ido setting
;; (load "init-ido" t)
;; init-ivy.el
(load "init-ivy" t)
;; init-helm.el
;; (load "init-helm")

;; init-shackle
(load "init-shackle" t)


;; init-window.el
(load "init-window" t)


;; init-visual.el
;; (load "init-visual")
;; GUI環境でのみ見た目の設定を読み込む
(if window-system (progn
                    (load "init-visual" t)
                    ))

;; init-googletranslate.el
(load "init-googletranslate" t)


;; init-dired.el
(load "init-dired" t)

;; latexの設定を読み込む関数
;;(load "init-tex")
;; (defun load-tex ()
;;   "load tex setting"
;;   (interactive)
;;   (load "init-tex" t))

(defun load-tex ()
  "load tex setting"
  (interactive)
  (cond
   ((eq system-type 'gnu/linux)
    (load "init-tex" t))
   ((eq system-type 'darwin)
    (load "init-tex_for_mac"))))


;; init-company.el
(load "init-company" t)

;; flycheck
;; (add-hook 'after-init-hook #'global-flycheck-mode)

(defun load-lang-mode ()
  (interactive)
  (load "init-flycheck" t)
  (load "init-rust" t)
  (load "init-haskell" t)
  (load "init-pdftools" t)
  (load "init-eww" t)
  (require 'ein)
  (require 'magit))
;; (defun load-rust ()
;;   "load rust-mode setting"
;;   (interactive)
;;   (load "init-rust" t))


;; linux環境でのみ読み込み
;; (when (eq system-type 'gnu/linux)
;;  (require 'magit)
;;  (require 'ein))




(add-hook 'picture-mode-hook 'picture-mode-init)
(autoload 'picture-mode-init "init-picture")

;; (require 'magit)
;; ;; jupyter notebookを使う
;; (require 'ein)
;; ;; init-pdftools.el
;; (when (eq system-type 'gnu/linux)
;;   (load "init-pdftools" t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-external-programs-associations
   (quote
    (("wmv" . "mplayer")
     ("exe" . "wine")
     ("rar" . "mcomix")
     ("pdf" . "mcomix")
     ("zip" . "mcomix"))))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (counsel swiper selected google-this smart-mode-line-atom-one-dark-theme company-ghci eglot lsp-ui lsp-haskell image+ dimmer exec-path-from-shell doom-modeline doom-themes flycheck-haskell haskell-mode ox-pandoc company-jedi shackle popwin quickrun company-racer flycheck-rust racer imenus browse-kill-ring smex smooth-scroll dired-subtree let-alist google-translate mpv org-plus-contrib org-preview-html ace-link dired-open dired-launch dired-filter company zoom-window ein rainbow-delimiters powerline multi-term exwm edit-server ddskk)))
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
