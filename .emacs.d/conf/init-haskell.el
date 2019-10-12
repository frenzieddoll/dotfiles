;;; init-haskell.el -- setting haskell-mode
;;; Commentary:
;;; Code:

(require 'eglot)
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; (custom-set-variables
;;  '(haskell-indent-after-keywords (quote (("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let")))
;;  '(haskell-indent-offset 4)
;;  '(haskell-indent-spaces 4))


;; flymakeのファイルの自動作成を無効化
(with-eval-after-load 'haskell-mode
  (setq flymake-proc-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
  )

(setq haskell-process-type 'stack-ghci)
(setq haskell-process-path-ghci "stack")
(defvar haskell-process-args-ghcie "ghci")

;; (add-to-list 'company-backends 'company-ghci)
(define-key haskell-mode-map (kbd "C-c C-j") 'eglot-help-at-point)
(define-key haskell-mode-map (kbd "C-c C-c") 'eglot-rename)


;; (require 'lsp)
;; (require 'lsp-ui)
;; (require 'lsp-haskell)
;; (require 'yasnippet)

;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;; (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
;; (add-hook 'haskell-mode-hook #'lsp)

;; (defun haskell-repl-and-flycheck ()
;;   (interactive)
;;   (delete-other-windows)
;;   (flycheck-list-errors)
;;   (haskell-process-load-file)
;;   (haskell-interactive-switch)
;;   (split-window-below)
;;   (other-window 1)
;;   (switch-to-buffer flycheck-error-list-buffer)
;;   (other-window 1)
;;   )


;; (require 'lsp-mode)
;; (require 'lsp-ui)
;; (require 'lsp-haskell)

;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;; (add-hook 'haskell-mode-hook #'lsp)
;; (add-hook 'haskell-mode-hook 'flycheck-mode)
;; (setq lsp-document-sync-method 'full)

;;; init-haskell.el ends here
