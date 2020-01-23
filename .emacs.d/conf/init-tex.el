<;;
;; Org mode
;;

(require 'ox-latex)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-latex-default-class "thesis")

(add-to-list 'org-latex-classes
             '("thesis"
               "\\documentclass[autodetect-engine,dvi=dvipdfmx,11pt,a4paper,ja=standard]{bxjsarticle}
               [NO-DEFAULT-PACKAGES]
               \\usepackage{amsmath}
               \\usepackage{newtxtext,newtxmath}
               \\usepackage[dvipdfmx]{graphicx}
               \\usepackage{hyperref}
               \\ifdefined\\kanjiskip
                 \\usepackage{pxjahyper}
                 \\hypersetup{colorlinks=true,citecolor=blue,linkcolor=black}
               \\else
                 \\ifdefined\\XeTeXversion
                     \\hypersetup{colorlinks=true,citecolor=blue,linkcolor=black}
                 \\else
                   \\ifdefined\\directlua
                     \\hypersetup{pdfencoding=auto,colorlinks=true,citecolor=blue,linkcolor=black}
                   \\else
                     \\hypersetup{unicode,colorlinks=ture,citecolor=blue,linkcolor=black}
                   \\fi
                 \\fi
               \\fi"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("koma-jarticle"
               "\\documentclass{scrartcl}
               \\usepackage{amsmath}
               \\usepackage{amssymb}
               \\usepackage{xunicode}
               \\usepackage{fixltx2e}
               \\usepackage{zxjatype}
               \\usepackage{xltxtra}
               \\usepackage{graphicx}
               \\usepackage{longtable}
               \\usepackage{float}
               \\usepackage{wrapfig}
               \\usepackage{soul}
               \\usepackage{hyperref}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; tufte-handout class for writing classy handouts and papers
(add-to-list 'org-latex-classes
             '("tufte-handout"
               "\\documentclass[twoside,nobib]{tufte-handout}
                                 [NO-DEFAULT-PACKAGES]
                \\usepackage{zxjatype}
                \\usepackage[hiragino-dx]{zxjafont}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")))
;; tufte-book class
(add-to-list 'org-latex-classes
             '("tufte-book"
               "\\documentclass[twoside,nobib]{tufte-book}
                                [NO-DEFAULT-PACKAGES]
                 \\usepackage{zxjatype}
                 \\usepackage[hiragino-dx]{zxjafont}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(add-to-list 'org-latex-classes
             '("jsarticle"
               "\\documentclass[dvipdfmx,12pt]{jsarticle}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
             ))


;; Mac用の設定
(when (eq system-type 'darwin)
  (setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:/Applications/Skim.app/Contents/SharedSupport:$PATH" t)
  (setq exec-path (append '("/usr/local/bin" "/Library/TeX/texbin" "/Applications/Skim.app/Contents/SharedSupport") exec-path))
  (setq org-file-apps
      '(("pdf" . "open %s"))))



;; 参考文献を含まないコンパイル
(setq org-latex-pdf-process
      '("uplatex %b"
        "dvipdfmx %b"))

(defun includeReference ()
  (interactive)
  (setq org-latex-pdf-process
        '("uplatex %b"
          "upbibtex %b"
          "uplatex %b"
          "uplatex %b"
          "dvipdfmx %b")))

(defun notIncludeReference ()
  (interactive)
  (setq org-latex-pdf-process
      '("uplatex %b"
        "dvipdfmx %b")))

(require 'ox-bibtex)

(setq org-ref-completion-library 'org-ref-ivy-cite)

(require 'org-ref)
(setq reftex-default-bibliography '("~/tex/references.bib"))

;; ;; ノート、bib ファイル、PDF のディレクトリなどを設定
(setq org-ref-bibliography-notes "~/tex/notes.org"
      org-ref-default-bibliography '("~/tex/references.bib")
      org-ref-pdf-directory "~/tex/bibtex-pdfs/")

(setq bibtex-completion-bibliography "~/tex/references.bib"
      bibtex-completion-library-path "~/tex/bibtex-pdfs"
      bibtex-completion-notes-path "~/tex/ivy-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

(define-key org-mode-map (kbd "C-c c c") 'org-ref-ivy-insert-cite-link)
(define-key org-mode-map (kbd "C-c c l") 'org-ref-ivy-insert-label-link)
(define-key org-mode-map (kbd "C-c c r") 'org-ref-ivy-insert-ref-link)






;; (setq org-file-apps
;;       '(("pdf" . "evince %s")))

;; (setq org-latex-pdf-process '("platex %b" "mendex %b" "platex %b" "dvipdfmx %b"))

;; (autoload 'helm-bibtex "helm-bibtex" "" t)
;; (setq bibtex-completion-bibliography
;;       '("~/tex/reference.bib"))
;; (define-key org-mode-map (kbd "C-c [") 'helm-bibtex)


;; (defun org-mode-reftex-setup ()
;;   (interactive)
;;   (load-library "reftex")
;;   (and (buffer-file-name)
;;        (file-exists-p (buffer-file-name))
;;        (reftex-parse-all))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation))
;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; (require 'ox-bibtex)
;; (require 'org-ref)
;; (setq reftex-default-bibliography '("~/tex/reference.bib"))

;; ;; ノート、bib ファイル、PDF のディレクトリなどを設定
;; (setq org-ref-default-bibliography '("~/tex/reference.bib"))


;; ;;; helm-bibtex を使う場合は以下の変数も設定しておく
;; (setq bibtex-completion-bibliography "~/tex/reference.bib")
;;       ;; bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
;;       ;; bibtex-completion-notes-path "~/Dropbox/bibliography/helm-bibtex-notes")
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
