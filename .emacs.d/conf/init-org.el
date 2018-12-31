(require 'ox-latex)
(setq org-latex-default-class "jsarticle")
;; (setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
(setq org-latex-pdf-process '("latexmk %f"))
;(setq org-latex-pdf-process '("latexmk -e '$lualatex=q/lualatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdflua %f"))
;(setq org-export-in-background t)
;; (setq org-file-apps
;;       '(("pdf" . "evince %s")))

;; org-latex-classes
(add-to-list 'org-latex-classes
             '("jsarticle"
               "\\documentclass[11pt,a4paper,uplatex]{jsarticle}
                [NO-DEFAULT-PACKAGES] [PACKAGES] [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
               ))

;; org-export-latex-no-toc
(defun org-export-latex-no-toc (depth)
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
  (setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

;; reftex with org mode
(add-hook 'org-mode-hook 'turn-on-reftex)
(defun org-mode-reftex-setup ()
   (load-library "reftex")
   (and (buffer-file-name)
        (file-exists-p (buffer-file-name))
        (reftex-parse-all))
   (define-key org-mode-map (kbd "C-c [") 'reftex-citation))
