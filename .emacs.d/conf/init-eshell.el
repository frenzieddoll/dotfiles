;;; init-ehsell.el -- setting for eshell
;;; Commentary:
;;; Code:

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
          (list "translate" "~/python/translate.py")
          (list "pacmandate" "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1")
          (list "manga" "wine ~/Documents/Software/picture/MangaMeeya_73/MangaMeeya.exe")
          (list "backup" "~/.emacs.d/script/backup.sh")
          ))))
;; eshell起動時にエイリアスを読み込む
(add-hook 'eshell-mode-hook 'eshell-alias)

;; Unixコマンドエミュレーション無効化
(when (eq system-type 'gnu/linux)
  (eval-after-load "esh-module"
    '(setq eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))))

;; (require 'em-term)
;; (defun eshell-exec-visual (&rest args)
;;   (apply 'start-process
;;          "eshell-exec-visual" "eshell-exec-visual"
;;          "termite" "-title" "eshell-exec-visual" "-e" args)
;;   nil)

;; (setq eshell-visual-commands
;;       '("man" ))

;;; init-eshell.el ends here
