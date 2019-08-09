;;; init-python.el -- setting for python-mode
;;; Commentary:
;;; Code:

;; (require 'jedi-core)
;; (setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)

(require 'eglot)
(add-hook 'python-mode-hook 'eglot-ensure)


;;; init-python.el ends here
