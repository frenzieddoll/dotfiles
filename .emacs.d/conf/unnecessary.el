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
