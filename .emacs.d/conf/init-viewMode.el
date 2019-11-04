;;; init-viewMode.el --- setting for view mode

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

;; (provide 'init-viewMode)

(setq view-read-only t)
(require 'view)
(require 'keys-in-view-mode)
;; (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
;; (define-key view-mode-map (kbd "?") 'View-search-regexp-backward )
;; (define-key view-mode-map (kbd "G") 'View-goto-line-last)
;; (define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
;; (define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
;; vi/w3m like
(define-key view-mode-map (kbd "SPC") 'ignore)
(define-key view-mode-map (kbd "C-m") 'ignore)
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") 'View-scroll-line-backward)
(define-key view-mode-map (kbd "b") 'backward-char)
(define-key view-mode-map (kbd "n") 'next-line)
(define-key view-mode-map (kbd "p") 'previous-line)
(define-key view-mode-map (kbd "f") 'forward-char)
(global-set-key (kbd "C-;") 'view-mode)
(define-key view-mode-map (kbd "C-;") 'ignore)
(define-key view-mode-map (kbd "a") 'vim-forward-char-to-insert)
(define-key view-mode-map (kbd "A") 'vim-end-of-line-to-insert)
(define-key view-mode-map (kbd "I") 'vim-beginning-of-line-to-insert)
(define-key view-mode-map (kbd "i") 'View-exit)
(define-key view-mode-map (kbd "x") 'vim-del-char)
(define-key view-mode-map (kbd "X") 'vim-backward-kill-line)
(define-key view-mode-map (kbd "0") 'beginning-of-line)
(define-key view-mode-map (kbd "$") 'move-end-of-line)
(define-key view-mode-map (kbd "e") 'end-of-line)
(define-key view-mode-map (kbd "o") 'vim-o)
(define-key view-mode-map (kbd "O") 'vim-O)
(define-key view-mode-map (kbd "y") 'copy-region-as-kill)
(define-key view-mode-map (kbd "Y") 'vim-copy-line)
(define-key view-mode-map (kbd "w") 'forward-word+1)
(define-key view-mode-map (kbd "W") 'backward-word)
;; (define-key view-mode-map (kbd "P") 'vim-P)
(define-key view-mode-map (kbd "D") 'vim-kill-line)
(define-key view-mode-map (kbd ":") 'save-buffer)
(define-key view-mode-map (kbd "u") 'ignore)
(define-key view-mode-map (kbd "u") 'vim-undo)
(define-key view-mode-map (kbd "r") 'vim-redo)
(define-key view-mode-map (kbd "d") 'vim-kill-whole-line)
(define-key view-mode-map (kbd "c") 'vim-kill-whole-line-to-insert)
(define-key view-mode-map (kbd "g") 'View-goto-line)
(define-key view-mode-map (kbd "G") 'View-goto-percent)
;;; init-viewMode.el ends here
