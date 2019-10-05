(require 'eglot)
(define-key haskell-mode-map (kbd "C-c C-j") 'eglot-help-at-point)
(define-key haskell-mode-map (kbd "C-c C-.") 'eglot-rename)

(defun haskell-lsp ()
  (require 'haskell-mode)
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (with-eval-after-load 'haskell-mode
    (setq flymake-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks))
    )

  (add-to-list 'company-backends 'company-ghci))
