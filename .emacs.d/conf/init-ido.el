
;; config
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(when (fboundp 'ido-vertical-mode)
  (ido-vertical-mode 1))
(setq ido-max-window-height 0.75)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-vertical-show-count t)
;; (when (fboundp 'smex)
;;   (global-set-key (kbd "M-x") 'smex))
(when (fboundp 'skk-mode)
  (fset 'ido-select-text 'skk-mode))
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(when (boundp 'confirm-nonexistent-file-or-buffer)
  (setq confirm-nonexistent-file-or-buffer nil))

;; bind
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x o") 'ido-select-window)
(global-set-key (kbd "M-y") 'browse-kill-ring)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; smexの設定
;; config
(require 'smex)
(smex-initialize)

;; bind
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)



;; recentfの設定
;; config
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(recentf-mode 1)
(defun my/ido-recentf ()
  (interactive)
  (find-file (ido-completing-read "Find recent file: " recentf-list)))
;; bind
(global-set-key (kbd "C-c h") 'my/ido-recentf)

;; config
(require 'ido-occasional)
(require 'imenus)
;; エラー対策
(defun imenu-finde-default--or-current-symbol (&rest them)
  (condition-case nil
      (apply them)
    (error (thing-at-point 'symbol))))
(advice-add 'imenu-find-default :around 'imenu-find-default--or-current-symbol)
(defun imenus-exit-minibuffer ()
  (exit-minibuffer))
;; ;; ido化
(with-ido-completion imenus)

;; bind
(global-set-key (kbd "C-M-s") (with-ido-completion imenus-mode-buffers))

;;; M-oでのmulti-occurをシンボル正規表現にするよう改良
;; (push '(occur . imenus-ido-multi-occur) imenus-actions)
;; (defun imenus-ido-multi-occur (buffers input)
;;   (multi-occur buffers
;;                (format "\\_<%s\\_>"
;;                        (regexp-quote (replace-regexp-in-string "^.*|" "" input)))))
