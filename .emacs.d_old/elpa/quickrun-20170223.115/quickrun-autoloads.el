;;; quickrun-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "quickrun" "../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun.el"
;;;;;;  "f82795b87d0ee63b1ca8c8d0d7133e98")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun.el

(autoload 'quickrun-set-default "quickrun" "\
Set `key' as default key in programing language `lang'

\(fn LANG KEY)" nil nil)

(autoload 'quickrun-add-command "quickrun" "\


\(fn KEY ALIST &key DEFAULT MODE OVERRIDE)" nil nil)

(function-put 'quickrun-add-command 'lisp-indent-function 'defun)

(autoload 'quickrun "quickrun" "\
Run commands quickly for current buffer
   With universal prefix argument(C-u), select command-key,
   With double prefix argument(C-u C-u), run in compile-only-mode

\(fn &rest PLIST)" t nil)

(autoload 'quickrun-with-arg "quickrun" "\
Run commands quickly for current buffer with arguments

\(fn ARG)" t nil)

(autoload 'quickrun-region "quickrun" "\
Run commands with specified region

\(fn START END)" t nil)

(autoload 'quickrun-replace-region "quickrun" "\
Run commands with specified region and replace

\(fn START END)" t nil)

(autoload 'quickrun-eval-print "quickrun" "\
Run commands with specified region and replace

\(fn START END)" t nil)

(autoload 'quickrun-compile-only "quickrun" "\
Exec only compilation

\(fn)" t nil)

(autoload 'quickrun-shell "quickrun" "\
Run commands in shell for interactive programs

\(fn)" t nil)

(autoload 'quickrun-autorun-mode "quickrun" "\
`quickrun' after saving buffer

\(fn &optional ARG)" t nil)

(autoload 'anything-quickrun "quickrun" "\


\(fn)" t nil)

(autoload 'helm-quickrun "quickrun" "\


\(fn)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "quickrun" "../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "quickrun" '("quick" "helm-quickrun-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/quickrun-20170223.115/quickrun.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; quickrun-autoloads.el ends here
