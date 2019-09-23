(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key company-active-map (kbd "C-h") nil) ;; バックスペースを取り


;; (set-face-attribute 'company-tooltip nil                  ; ポップアップ全体
;;   :foreground "black" :background "ivory1")
;; (set-face-attribute 'company-tooltip-common nil           ; 入力中の文字列と一致する部分
;;   :foreground "black" :background "ivory1")
;; (set-face-attribute 'company-tooltip-selection nil        ; 選択項目の全体
;;   :foreground "ivory1" :background "DodgerBlue4")
;; (set-face-attribute 'company-tooltip-common-selection nil ; 選択項目のうち入力中の文字列と一致する部分
;;   :foreground "ivory1" :background "DodgerBlue4")
;; (set-face-attribute 'company-preview-common nil           ; 候補が1つしかなくて自動で入力される場合
;;   :background "black" :foreground "yellow" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil             ; ポップアップのスクロールバー
;;   :background "Midnight Blue")
;; (set-face-attribute 'company-scrollbar-bg nil             ; ポップアップのスクロールバー
;;                     :background "ivory1")
