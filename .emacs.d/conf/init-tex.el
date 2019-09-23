;;
;; Org mode
;;
(require 'ox-latex)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-latex-default-class "bxjsarticle")

(add-to-list 'org-latex-classes
             '("bxjsarticle"
               "\\documentclass[autodetect-engine,dvi=dvipdfmx,11pt,a4paper,ja=standard]{bxjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\ifdefined\\kanjiskip
  \\usepackage{pxjahyper}
  \\hypersetup{colorlinks=true}
\\else
  \\ifdefined\\XeTeXversion
      \\hypersetup{colorlinks=true}
  \\else
    \\ifdefined\\directlua
      \\hypersetup{pdfencoding=auto,colorlinks=true}
    \\else
      \\hypersetup{unicode,colorlinks=true}
    \\fi
  \\fi
\\fi"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
               ("longnamesfirst,colon,sort&compress"     "natbib"  nil)))

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
             '("thesis"
               "\\documentclass{jarticle}
                [NO-PACKAGES]
                [NO-DEFAULT-PACKAGES]
                \\usepackage[dvipdfmx]{graphicx}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("jsarticle"
               "\\documentclass[dvipdfmx,12pt]{jsarticle}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
             )
)


;; (setq org-latex-pdf-process
;;       '("xelatex -interaction nonstopmode -output-directory %o %f"
;;         "bibtex %b"
;;         "xelatex -interaction nontopmode -output-directory %o %f"
;;         "xelatex -interaction nonstopmode -output-directory %o %f"))

;; (setq org-file-apps
;;       '(("pdf" . "evince %s")))

(setq org-latex-pdf-process '("platex %b" "mendex %b" "platex %b" "dvipdfmx %b"))

;; (setq org-latex-pdf-process
;;       '("platex %f"
;;         "platex %f"
;;         "platex %b"
;;         "platex %f"
;;         "platex %f"
;;         "dvipdfmx %b.dvi"))

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
