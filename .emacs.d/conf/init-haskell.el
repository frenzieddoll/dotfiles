;;; init-haskell.el -- setting haskell-mode
;;; Commentary:
;;; Code:

(require 'lsp-mode)
(setq lsp-prefer-flymake nil)
(add-hook 'haskell-mode-hook #'lsp)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'haskell-mode-hook 'flycheck-mode)

(require 'lsp-haskell)

;; (require 'eglot)
;; (require 'haskell-mode)
;; (add-hook 'haskell-mode-hook 'eglot-ensure)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
;; (add-hook 'haskell-mode-hook 'haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; (setq lsp-document-sync-method 'full)
;; (custom-set-variables
;;  '(haskell-indent-after-keywords (quote (("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let")))
;;  '(haskell-indent-offset 4)
;;  '(haskell-indent-spaces 4))


;; flymakeのファイルの自動作成を無効化
;; (with-eval-after-load 'haskell-mode
;;   (setq flymake-proc-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
;;   )

;; (setq haskell-process-type 'stack-ghci)
;; (setq haskell-process-path-ghci "stack")
;; (defvar haskell-process-args-ghcie "ghci")

;; (add-to-list 'company-backends 'company-ghci)
;; (define-key haskell-mode-map (kbd "C-c C-j") 'eglot-help-at-point)
;; (define-key haskell-mode-map (kbd "C-c C-c") 'eglot-rename)


;; lsp-mode setting
;; (autoload 'haskell-mode "haskell-mode" nil t)
;; (autoload 'haskell-cabal "haskell-cabal" nil t)


;; (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.cable$" . haskell-cabal-mode))


;; (require 'lsp)
;; (require 'lsp-haskell)
;; (add-hook 'haskell-mode-hook #'lsp)

;; ;; hindent
;; (add-hook 'haskell-mode-hook #'hindent-mode)
;; (defvar hindent-style "johan-tibell")


;;; init-haskell.el ends here
