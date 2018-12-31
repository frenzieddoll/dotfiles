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

;;; System tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)
;; (setq exwm-systemtray-height 16)

(require 'exwm)

(setq exwm-workspace-number 4)
;; Make class name the buffer name
(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))
;; 's-r': Reset
(exwm-input-set-key (kbd "s-r") #'exwm-reset)
;; 's-w': Switch workspace
(exwm-input-set-key (kbd "s-s") #'exwm-workspace-switch)
;; transport other windows
;; (exwm-input-set-key (kbd "s-<tab>") #'other-window)
;; 's-N': Switch to certain workspace
(dotimes (i 10)
  (exwm-input-set-key (kbd (format "s-%i" i))
                      `(lambda ()
                         (interactive)
                         (exwm-workspace-switch-create ,i))))
;; 's-&': Launch application
(exwm-input-set-key (kbd "s-d")
                    (lambda (command)
                      (interactive (list (read-shell-command "$ ")))
                      (start-process-shell-command command nil command)))

;;; Those cannot be set globally: if Emacs would be run in another WM, the "s-"
;;; prefix will conflict with the WM bindings.
;; (exwm-input-set-key (kbd "s-R") #'exwm-reset)
;; (exwm-input-set-key (kbd "s-x") #'exwm-input-toggle-keyboard)
;; (exwm-input-set-key (kbd "s-b") #'windmove-left)
;; (exwm-input-set-key (kbd "s-n") #'windmove-down)
;; (exwm-input-set-key (kbd "s-p") #'windmove-up)
;; (exwm-input-set-key (kbd "s-f") #'windmove-right)
;; (exwm-input-set-key (kbd "s-D") #'kill-this-buffer)
;; (exwm-input-set-key (kbd "s-b") #'list-buffers)
;; (exwm-input-set-key (kbd "s-f") #'find-file)


;; ;; The following can only apply to EXWM buffers, else it could have unexpected effects.
;; (push ?\s-  exwm-input-prefix-keys)
;; (define-key exwm-mode-map (kbd "s-SPC") #'exwm-floating-toggle-floating)

;; (exwm-input-set-key (kbd "s-i") #'follow-delete-other-windows-and-split)
;; ;; (exwm-input-set-key (kbd "s-o") #'ambrevar/toggle-single-window)
;; (exwm-input-set-key (kbd "s-O") #'exwm-layout-toggle-fullscreen)

;; 's-&': Launch application
(exwm-input-set-key (kbd "s-d")
                    (lambda (command)
                      (interactive (list (read-shell-command "$ ")))
                      (start-process-shell-command command nil command)))

(push ?\C-o exwm-input-prefix-keys)
;; (exwm-input-set-key (kbd "C-c n") 'windmove-down)
;; (exwm-input-set-key (kbd "C-c f") 'windmove-right)
;; (exwm-input-set-key (kbd "C-c b") 'windmove-left)
;; (exwm-input-set-key (kbd "C-c p") 'windmove-up)
(exwm-input-set-key (kbd "s-n") 'windmove-down)
(exwm-input-set-key (kbd "s-f") 'windmove-right)
(exwm-input-set-key (kbd "s-b") 'windmove-left)
(exwm-input-set-key (kbd "s-p") 'windmove-up)
(exwm-input-set-key (kbd "s-<tab>") 'other-window)
(exwm-input-set-key (kbd "s-a") 'helm-mini)
(exwm-input-set-key (kbd "C-M-v") 'scroll-other-window)
(exwm-input-set-key (kbd "C-M-S-v") 'scroll-other-window-down)
(exwm-input-set-key (kbd "M-<tab>") 'switch-to-next-buffer)
(exwm-input-set-key (kbd "<f9>") 'output_toggle)
(exwm-input-set-key (kbd "<f10>") 'mute_toggle)
(exwm-input-set-key (kbd "<f11>") 'lower_volume)
(exwm-input-set-key (kbd "<f12>") 'upper_volume)




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
        ([?\s-l] . [C-l])
        ([?\s-k] . [C-k])
        ))


(exwm-enable)

(provide 'init-exwm)
