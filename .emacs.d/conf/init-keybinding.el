;;; init-keybinding.el --- setting for keybinding
;;; Commentary:
;;; Code:


;; C-m : 改行プラスインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;;C-h : backspace
;; (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; (cond ((equal system-type 'gnu/linux)
;;        (global-set-key (kbd "C-h") 'delete-backward-char))
;;       ((equal system-type 'darwin)
;;        (global-set-key (kbd "C-h") (kbd "<DEL>"))))
(global-set-key (kbd "C-h") 'delete-backward-char);;exwmを使う時はこっち
(defun minibuffer-delete-backward-char ()
  (local-set-key (kbd "C-h") 'delete-backward-char))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
(define-key global-map (kbd "M-h") 'backward-kill-word)
;; C-x ? : help
(define-key global-map (kbd "C-c ?") 'help-command)
;;折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
;; ウィンドウサイズの変更のキーバインド
(global-set-key (kbd "C-c r") 'window-resizer)
;; 行番号を表示
(global-set-key (kbd "C-c t") 'display-line-numbers-mode)
;;スペース、改行、タブを表示する
(global-set-key (kbd "C-c w") 'whitespace-mode)
;; 検索結果のリストアップ
(global-set-key (kbd "C-c o") 'occur)
;; S式の評価
(global-set-key (kbd "C-c C-j") 'eval-print-last-sexp)
;; ;; quick run
;; (global-set-key (kbd "M-s") 'quickrun)
;; async shell command
(global-set-key (kbd "s-s") 'async-shell-command)

(global-set-key (kbd "<kp-divide>") 'insert-backslash)
(defun insert-backslash ()
  "insert backslash"
  (interactive)
  (insert "\\"))


;; audio操作の関数
(defun output_toggle ()
  "Exchange output source."
  (interactive)
  (start-process-shell-command
   "output-toggle"
   nil
   (format "~/.emacs.d/script/output_toggle.sh")))

(defun upper_volume ()
  "Volume up."
  (interactive)
  (start-process-shell-command
   "upper_volume"
   nil
   (format "~/.emacs.d/script/upper_volume.sh")))

(defun lower_volume ()
  "Volume down."
  (interactive)
  (start-process-shell-command
   "lower_volume"
   nil
   (format "~/.emacs.d/script/lower_volume.sh")))

(defun mute_toggle ()
  "Volume mute."
  (interactive)
  (start-process-shell-command
   "mute_toggle"
   nil
   (format "~/.emacs.d/script/mute_toggle.sh")))

;; (global-set-key (kbd "<f9>") 'lower_volume)
;; (global-set-key (kbd "<f10>") 'upper_volume)
;; (global-set-key (kbd "<f11>") 'mute_toggle)
;; (global-set-key (kbd "<f12>") 'output_toggle)
;; (exwm-input-set-key (kbd "<print>") 'lower_volume)
;; (exwm-input-set-key (kbd "<Scroll_Lock>") 'upper_volume)
;; (exwm-input-set-key (kbd "<pause>") 'mute_toggle)
;; (exwm-input-set-key (kbd "<f7>") 'output_toggle)
;; (exwm-input-set-key (kbd "C-<mouse-9>") 'upper_volume)
;; (exwm-input-set-key (kbd "C-<mouse-8>") 'lower_volume)

;; (global-unset-key (kbd "s-c"))

(defun side-monitor-rotate ()
  "Side monitor ratate."
  (interactive)
  "side-monitor-rotate"
  (shell-command-to-string "xrandr --output HDMI-0 --rotate right"))

(defun side-monitor-normal ()
  "Side monitor ratate cancel."
  (interactive)
  (shell-command-to-string "xrandr --output HDMI-0 --rotate normal"))

(defun DP-0_primary ()
  "Side-monitor-rotate."
  (interactive)
  (shell-command-to-string "xrandr --output DP-0 --primary"))

;; (global-unset-key (kbd "C-z"))

;;; init-keybinding.el ends here
