(defvar recentf-max-saved-items 2000)
(defvar recentf-auto-cleanup 'never)
(defvar recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recent-auto-save-timer (run-with-idle-timer 30 t 'recent-save-list))

(recentf-mode 1)
