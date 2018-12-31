;; eshell setting
;; ショートカットキー
(global-set-key (kbd "C-c e") 'eshell)
;; (global-set-key (kbd "C-c C-e") 'eshell/make-new-eshell)
;; aliases
(defun eshell-alias ()
  (interactive)
  "eshell alias set"
  (setq eshell-command-aliases-list
        (append
         (list
          (list "ll" "ls -ltrh")
          (list "la" "ls -a")
          (list "o" "xdg-open")
          (list "emacs" "find-file $1")
          (list "m" "find-file $1")
          (list "mc" "find-file $1")
          (list "d" "dired .")
          (list "l" "eshell/less $1")
          (list "pacmandate" "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1")))))
;; eshell起動時にエイリアスを読み込む
(add-hook 'eshell-mode-hook 'eshell-alias)
