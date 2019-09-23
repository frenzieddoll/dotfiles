;;; biblio-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "biblio-arxiv" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-arxiv.el"
;;;;;;  "4c4563ea48f9663e6a8be079ce643946")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-arxiv.el

(autoload 'biblio-arxiv-backend "biblio-arxiv" "\
A arXiv backend for biblio.el.
COMMAND, ARG, MORE: See `biblio-backends'.

\(fn COMMAND &optional ARG &rest MORE)" nil nil)

(add-hook 'biblio-init-hook #'biblio-arxiv-backend)

(autoload 'biblio-arxiv-lookup "biblio-arxiv" "\
Start an arXiv search for QUERY, prompting if needed.

\(fn &optional QUERY)" t nil)

(defalias 'arxiv-lookup 'biblio-arxiv-lookup)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-arxiv"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-arxiv.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-arxiv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-arxiv" '("biblio-arxiv-")))

;;;***

;;;***

;;;### (autoloads nil "biblio-crossref" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-crossref.el"
;;;;;;  "16695f271a12dd3a394aa60baddb2312")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-crossref.el

(autoload 'biblio-crossref-backend "biblio-crossref" "\
A CrossRef backend for biblio.el.
COMMAND, ARG, MORE: See `biblio-backends'.

\(fn COMMAND &optional ARG &rest MORE)" nil nil)

(add-hook 'biblio-init-hook #'biblio-crossref-backend)

(autoload 'biblio-crossref-lookup "biblio-crossref" "\
Start a CrossRef search for QUERY, prompting if needed.

\(fn &optional QUERY)" t nil)

(defalias 'crossref-lookup 'biblio-crossref-lookup)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-crossref"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-crossref.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-crossref.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-crossref" '("biblio-crossref-")))

;;;***

;;;***

;;;### (autoloads nil "biblio-dblp" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dblp.el"
;;;;;;  "d755592275c3878dfd9bfaba8021724f")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dblp.el

(autoload 'biblio-dblp-backend "biblio-dblp" "\
A DBLP backend for biblio.el.
COMMAND, ARG, MORE: See `biblio-backends'.

\(fn COMMAND &optional ARG &rest MORE)" nil nil)

(add-hook 'biblio-init-hook #'biblio-dblp-backend)

(autoload 'biblio-dblp-lookup "biblio-dblp" "\
Start a DBLP search for QUERY, prompting if needed.

\(fn &optional QUERY)" t nil)

(defalias 'dblp-lookup 'biblio-dblp-lookup)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-dblp"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dblp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dblp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-dblp" '("biblio-dblp--")))

;;;***

;;;***

;;;### (autoloads nil "biblio-dissemin" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dissemin.el"
;;;;;;  "9876453a4c9e2f4fabc84ebd6a446484")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dissemin.el

(autoload 'biblio-dissemin-lookup "biblio-dissemin" "\
Retrieve a record by DOI from Dissemin, and display it.
Interactively, or if CLEANUP is non-nil, pass DOI through
`biblio-cleanup-doi'.

\(fn DOI &optional CLEANUP)" t nil)

(defalias 'dissemin-lookup 'biblio-dissemin-lookup)

(autoload 'biblio-dissemin--register-action "biblio-dissemin" "\
Add Dissemin to list of `biblio-selection-mode' actions.

\(fn)" nil nil)

(add-hook 'biblio-selection-mode-hook #'biblio-dissemin--register-action)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-dissemin"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dissemin.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dissemin.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-dissemin" '("biblio-dissemin--")))

;;;***

;;;***

;;;### (autoloads nil "biblio-doi" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-doi.el"
;;;;;;  "5cfdfb16152398b5abb6726129c87151")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-doi.el

(autoload 'doi-insert-bibtex "biblio-doi" "\
Insert BibTeX entry matching DOI.

\(fn DOI)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-doi" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-doi.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-doi.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-doi" '("biblio-doi-")))

;;;***

;;;***

;;;### (autoloads nil "biblio-download" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-download.el"
;;;;;;  "fa4738d5791f5594a0793e9ede93bc26")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-download.el

(autoload 'biblio-download--register-action "biblio-download" "\
Add download to list of `biblio-selection-mode' actions.

\(fn)" nil nil)

(add-hook 'biblio-selection-mode-hook #'biblio-download--register-action)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-download"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-download.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-download.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-download" '("biblio-download-")))

;;;***

;;;***

;;;### (autoloads nil "biblio-hal" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-hal.el"
;;;;;;  "a1f31d01b78445a7d130c6dd6cb1e5da")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-hal.el

(autoload 'biblio-hal-backend "biblio-hal" "\
A HAL backend for biblio.el.
COMMAND, ARG, MORE: See `biblio-backends'.

\(fn COMMAND &optional ARG &rest MORE)" nil nil)

(add-hook 'biblio-init-hook #'biblio-hal-backend)

(autoload 'biblio-hal-lookup "biblio-hal" "\
Start a HAL search for QUERY, prompting if needed.

\(fn &optional QUERY)" t nil)

(defalias 'hal-lookup 'biblio-hal-lookup)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-hal" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-hal.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-hal.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-hal" '("biblio-hal--")))

;;;***

;;;***

;;;### (autoloads nil "biblio-ieee" "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-ieee.el"
;;;;;;  "9058a06799fd97b6674ac1a83e3479d8")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-ieee.el

(autoload 'biblio-ieee-backend "biblio-ieee" "\
A IEEE Xplore backend for biblio.el.
COMMAND, ARG, MORE: See `biblio-backends'.

\(fn COMMAND &optional ARG &rest MORE)" nil nil)

(add-hook 'biblio-init-hook #'biblio-ieee-backend)

(autoload 'biblio-ieee-lookup "biblio-ieee" "\
Start a IEEE search for QUERY, prompting if needed.

\(fn &optional QUERY)" t nil)

(defalias 'ieee-lookup 'biblio-ieee-lookup)

;;;### (autoloads "actual autoloads are elsewhere" "biblio-ieee"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-ieee.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-ieee.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "biblio-ieee" '("biblio-ieee--")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-arxiv.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-crossref.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dblp.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-dissemin.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-doi.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-download.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-hal.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-ieee.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/biblio-20190624.1408/biblio.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; biblio-autoloads.el ends here
