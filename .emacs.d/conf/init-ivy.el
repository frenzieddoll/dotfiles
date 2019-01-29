;;; init-ivy.el --- ivy settings
;;
;;; Commentary:

;;


;;; Code:
(require 'ivy)
(ivy-mode 1) ;; デフォルトの入力補完がivyになる
;; M-x, C-x ?C-fなどのEmacsの基本的な組み込みコマンドをivy版にリマップする

;; 定義した関数
(defun bjm/ivy-dired-recent-dirs ()
  "Present a list of recently used directories and open the selected one in dired"
  (interactive)
  (let ((recent-dirs
         (delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))))

    (let ((dir (ivy-read "Directory: "
                         recent-dirs
                         :re-builder #'ivy--regex
                         :sort nil
                         :initial-input nil)))
      (dired dir))))


;; 設定
;; ivyの設定
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 20) ;; minibufferのサイズを拡大！（重要）
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c h") 'ivy-recentf)

;; counselの設定
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file) ;; find-fileもcounsel任せ！
(defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
(global-set-key (kbd "C-x d") 'dired)
(global-set-key (kbd "C-x C-d") 'bjm/ivy-dired-recent-dirs)

;; swiperの設定
(global-set-key (kbd "C-;") 'swiper)
;; (define-key ivy-mode-map (kbd "C-j") 'skk-hiragana-set)
;; (define-key ivy-mode-map (kbd "C-l") 'skk-latin-mode)
(defvar swiper-include-line-number-in-search t) ;; line-numberでも検索可能

;; ;;; 下記は任意で有効化
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;; ;; これらは counsel-mode で自動で設定されるため、明示的に設定しなくてよい
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-load-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

;;; init-ivy.el ends here
