
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

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)


;; init-system.el
(load "init-system")

;; init-keybinding.el
(load "init-keybinding")

;; init-cua.el
(load "init-cua")

;; exwmの設定
;; (require 'exwm)
;; (require 'exwm-cm)
;; (exwm-cm-enable)
(load "init-exwm")

;; (require 'exwm-config)
;; (exwm-config-default)
;; exwm-initの読み込み
;; (when (require 'exwm nil t) (require 'init-exwm))
;; (exwm_conf)

;; ddskk の設定
;; init-ddskk.el
(load "init-skk")
;; (setq skk-user-directory "~/.emacs.d/ddskk")
;; (setq skk-large-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
;; (global-set-key (kbd "C-x j") 'skk-mode)
;; ;; (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
;; (define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)

;; multi-termの設定
(load "init-term")

;; init-eshell.el
(load "init-eshell")

;; init-window.el
(load "init-window")

;; init-eww.el
(load "init-eww")

;; init-visual.el
;; (load "init-visual")
;; GUI環境でのみ見た目の設定を読み込む
(if window-system (progn
                    (load "init-visual")
                    ))


;; init-dired.el
(load "init-dired")

;; latexの設定を読み込む関数
;;(load "init-tex")
(add-hook 'org-mode-hook 'load-tex)
(defun load-tex ()
  "load tex setting"
  (interactive)
  (load "init-tex"))

;; (defun load-org-tex ()
;;   "load org-tex setting"
;;   (interactive)
;;   (load "init-org"))

;; jupyter notebookを使う
(require 'ein)

;; init-helm.el
(load "init-helm")

;; init-company.el
(load "init-company")

(require 'magit)

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
 '(package-selected-packages
   (quote
    (org-plus-contrib org-ref org-preview-html ace-link vlf dired-open w3m dired-launch dired-filter company zoom-window fish-mode helm ein rainbow-delimiters atom-one-dark-theme powerline multi-term exwm edit-server ddskk)))
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
