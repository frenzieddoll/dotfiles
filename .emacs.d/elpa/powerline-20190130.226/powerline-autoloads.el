;;; powerline-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "powerline" "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline.el"
;;;;;;  "085f3fc119b62568dc874ebacc268944")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/powerline-20190130.226/powerline.el

(autoload 'powerline-hud "powerline" "\
Return an XPM of relative buffer location using FACE1 and FACE2 of optional WIDTH.

\(fn FACE1 FACE2 &optional WIDTH)" nil nil)

(autoload 'powerline-mouse "powerline" "\
Return mouse handler for CLICK-GROUP given CLICK-TYPE and STRING.

\(fn CLICK-GROUP CLICK-TYPE STRING)" nil nil)

(autoload 'powerline-concat "powerline" "\
Concatonate STRINGS and pad sides by spaces.

\(fn &rest STRINGS)" nil nil)

(autoload 'defpowerline "powerline" "\
Create function NAME by wrapping BODY with powerline padding an propetization.

\(fn NAME BODY)" nil t)

(autoload 'powerline-raw "powerline" "\
Render STR as mode-line data using FACE and optionally PAD import on left (l) or right (r).

\(fn STR &optional FACE PAD)" nil nil)

(autoload 'powerline-fill "powerline" "\
Return empty space using FACE and leaving RESERVE space on the right.

\(fn FACE RESERVE)" nil nil)
 (autoload 'powerline-major-mode "powerline")
 (autoload 'powerline-minor-modes "powerline")
 (autoload 'powerline-narrow "powerline")
 (autoload 'powerline-vc "powerline")
 (autoload 'powerline-encoding "powerline")
 (autoload 'powerline-buffer-size "powerline")
 (autoload 'powerline-buffer-id "powerline")
 (autoload 'powerline-process "powerline")
 (autoload 'powerline-selected-window-active "powerline")

;;;### (autoloads "actual autoloads are elsewhere" "powerline" "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/powerline-20190130.226/powerline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "powerline" '("pl/" "powerline-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "powerline-separators"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-separators.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-separators.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "powerline-separators" '("powerline-image-apple-rgb" "pl/")))

;;;***

;;;### (autoloads nil "powerline-themes" "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-themes.el"
;;;;;;  "aa82b401d6549bfa904b4f93d0c2d0f5")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-themes.el

(autoload 'powerline-default-theme "powerline-themes" "\
Setup the default mode-line.

\(fn)" t nil)

(autoload 'powerline-center-theme "powerline-themes" "\
Setup a mode-line with major and minor modes centered.

\(fn)" t nil)

(autoload 'powerline-vim-theme "powerline-themes" "\
Setup a Vim-like mode-line.

\(fn)" t nil)

(autoload 'powerline-nano-theme "powerline-themes" "\
Setup a nano-like mode-line.

\(fn)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "powerline-themes"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-themes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-themes.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "powerline-themes" '("powerline-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-separators.el"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline-themes.el"
;;;;;;  "../../../../../.emacs.d/elpa/powerline-20190130.226/powerline.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; powerline-autoloads.el ends here
