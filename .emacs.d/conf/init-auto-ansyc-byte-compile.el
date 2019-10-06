(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/confbk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(defun confDirRecompile ()
  (interactive)
  (byte-recompile-directory (expand-file-name "~/.emacs.d/conf") 0))
