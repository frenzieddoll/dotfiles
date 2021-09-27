(setq ebib-preload-bib-files
      '("~/tex/references.bib"))

(setq bibtex-autokey-name-case-convert 'capitalize)
(setq bibtex-autokey-titleword-case-convert 'capitalize)
(setq bibtex-autokey-titleword-separator "")
(setq bibtex-autokey-titleword-length nil)
(setq bibtex-autokey-titlewords 1)
(setq bibtex-autokey-year-length 4)
(setq bibtex-autokey-year-title-separator "_")
(setq bibtex-autokey-titleword-ignore
      '("A" "An" "On" "The" "a" "an" "on" "the"
        "Le" "La" "Les" "le" "la" "les"
        "Zur" "zur" "Des" "Dir" "Die"))

(setq ebib-keywords-use-only-file t)
(setq ebib-keywords-file "~/tex/ebib-keywords.txt")
(setq ebib-keywords-file-save-on-exit 'always)

(setq ebib-file-search-dirs '("~/tex/papers" "~/tex/books"))


(setq ebib-file-associations
      '(("pdf" . "open")
        ("ps"  . "open")))

(global-set-key (kbd "C-c C-z") 'ebib)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
