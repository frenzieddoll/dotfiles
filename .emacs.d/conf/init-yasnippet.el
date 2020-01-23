;;; init-yasnippet.el --- Setting for init-yasnippet

;; Copyright (C) 2019 by Toshiaki HONDA

;; Author: Toshiaki HONDA <frenzieddoll@gmail.com>
;; URL:
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'yasnippet)
;; (yas-global-mode 1)
(yas-minor-mode)


(define-key yas-minor-mode-map (kbd "C-c s i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-c s n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-c s v") 'yas-visit-snippet-file)
(define-key yas-minor-mode-map (kbd "C-c s l") 'yas-describe-tables)
(define-key yas-minor-mode-map (kbd "C-c s g") 'yas-reload-all)

(require 'cl)
(defvar ivy-programing-hooks ()
  '(emacs-lisp-mode
    org-mode))
(loop for hook in ivy-programing-hooks
      do (add-hook hook 'yas-minor-mode))

;; (define-key yas-minor-mode-map (kbd "C-;") 'yas/expand)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map [(tab)] nil)

;;; init-yasnippet.el ends here
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
