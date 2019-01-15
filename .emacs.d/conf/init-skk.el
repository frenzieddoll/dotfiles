(setq skk-user-directory "~/.emacs.d/ddskk")

(global-set-key (kbd "C-x j") 'skk-mode)
(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-j") 'skk-hiragana-set)
(global-set-key (kbd "C-q") 'skk-katakana-set)
(global-set-key (kbd "C-l") 'skk-latin-mode)
(define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)
(define-key minibuffer-local-map (kbd "C-l") 'skk-latin-mode)



;; (setq skk-rom-kana-rule-list
;;       (append skk-rom-kana-rule-list
;;               '(
;;                 ;; ("xn" nil ("ン" . "ん"))
;;                 ("xn" nil "ん")
;;                 ("xx" nil "っ")
;;                 ("z," nil ",")
;;                 ("z." nil ".")
;;                 ("z[" nil "[")
;;                 ("z]" nil "]")
;;                 ("z-" nil "-")
;;                 ("!" nil "!")
;;                 ("." nil "。")
;;                 ("," nil "、")
;;                 (":" nil ":")
;;                 (";" nil ";")
;;                 ("?" nil "?")
;;                 ("la" nil "ぁ" )
;;                 ("le" nil "ぇ" )
;;                 ("li" nil "ぃ" )
;;                 ("lo" nil "ぉ" )
;;                 ("lu" nil "ぅ" )
;;             )))

;; (setq skk-tut-file "~/.emacs.d/etc/SKK.tut")
;; (setq skk-initial-search-jisyo "~/.ddskk/user.dict")
;; (setq skk-large-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
;; (setq skk-extra-jisyo-file-list
;;       (list
;;        '("~/.emacs.d/skk-get-jisyo/SKK-JISYO.JIS3_4")
;;        '("~/.emacs.d/skk-get-jisyo/SKK-JISYO.lisp")))


;; (defun skk-hiragana-set nil
;;   (interactive)
;;   (cond (skk-katakana
;;          (skk-toggle-kana nil))
;;         (t
;;          (skk-kakutei))))

;; (defun skk-katakana-set nil
;;   (interactive)
;;   (cond (skk-katakana
;;          (lambda))
;;         (skk-j-mode
;;          (skk-toggle-kana nil))
;;         (skk-latin-mode
;;          (dolist (skk-kakutei (skk-toggle-kana nil))))))

;; ;; (global-unset-key (kbd "C-o"))
;; ;; (global-set-key (kbd "C-o j") 'skk-hiragana-set)
;; ;; (global-set-key (kbd "C-o q") 'skk-katakana-set)
;; ;; (global-set-key (kbd "C-o l") 'skk-latin-mode)

;; (global-unset-key (kbd "C-j"))
;; (global-set-key (kbd "C-j") 'skk-hiragana-set)
;; (global-set-key (kbd "C-q") 'skk-katakana-set)
;; (global-set-key (kbd "C-l") 'skk-latin-mode)
;; (global-set-key (kbd "C-x j") 'skk-mode)

;; (define-key minibuffer-local-map (kbd "C-j") 'skk-kakutei)
;; (define-key minibuffer-local-map (kbd "C-l") 'skk-latin-mode)


;; ;; 動作
;; ;; Enterで改行しない
;; (setq skk-egg-like-newline t)
;; ; ▼モードで一つ前の候補を表示
;; (setq skk-delete-implies-kakutei t)
;; ;; 英語補完
;; ;; (setq skk-use-look t)
;; ;; 閉じカッコを自動的に
;; ;; (setq skk-auto-insert-paren nil)
;; ;; 送り仮名が厳密に正しい候補を優先して表示
;; (setq skk-henkan-strict-okuri-precedence t)

;; ;; ddskkをisearchでも使う
;; (add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
;; (add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup)
;; (setq skk-isearch-start-mode 'latin)

;; ;;カタカナを変換候補に
;; (setq skk-search-katakana t)
