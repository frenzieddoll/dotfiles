;;; init-helm.el --- setting for helm
;;; Commentary:
;;; Code:

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h") 'helm-recentf)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-for-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; helm-smex
(require 'helm-smex)
(global-set-key [remap execute-extended-command] #'helm-smex)
(global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)

;; recentfの設定
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(recentf-mode 1)

;; Disable helm in some functions
(add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

;; (1) helm-buffers-list のバッファ名の領域を広くとる
(setq helm-buffer-details-flag nil)

;; Emulate `kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-file-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(setq helm-ff-fuzzy-matching nil)
(defadvice helm-ff--transform-pattern-for-completion (around my-transform activate)
  "Transform the pattern to reflect my intention"
  (let* ((pattern (ad-get-arg 0))
         (input-pattern (file-name-nondirectory pattern))
         (dirname (file-name-directory pattern)))
    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
    (setq ad-return-value
          (concat dirname
                  (if (string-match "^\\^" input-pattern)
                      ;; '^' is a pattern for basename
                      ;; and not required because the directory name is prepended
                      (substring input-pattern 1)
                    (concat ".*" input-pattern))))))

(defun helm-buffers-list-pattern-transformer (pattern)
  (if (equal pattern "")
      pattern
    (let* ((first-char (substring pattern 0 1))
           (pattern (cond ((equal first-char "*")
                           (concat " " pattern))
                          ((equal first-char "=")
                           (concat "*" (substring pattern 1)))
                          (t
                           pattern))))
      ;; Escape some characters
      (setq pattern (replace-regexp-in-string "\\." "\\\\." pattern))
      (setq pattern (replace-regexp-in-string "\\*" "\\\\*" pattern))
      pattern)))


(unless helm-source-buffers-list
  (setq helm-source-buffers-list
        (helm-make-source "Buffers" 'helm-source-buffers)))
(add-to-list 'helm-source-buffers-list
             '(pattern-transformer helm-buffers-list-pattern-transformer))

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

;;; init-helm.el ends here
