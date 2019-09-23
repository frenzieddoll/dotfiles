;;; init-org.el -- setting for orgmode
;;; Commentary:
;;; Code:

;; todo state
(defvar org-todo-keywords
  '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; timestanp
(defvar org-log-done 'time)

(when (eq system-type 'gnu/linux)
  (setq org-agenda-files (list (expand-file-name "~/Documents/google-drive/emacs_org"))))
(when (eq system-type 'darwin)
  (setq org-agenda-files (list (expand-file-name "~/Documents/honda/emacs_org"))))

(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)
(setq calendar-holidays nil)
(global-set-key (kbd "C-c a") 'org-agenda)

;;; init-org.el ends here
