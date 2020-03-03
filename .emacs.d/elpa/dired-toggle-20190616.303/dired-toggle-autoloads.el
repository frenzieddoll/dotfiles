;;; dired-toggle-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "dired-toggle" "dired-toggle.el" (0 0 0 0))
;;; Generated autoloads from dired-toggle.el

(autoload 'dired-toggle-quit "dired-toggle" "\
Quit action under `dired-toggle-mode'.

\(fn)" t nil)

(autoload 'dired-toggle-find-file "dired-toggle" "\
Wraper for `dired-find-file', use `find-alternate-file' instead so will not
create new buffer when changing directory, and will keep `dired-toggle-mode' and
`dired-hide-details-mode' states after opening new direcoty.

\(fn)" t nil)

(autoload 'dired-toggle-up-directory "dired-toggle" "\
Wraper for `dired-up-directory', use `find-alternate-file' instead so will
not create new buffer when changing directory, and will keep `dired-toggle-mode'
and `dired-hide-details-mode' states after opening new direcoty.

\(fn)" t nil)

(autoload 'dired-toggle "dired-toggle" "\
Toggle current buffer's directory.

\(fn &optional PREFIX)" t nil)

(autoload 'dired-toggle-project-root "dired-toggle" "\
Toggle current project root directory.

\(fn &optional PREFIX)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-toggle" '("dired-toggle-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dired-toggle-autoloads.el ends here
