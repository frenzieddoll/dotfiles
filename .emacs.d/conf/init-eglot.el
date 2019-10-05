;; (require 'eglot)
;; (define-key haskell-mode-map (kbd "C-c C-j") 'eglot-help-at-point)
;; (define-key haskell-mode-map (kbd "C-c C-.") 'eglot-rename)

;; (defun haskell-eglot-setting ()
;;   )

;; (require 'haskell-mode)
;; (add-hook 'haskell-mode-hook
;;           '(lambda ()
;;              ('eglot-snsure)
;;              ('interactive-haskell-mode)
;;              (define-key haskell-mode-map (kbd "C-c C-j") 'eglot-help-at-point)
;;              (define-key haskell-mode-map (kbd "C-c C-.") 'eglot-rename)))
;; ;; (add-hook 'haskell-mode-hook 'eglot-ensure)
;; ;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; ;; (with-eval-after-load 'haskell-mode
;; ;;   (setq flymake-allowed-file-name-masks (delete '("\\.l?hs\\'" haskell-flymake-init) flymake-allowed-file-name-masks))
;; ;;   )
;; ;; (add-to-list 'company-backends 'company-ghci)

;; (require 'python-mode)
;; (add-hook 'python-mode-hook (lambda ()

;; (add-hook 'python-mode-hook 'eglot-ensure)
;; (add-to-list 'eglot-server-programs
;; 	     `(python-mode . ("pyls" "-v" "--tcp" "--host"
;; 			      "localhost" "--port" :autoport)))
