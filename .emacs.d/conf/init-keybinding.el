;; key-bind
;; C-m : 改行プラスインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;;C-h : backspace
;; (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-set-key (kbd "C-h") 'delete-backward-char);;exwmを使う時はこっち
(defun minibuffer-delete-backward-char ()
  (local-set-key (kbd "C-h") 'delete-backward-char))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
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

;; audio操作の関数
(defun output_toggle ()
  (interactive)
  (start-process-shell-command
   "output-toggle"
   nil
   (format "~/.emacs.d/conf/output_toggle.sh")))

(defun upper_volume ()
  (interactive)
  (start-process-shell-command
   "upper_volume"
   nil
   (format "~/.emacs.d/conf/upper_volume.sh")))

(defun lower_volume ()
  (interactive)
  (start-process-shell-command
   "lower_volume"
   nil
   (format "~/.emacs.d/conf/lower_volume.sh")))

(defun mute_toggle ()
  (interactive)
  (start-process-shell-command
   "mute_toggle"
   nil
   (format "~/.emacs.d/conf/mute_toggle.sh")))

(global-set-key (kbd "<f9>") 'lower_volume)
(global-set-key (kbd "<f10>") 'upper_volume)
(global-set-key (kbd "<f11>") 'mute_toggle)
(global-set-key (kbd "<f12>") 'output_toggle)