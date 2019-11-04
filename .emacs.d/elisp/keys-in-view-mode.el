;;; keys-in-view-mode.el --- setting for keys-in-view-mode

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

;; (provide 'keys-in-view-mode)

;; keys-in-view-mode.el
;; ==============================
;; like a
(defun vim-forward-char-to-insert ()
  (interactive)
  (view-mode 0)
  (forward-char 1)
  (message "edit-mode !"))
;; like A
(defun vim-end-of-line-to-insert ()
  (interactive)
  (view-mode 0)
  (end-of-line)
  (message "edit-mode !"))
;; like I
(defun vim-beginning-of-line-to-insert ()
  (interactive)
  (view-mode 0)
  (beginning-of-line)
  (message "edit-mode !"))
;; like cc
(defun vim-kill-whole-line-to-insert ()
  (interactive)
  (view-mode 0)
  (kill-whole-line)
  (open-line 1)
  (backward-line)
  (beginning-of-line)
  (message ":kill-whole-line and edit-mode !"))
;; like dd
(defun vim-kill-whole-line ()
  (interactive)
  (view-mode 0)
  (kill-whole-line)
  (view-mode 1)
  (message "kill-whole-line"))
;; like D
(defun vim-kill-line ()
  (interactive)
  (view-mode 0)
  (kill-line)
  (view-mode 1)
  (message "kill-line"))
;; like C
(defun vim-kill-line-to-insert ()
  (interactive)
  (view-mode 0)
  (kill-line)
  (message "kill-line and edit-mode !"))
;; like o
(defun vim-o ()
  (interactive)
  (view-mode 0)
  (forward-line)
  (open-line 1)
  (beginning-of-line)
  (message "edit-mode !"))
;; like O
(defun vim-O ()
  (interactive)
  (view-mode 0)
  (open-line 1)
  (beginning-of-line)
  (message "edit-mode !"))
;; like x
(defun vim-del-char ()
  (interactive)
  (view-mode 0)
  (delete-char 1)
  (view-mode 1)
  (message "delete-char"))
;; like c
(defun vim-del-char-to-insert ()
  (interactive)
  (view-mode 0)
  (delete-char 1)
  (message "delete-char and edit mode !"))
;; like u
(defun vim-undo ()
  (interactive)
  (view-mode 0)
  (undo-tree-undo)
  (view-mode 1)
  (message "undo !"))
;; like C-r
(defun vim-redo ()
  (interactive)
  (view-mode 0)
  (undo-tree-redo)
  (view-mode 1)
  (message "redo !"))
;; like Y
(defun vim-copy-line (arg)
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; like P
(defun vim-P ()
  (interactive)
  (view-mode 0)
  (beginning-of-line)
  (yank)
  (beginning-of-line)
  (forward-line -1)
  (view-mode 1)
  (message "yank !"))
;; like p
(defun vim-p ()
  (interactive)
  (view-mode 0)
  (yank)
  (view-mode 1)
  (message "yank !"))
;; like w
(defun forward-word+1 ()
  (interactive)
  (forward-word)
  (forward-char))
;; like %
(defun vim-jump-brace()
  "Jump to correspondence parenthesis"
  (interactive)
  (let ((c (following-char))
				(p (preceding-char)))
		(if (eq (char-syntax c) 40) (forward-list)
			(if (eq (char-syntax p) 41) (backward-list)
				(backward-up-list)))))
;; Delete from cursor position to beginning-of-line
(defun vim-backward-kill-line (arg)
  "Kill chars backward until encountering the beginning of line."
  (interactive "p")
  (view-mode 0)
  (kill-line 0)
  (view-mode 1)
  (message "backward-kill-line"))

(provide 'keys-in-view-mode)

;;; keys-in-view-mode.el ends here
