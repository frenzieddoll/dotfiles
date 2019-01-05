;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x b") 'helm-for-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-c h") 'helm-find)
(global-set-key (kbd "C-c h") 'helm-recentf)

;; recentfの設定
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(recentf-mode 1)


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
