;; pdf-tools
(require 'pdf-tools)
(require 'pdf-annot)
(require 'pdf-history)
(require 'pdf-info)
(require 'pdf-isearch)
(require 'pdf-links)
(require 'pdf-misc)
(require 'pdf-occur)
(require 'pdf-outline)
(require 'pdf-sync)
(require 'tablist-filter)
(require 'tablist)
(add-to-list 'auto-mode-alist (cons "\\.pdf$" 'pdf-view-mode))

;; isearch のマイナーモードをフック
(add-hook 'pdf-view-mode-hook
  (lambda ()
    (pdf-misc-size-indication-minor-mode)
    (pdf-links-minor-mode)
    (pdf-isearch-minor-mode)
  )
)
