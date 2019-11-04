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
          (list "backup" "~/.emacs.d/script/backup.sh $1")
          (list "nvidiafix" "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
          (list "usbmount" "sudo mount -t vfat $1 $2 -o rw,umask=000")
          ))))
;; eshell起動時にエイリアスを読み込む
(add-hook 'eshell-mode-hook 'eshell-alias)

;; Unixコマンドエミュレーション無効化
(when (eq system-type 'gnu/linux)
  (eval-after-load "esh-module"
    '(defvar eshell-modules-list (delq 'eshell-ls (delq 'eshell-unix eshell-modules-list)))))

;; (require 'em-term)
;; (defun eshell-exec-visual (&rest args)
;;   (apply 'start-process
;;          "eshell-exec-visual" "eshell-exec-visual"
;;          "termite" "-title" "eshell-exec-visual" "-e" args)
;;   nil)

;; (setq eshell-visual-commands
;;       '("man" ))


;;;; sudo completion
(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-ignore-case t))
    (pcomplete-here (funcall pcomplete-command-completion-function))
    (while (pcomplete-here (pcomplete-entries)))))

;;;; systemctl completion
(defcustom pcomplete-systemctl-commands
  '("disable" "enable" "status" "start" "restart" "stop" "reenable"
    "list-units" "list-unit-files")
  "p-completion candidates for `systemctl' main commands"
  :type '(repeat (string :tag "systemctl command"))
  :group 'pcomplete)

(defvar pcomplete-systemd-units
  (split-string
   (shell-command-to-string
    "(systemctl list-units --all --full --no-legend;systemctl list-unit-files --full --no-legend)|while read -r a b; do echo \" $a\";done;"))
  "p-completion candidates for all `systemd' units")

(defvar pcomplete-systemd-user-units
  (split-string
   (shell-command-to-string
    "(systemctl list-units --user --all --full --no-legend;systemctl list-unit-files --user --full --no-legend)|while read -r a b;do echo \" $a\";done;"))
  "p-completion candidates for all `systemd' user units")

(defun pcomplete/systemctl ()
  "Completion rules for the `systemctl' command."
  (pcomplete-here (append pcomplete-systemctl-commands '("--user")))
  (cond ((pcomplete-test "--user")
         (pcomplete-here pcomplete-systemctl-commands)
         (pcomplete-here pcomplete-systemd-user-units))
        (t (pcomplete-here pcomplete-systemd-units))))

;;;; man completion
(defvar pcomplete-man-user-commands
  (split-string
   (shell-command-to-string
    "apropos -s 1 .|while read -r a b; do echo \" $a\";done;"))
  "p-completion candidates for `man' command")

(defun pcomplete/man ()
  "Completion rules for the `man' command."
  (pcomplete-here pcomplete-man-user-commands))
;;; init-eshell.el ends here
