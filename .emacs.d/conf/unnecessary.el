(leaf multi-term
  :disabled t
  :ensure t
  :custom ((multi-term-program . shell-file-name))
  :config
  ;; キーを取り戻す
  (add-to-list 'term-unbind-key-list '"M-x")
  (add-to-list 'term-unbind-key-list '"C-j")
  (add-to-list 'term-unbind-key-list '"C-l")
  (add-to-list 'term-unbind-key-list '"C-o")
  (add-hook 'term-mode-hook
            '(lambda ()
               ;; C-hをterm内文字削除にする
               (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
               ;; C-yをterm内ペーストにする
               (define-key term-raw-map (kbd "C-y") 'term-paste)
               (define-key term-raw-map (kbd "C-j") 'skk-hiragana-set)
               (define-key term-raw-map (kbd "C-q") 'skk-katakana-set)
               (define-key term-raw-map (kbd "C-l") 'skk-latin-mode-on)
               ))
  (global-set-key (kbd "C-c q")
                  '(lambda ()
					 (interactive)
					 (if (get-buffer "*terminal<1>*")
						 (switch-to-buffer "*terminal<1>*")
                       (multi-term))))
  )

  (leaf eglot
    :disabled t
	:ensure t
    :hook ((c-mode-hook c++-mode-hook haskell-mode-hook) . eglot-ensure)
	:custom `((lsp-document-sync-method . 'full)
			  )
	:config
	(fset #'eglot--snippet-expansion-fn #'ignore)

    (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))

    (leaf projectile
      :ensure t
      :custom `((projectile-indexing-method . 'alien)
                (projectile-enable-caching . t)
                (projectile-global-mode . t))
      :config
      (defun my-projectile-project-find-function (dir)
        (let ((root (projectile-project-root dir)))
          (and root (cons 'transient root))))
      (projectile-mode t)
      (with-eval-after-load 'project
        (add-to-list 'project-find-functions 'my-projectile-project-find-function))
      )

	(leaf haskell-mode
	  :disabled t
	  :after eglot
	  :ensure t
	  :defvar haskell-process-args-ghcie
	  :custom `(;; (flymake-proc-allowed-file-name-masks . ,(delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
	  			(haskell-process-type          . 'stack-ghci)
	  			(haskell-process-path-ghci     . "stack")
	  			(haskell-process-args-ghcie    . "ghci")
                (haskell-indent-after-keywords . '(("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let"))
			    (haskell-indent-offset         . 4)
			    (haskell-indendt-spaces        . 4)
	  			)

	  :bind ((haskell-mode-map
			  :package eglot
			  ("C-c C-j" . eglot-help-at-point)
			  ("C-c C-c" . eglot-rename)
			  )
			 )
	  :hook ((haskell-mode-hook . eglot-ensure)
	  		 (haskell-mode-hook . interactive-haskell-mode)
	  		 (haskell-mode-hook . haskell-decl-scan-mode)
	  		 (haskell-mode-hook . haskell-doc-mode)
	  		 (haskell-mode-hook . haskell-indentation-mode)
	  		 )
	  :config

	  (leaf *flaymakeFileAutoRemove
		:after haskell-mode
		:custom `((flymake-proc-allowed-file-name-masks . ,(delete '("\\.l?hs\\'" haskell-flymake-init) flymake-proc-allowed-file-name-masks))
				  )
		)

	  (add-to-list 'company-backends 'company-ghci)

	  )

	)
