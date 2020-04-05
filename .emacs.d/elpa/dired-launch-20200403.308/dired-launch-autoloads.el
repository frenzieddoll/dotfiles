;;; dired-launch-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "dired-launch" "dired-launch.el" (0 0 0 0))
;;; Generated autoloads from dired-launch.el

(autoload 'dired-launch-command "dired-launch" "\
Attempt to launch appropriate executables on marked files in the current dired buffer." t nil)

(autoload 'dired-launch-with-prompt-command "dired-launch" "\
For each marked file in the current dired buffer, prompt user to specify an executable and then call the specified executable using that file." t nil)

(autoload 'dired-launch-mode "dired-launch" "\
Add commands to launch executables.

If called interactively, enable Dired-Launch mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'dired-launch-enable "dired-launch" "\
Ensure that `dired-launch-mode' will be enabled in `dired-mode'." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-launch" '("dired-launch-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dired-launch-autoloads.el ends here
