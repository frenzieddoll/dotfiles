;; keymap change
;; C-m : newline-and-indent
(global-set-key (kbd "C-m") 'newline-and-indent)

;;C-h : backspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; C-x ? : help
(define-key global-map (kbd "C-x ?") 'help-command)

;;orikaeshitogurukomaxndo
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; C-t : change windows (moto transpose-chars)
(define-key global-map (kbd "C-t") 'other-window)

;; moji code set
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; columns number display
(column-number-mode t)

;; fully path of a file is displaied at title bar
(setq frame-title-format "%f")

;; columns number always displaied
(global-linum-mode t)

;;スペース、タブなどを可視化する
(global-whitespace-mode 1)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; beep音を消す
(setq ring-bell-function 'ignore)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ格好内も光らせる
(setq show-paren-style 'mixed)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; menu bar delete
(menu-bar-mode -1)

;; tool bar delete
(tool-bar-mode -1)

;; scratch initila message delete
(setq initial-scratch-message "")

;; scroll bar delete
(scroll-bar-mode -1)

;; mitame
;;color theme
;; (load-theme 'monokai t)

;; alpha
;; (if window-system
;;     (grogn
;;      (set-frame-parameter nil 'alpha 95)))

