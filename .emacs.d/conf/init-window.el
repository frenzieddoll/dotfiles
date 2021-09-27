;; window関係
;; スマートなウィンドウ切り替え
;; exwmの設定に書き替え
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings);
(when (eq system-type 'darwin)
  ;; (global-set-key (kbd "C-c n") 'windmove-down)
  ;; (global-set-key (kbd "C-c f") 'windmove-right)
  ;; (global-set-key (kbd "C-c b") 'windmove-left)
  ;; (global-set-key (kbd "C-c p") 'windmove-up)
  (global-set-key (kbd "s-n") 'windmove-down)
  (global-set-key (kbd "s-f") 'windmove-right)
  (global-set-key (kbd "s-b") 'windmove-left)
  (global-set-key (kbd "s-p") 'windmove-up)
  (global-set-key (kbd "s-a") 'zoom-window-zoom)
  (global-set-key (kbd "s-q") 'kill-current-buffer)
  (global-set-key (kbd "s-h") 'delete-window)
  (global-set-key (kbd "s-o") 'ivy-switch-buffer))


;; ------------------------------------------


(if (not window-system)
    (progn
      (global-set-key (kbd "M-n") 'windmove-down)
      (global-set-key (kbd "M-f") 'windmove-right)
      (global-set-key (kbd "M-b") 'windmove-left)
      (global-set-key (kbd "M-p") 'windmove-up)
      (global-set-key (kbd "M-a") 'zoom-window-zoom)
      (global-set-key (kbd "M-q") 'kill-current-buffer)
      (global-set-key (kbd "M-h") 'delete-window)
      (global-set-key (kbd "C-M-i") 'output_toggle)
      (global-set-key (kbd "C-M-m") 'mute_toggle)
      (global-set-key (kbd "C-M-n") 'lower_volume )
      (global-set-key (kbd "C-M-p") 'upper_volume)
      (global-set-key (kbd "M-d") 'counsel-linux-app)
      (global-set-key (kbd "M-o") 'ivy-switch-buffer)
      (global-hl-line-mode)
      ))


;; window間の移動をループ
(setq windmove-wrap-around t)

;; ウィンドウのサイズ変更
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?n)
               (enlarge-window dy))
              ((= c ?p)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))


;; スクロールの設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; スクロールを一行ずつにする
;; (setq scroll-step 1)
;; スクロールした際のカーソルの移動行数
(setq scroll-conservatively 1)
;; スクロール開始のマージン
(setq scroll-margin 5)
;; 1画面スクロール時に重複させる行数
(setq next-screen-context-lines 10)
;; 1画面スクロール時にカーソルの画面上の位置をなるべく変えない
(setq scroll-preserve-screen-position t)
;; windowを一時的に最大化
(require 'zoom-window)
;; (global-set-key (kbd "C-c 1") 'zoom-window-zoom)
(setq zoom-window-mode-line-color "DarkBlue")

;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
