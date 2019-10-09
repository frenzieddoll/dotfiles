;; (add-hook 'after-init-hook #'global-flycheck)
(require 'cl-lib)
(cl-dolist (hook (list
                  'python-mode-hook
                  'emacs-lisp-mode-hook))
  (add-hook hook 'flycheck-mode))
