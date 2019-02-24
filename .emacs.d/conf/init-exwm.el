;;; EXWM

;;; When stating the client from .xinitrc, `save-buffer-kill-terminal' will
;;; force-kill Emacs before it can run through `kill-emacs-hook'.
;; (global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

;;; REVIEW: Athena+Xaw3d confuses xcape when binding Caps-lock to both L_Ctrl
;;; escape, in which case it will procude <C-escape> in Emacs. In practice, it
;;; means that `C-` keys will works but `<escape>` will need a fast double tap
;;; on Caps Lock.
;;;
;;; See https://github.com/ch11ng/exwm/issues/285
;;; and https://gitlab.com/interception/linux/plugins/caps2esc/issues/2.

;;; REVIEW: Pressing "s-a" ('emms-smart-browse) loses the cursor.
;;; Sometimes waiting helps.  Calling emms-smart-browse manually does not trigger the issue.
;;; https://github.com/ch11ng/exwm/issues/366

;;; REVIEW: helm-mini with follow-mode hangs when using EXWM.
;;; https://github.com/emacs-helm/helm/issues/1889

;;; Rename buffer to window title.
;; (defun ambrevar/exwm-rename-buffer-to-title () (exwm-workspace-rename-buffer exwm-title))
;; (add-hook 'exwm-update-title-hook 'ambrevar/exwm-rename-buffer-to-title)

;; (add-hook 'exwm-floating-setup-hook 'exwm-layout-hide-mode-line)
;; (add-hook 'exwm-floating-exit-hook 'exwm-layout-show-mode-line)

;;; Allow non-floating resizing with mouse.
;; (setq window-divider-default-bottom-width 2
;;       window-divider-default-right-width 2)
;; (window-divider-mode)

(require 'exwm)


;;; System tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)
;; (setq exwm-systemtray-height 16)

;; フローティングモードで右下をドラックするとサイズ変更
(setq window-divider-default-right-width 1)
(window-divider-mode)

;; workspaceでバッファを共有
(setq exwm-workspace-show-all-buffers t)
(setq exwm-layout-show-all-buffers t)

;; 時間を表示
(setq display-time-default-load-average nil)
(setq display-time-day-and-date t)
(display-time-mode 1)


;; コンポジットマネージャー
;; (require 'exwm-cm)

;; ido でworkspaceの切り替え
;; (require 'exwm-config)
;; (exwm-config-ido)
;; (exwm-enable-ido-workaround)

;; マルチモニターの設定
(require 'exwm-randr)
;; (setq exwm-randr-workspace-output-plist '(0 "DP-0" 1 "HDMI-0" 2 "DP-0" 3 "HDMI-0" 4 "DP-0" 5 "HDMI-0" 6 "DP-0" 7 "HDMI-0" 8 "DP-0" 9  "HDMI-0"))
(setq exwm-randr-workspace-output-plist '(0 "DP-0" 1 "DP-3" 2 "DP-0" 3 "DP-0" 4 "DP-0" 5 "DP-0"))

(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output DP-0 --right-of DP-3 --auto")))
             ;; "xrandr" nil "xrandr --output HDMI-0 --left-of DP-0  --auto --primary")))
(exwm-randr-enable)
;; (add-hook 'exwm-randr-screen-change-hook
;;           (lambda ()
;;             (start-process-shell-command
;;              "xrandr --output HDMI-0  --rotate left")))

(setq exwm-workspace-number 2)
;; Make class name the buffer name
(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))
;; 's-r': Reset
(exwm-input-set-key (kbd "s-r") #'exwm-reset)
;; 's-w': Switch workspace
(exwm-input-set-key (kbd "s-s") #'exwm-workspace-switch)

;; Switch to certain workspace
(dotimes (i 6)
  (exwm-input-set-key (kbd (format "s-%i" i))
                      `(lambda ()
                         (interactive)
                         (exwm-workspace-switch-create ,i))))
;; Launch application
(exwm-input-set-key (kbd "s-d")
                    (lambda (command)
                      (interactive (list (read-shell-command "$ ")))
                      (start-process-shell-command command nil command)))


;; browser start
(exwm-input-set-key (kbd "s-<return>")
                    (lambda ()
                      (interactive)
                      (start-process-shell-command "yandex-browser-beta --force-device-scale-factor=1.5" nil "yandex-browser-beta --force-device-scale-factor=1.5")))




;; Launch application
;; (exwm-input-set-key (kbd "s-d")
;;                     (lambda (command)
;;                       (interactive (list (read-shell-command "$ ")))
;;                       (start-process-shell-command command nil command)))

; (push ?\s-x exwm-input-prefix-keys)

;; 関数の定義
(defun exwm-workspace-toggle ()
  "exwm workspace toggle 0 or 1"
  (interactive)
  (if (= exwm-workspace-current-index 0)
      (exwm-workspace-switch 1)
    (exwm-workspace-switch 0)))
(defun start-pavucontrol ()
  (interactive)
  (start-process-shell-command
   "start pavucontrol"
   nil
   (format "pavucontrol")))

;;; Those cannot be set globally: if Emacs would be run in another WM, the "s-"
;;; prefix will conflict with the WM bindings.
(exwm-input-set-key (kbd "s-n") 'windmove-down)
(exwm-input-set-key (kbd "s-f") 'windmove-right)
(exwm-input-set-key (kbd "s-b") 'windmove-left)
(exwm-input-set-key (kbd "s-p") 'windmove-up)
(exwm-input-set-key (kbd "s-<tab>") 'exwm-workspace-toggle)
;; (exwm-input-set-key (kbd "s-m") #'exwm-workspace-move-window)
;; (exwm-input-set-key (kbd "s-m") 'exwm-workspace-switch-to-buffer)
(exwm-input-set-key (kbd "s-a") 'zoom-window-zoom)
;; (exwm-input-set-key (kbd "s-R") 'exwm-restart)
(exwm-input-set-key (kbd "C-M-v") 'scroll-other-window)
(exwm-input-set-key (kbd "C-M-S-v") 'scroll-other-window-down)
;; (exwm-input-set-key (kbd "<f9>") 'output_toggle)
;; (exwm-input-set-key (kbd "<f10>") 'mute_toggle)
;; (exwm-input-set-key (kbd "<f11>") 'lower_volume)
;; (exwm-input-set-key (kbd "<f12>") 'upper_volume)
(exwm-input-set-key (kbd "C-s-i") 'output_toggle)
(exwm-input-set-key (kbd "C-s-m") 'mute_toggle)
(exwm-input-set-key (kbd "C-s-n") 'lower_volume)
(exwm-input-set-key (kbd "C-s-p") 'upper_volume)
(exwm-input-set-key (kbd "s-q") 'kill-buffer)
(exwm-input-set-key (kbd "s-h") 'delete-window)
(define-key exwm-mode-map (kbd "s-SPC") 'exwm-floating-toggle-floating)

;; chomeの起動
(exwm-input-set-key (kbd "s-c")
                    (lambda ()
                      (interactive)
                      (start-process-shell-command "google-chrome-stable" nil "google-chrome-stable")))


(setq exwm-input-simulation-keys
      '(
        ;; like emacs
        ;; charactor
        ([?\C-b] . [left])
        ([?\M-b] . [C-left])
        ([?\C-f] . [right])
        ([?\M-f] . [C-right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end ?\C-x])
        ([?\M-<] . [C-home])
        ([?\M->] . [C-end])
        ([?\C-/] . [C-z])
        ([?\C-h] . [backspace])
        ([?\C-m] . [return])
        ([?\C-/] . [C-z])
        ;; cut/paste.
        ([?\C-w] . [?\C-x])
        ([?\M-w] . [?\C-c])
        ([?\C-y] . [?\C-v])
        ;; ([?\C-x ?\h] . [?\C-a])
        ([?\M-d] . [C-S-right ?\C-x])
        ([M-backspace] . [C-S-left ?\C-x])
        ;; search
        ([?\C-s] . [?\C-f])
        ;; others
        ;; ([?\C-c ?s] . [?\C-s])
        ;; ([?\C-c ?p] . [?\C-p])
        ;; ([?\C-c ?n] . [?\C-n])
        ;; ([?\C-c ?h] . [?\C-h])
        ;; ([?\C-c ?b] . [?\C-b])
        ;; escape
        ([?\C-g] . [escape])
        ;; like mac
        ([?\s-w] . [C-w])
        ([s-left] . [C-S-tab])
        ([s-right] . [C-tab])
        ;; ([s-up] . [C-tab])
        ;; ([s-down] . [C-tab])
        ([?\s-t] . [C-t])
        ([?\s-T] . [C-T])
        ;; ([?\s-n] . [C-n])
        ([?\s-N] . [C-N])
        ;; ([?\s-p] . [C-p])
        ;; ([?\s-r] . [C-r])
        ;; skk switch change
        ([?\C-j] . [C-&])
        ([?\C-l] . [C-^])
        ([?\s-l] . [C-k])
        ([?\s-k] . [C-l])
        ))


(exwm-enable)

(provide 'init-exwm)

;;サイドモニターを回転
(DP-0_primary)
