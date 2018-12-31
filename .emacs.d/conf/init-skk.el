(setq skk-user-directory "~/.emacs.d/ddskk")
(setq skk-tut-file "~/.emacs.d/etc/SKK.tut")
(setq skk-initial-search-jisyo "~/.ddskk/user.dict")
(setq skk-large-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")

(defun skk-hiragana-set nil
  (interactive)
  (cond (skk-katakana
         (skk-toggle-kana nil))
        (t
         (skk-kakutei))))

(defun skk-katakana-set nil
  (interactive)
  (cond (skk-katakana
         (lambda))
        (skk-j-mode
         (skk-toggle-kana nil))
        (skk-latin-mode
         (dolist (skk-kakutei (skk-toggle-kana nil))))))

(global-unset-key (kbd "C-o"))
(global-set-key (kbd "C-o j") 'skk-hiragana-set)
(global-set-key (kbd "C-o q") 'skk-katakana-set)
(global-set-key (kbd "C-o l") 'skk-latin-mode)

(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-j") 'skk-hiragana-set)
(global-set-key (kbd "C-q") 'skk-katakana-set)
(global-set-key (kbd "C-l") 'skk-latin-mode)
(global-set-key (kbd "C-x j") 'skk-mode)

(define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)
(define-key minibuffer-local-map (kbd "C-l") 'skk-latin-mode)


;; ddskkをisearchでも使う
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup)
(setq skk-isearch-start-mode 'latin)
