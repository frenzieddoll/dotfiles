;;; init-python.el -- setting for python-mode
;;; Commentary:
;;; Code:

(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)

;;; init-python.el ends here
