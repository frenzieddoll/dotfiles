(require 'eglot)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(with-eval-after-load 'haskell-mode
  (setq flymake-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks))
  )

;; (define-key haskell-mode-map (kbd "

(defun haskell-repl-and-flycheck ()
  (interactive)
  (delete-other-windows)
  (flycheck-list-errors)
  (haskell-process-load-file)
  (haskell-interactive-switch)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer flycheck-error-list-buffer)
  (other-window 1)
  )


;; (require 'lsp-mode)
;; (require 'lsp-ui)
;; (require 'lsp-haskell)

;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;; (add-hook 'haskell-mode-hook #'lsp)
;; (add-hook 'haskell-mode-hook 'flycheck-mode)
