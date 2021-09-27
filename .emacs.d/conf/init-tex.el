
;; latex on emacs org-mode for mac
;; PATH
;;
;; Mac用の設定
(when (eq system-type 'darwin)
  (setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:/Applications/Skim.app/Contents/SharedSupport:$PATH" t)
  (setq exec-path (append '("/usr/local/bin" "/Library/TeX/texbin" "/Applications/Skim.app/Contents/SharedSupport") exec-path))
  (setq org-file-apps
      '(("pdf" . "open %s"))))
;;
;; Org mode
;;
(require 'ox-latex)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-latex-default-class "thesis")
(setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
;(setq org-latex-pdf-process '("latexmk -e '$lualatex=q/lualatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdflua %f"))
;(setq org-export-in-background t)
;; (setq org-file-apps
;;       '(("pdf" . "open -a Skim %s")))

(add-to-list 'org-latex-classes
             '("thesis"
               "\\documentclass[autodetect-engine,dvi=dvipdfmx,11pt,a4paper,ja=standard]{bxjsarticle}
               [NO-DEFAULT-PACKAGES]
               \\usepackage{siunitx}
               \\usepackage{amsmath}
               \\usepackage{newtxtext,newtxmath}
               \\usepackage[dvipdfmx]{graphicx}
               \\usepackage{hyperref}
               \\usepackage[hang,small,bf]{caption}
               \\usepackage[subrefformat=parens]{subcaption}
               \\captionsetup{compatibility=false}

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


;; (add-to-list 'org-latex-classes
;;              '("bxjsarticle"
;;                "\\documentclass[autodetect-engine,dvi=dvipdfmx,11pt,a4paper,ja=standard]{bxjsarticle}
;; [NO-DEFAULT-PACKAGES]
;; \\usepackage{amsmath}
;; \\usepackage{newtxtext,newtxmath}
;; \\usepackage[dvipdfmx]{graphicx}
;; \\usepackage{hyperref}
;; \\ifdefined\\kanjiskip
;;   \\usepackage{pxjahyper}
;;   \\hypersetup{colorlinks=true,citecolor=blue,linkcolor=black}
;; \\else
;;   \\ifdefined\\XeTeXversion
;;       \\hypersetup{colorlinks=true,citecolor=blue,linkcolor=black}
;;   \\else
;;     \\ifdefined\\directlua
;;       \\hypersetup{pdfencoding=auto,colorlinks=true,citecolor=blue,linkcolor=black}
;;     \\else
;;       \\hypersetup{unicode,colorlinks=ture,citecolor=blue,linkcolor=black}
;;     \\fi
;;   \\fi
;; \\fi"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-to-list 'org-latex-classes
;;              '("jlreq"
;;                "\\documentclass[11pt,paper=a4]{jlreq}
;; [NO-DEFAULT-PACKAGES]
;; \\usepackage{amsmath}
;; \\usepackage{newtxtext,newtxmath}
;; \\ifdefined\\kanjiskip
;;   \\usepackage[dvipdfmx]{graphicx}
;;   \\usepackage[dvipdfmx]{hyperref}
;;   \\usepackage{pxjahyper}
;;   \\hypersetup{colorlinks=true}
;; \\else
;;   \\usepackage{graphicx}
;;   \\usepackage{hyperref}
;;   \\hypersetup{pdfencoding=auto,colorlinks=true}
;; \\fi"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-to-list 'org-latex-classes
;;              '("jlreq-tate"
;;                "\\documentclass[tate,11pt,paper=a4]{jlreq}
;; [NO-DEFAULT-PACKAGES]
;; \\usepackage{amsmath}
;; \\usepackage{newtxtext,newtxmath}
;; \\ifdefined\\kanjiskip
;;   \\usepackage[dvipdfmx]{graphicx}
;;   \\usepackage[dvipdfmx]{hyperref}
;;   \\usepackage{pxjahyper}
;;   \\hypersetup{colorlinks=true}
;; \\else
;;   \\usepackage{graphicx}
;;   \\usepackage{hyperref}
;;   \\hypersetup{pdfencoding=auto,colorlinks=true}
;; \\fi"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; (setq org-latex-pdf-process
;;       '("xelatex -interaction nonstopmode -output-directory %o %f"
;;         "bibtex %b"
;;         "xelatex -interaction nontopmode -output-directory %o %f"
;;         "xelatex -interaction nonstopmode -output-directory %o %f"))


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


;; (defun ivy-bibtex-my-publications (&optional arg)
;;   "Search BibTeX entries authored by “Jane Doe”.

;; With a prefix ARG, the cache is invalidated and the bibliography reread."
;;   (interactive "P")
;;   (when arg
;;     (bibtex-completion-clear-cache))
;;   (bibtex-completion-init)
;;   (ivy-read "BibTeX Items: "
;;             (bibtex-completion-candidates)
;;             :initial-input "Jane Doe"
;;             :caller 'ivy-bibtex
;;             :action ivy-bibtex-default-action))

;; ;; Bind this search function to Ctrl-x p:
;; (global-set-key (kbd "C-x p") 'ivy-bibtex-my-publications)

(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)


(require 'ox-bibtex)

(setq org-ref-completion-library 'org-ref-ivy-cite)
(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)
(require 'org-ref)
(setq reftex-default-bibliography '("~/tex/references.bib"))
(setq org-latex-prefer-user-labels t)

;; ;; ノート、bib ファイル、PDF のディレクトリなどを設定
(setq org-ref-bibliography-notes "~/tex/notes.org"
      org-ref-default-bibliography '("~/tex/references.bib")
      org-ref-pdf-directory "~/tex/papers")

(setq bibtex-completion-bibliography "~/tex/references.bib"
      bibtex-completion-library-path "~/tex/papers"
      bibtex-completion-notes-path "~/tex/ivy-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

(define-key org-mode-map (kbd "C-c c c") 'org-ref-ivy-insert-cite-link)
(define-key org-mode-map (kbd "C-c c l") 'org-ref-ivy-insert-label-link)
(define-key org-mode-map (kbd "C-c c r") 'org-ref-ivy-insert-ref-link)


;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)



;; ;;; helm-bibtex を使う場合は以下の変数も設定しておく
;; (setq bibtex-completion-bibliography "~/reference.bib")
;;       ;; bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
;;       ;; bibtex-completion-notes-path "~/Dropbox/bibliography/helm-bibtex-notes")
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
