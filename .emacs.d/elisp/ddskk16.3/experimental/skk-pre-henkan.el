;;; skk-pre-henkan.el --- SKK $B8+=P$78l$NBe$o$j$K8uJd$rI=<((B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2017 Tsuyoshi Kitamoto  <tsuyoshi.kitamoto@gmail.com>

;; Author: Tsuyoshi Kitamoto  <tsuyoshi.kitamoto@gmail.com>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Keywords: japanese, mule, input method

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; Daredevil SKK is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to
;; the Free Software Foundation Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;    skk-dcomp-multiple-get-candidates()
;;      => skk-comp-get-candidate(first)
;;        => when first setq skk-comp-first t
;;           eval skk-completion-prog-list
;;           setq skk-comp-first nil

;; (defcustom skk-completion-prog-list '((skk-comp-by-history)
;;                                       (skk-comp-from-jisyo skk-jisyo)
;;                                       (skk-look-completion))

;;; How to use:
;;    (require 'skk-pre-henkan)

;;; Code:

(setq skk-dcomp-activate nil)
(setq skk-completion-prog-list '((skk-pre-henkan)))

;; internal variable.
(defvar skk-pre-henkan-candidates nil)

(defun skk-pre-henkan ()
  "$B%j%9%H(B `skk-completion-prog-list' $B$NMWAG$H$7$F;HMQ(B."
  ;; `skk-pre-henkan-candidates' $B$N(B car $B$rJV$9!#(B`skk-pre-henkan-candidates' $B$O=L$`!#(B
  ;; `skk-comp-first' $B$,(B t $B$J$i!"?7$?$J(B `skk-pre-henkan-candidates' $B$r:n$k!#(B
  (unless (string= skk-comp-key "")
    (when skk-comp-first
      (setq skk-pre-henkan-candidates (skk-pre-henkan-make-candidates)))
    (prog1
	(car (skk-treat-strip-note-from-word (car skk-pre-henkan-candidates)))
      (setq skk-pre-henkan-candidates (cdr skk-pre-henkan-candidates)))))

(defun skk-pre-henkan-make-candidates ()
  "`skk-comp-key' $B$r%-!<!J@hF,0lCW!K$H$7$F!"8uJd$N%j%9%H$rJV$9(B."
  (let ((list-jisyo '(skk-jisyo skk-large-jisyo))
	;; skk-comp-key $B$O(B buffer-local $B$J$N$G(B with-current-buffer() $BFb$G$O(B nil $B$K$J$k!#(B
	(key (format "^%s.* /" (car (split-string skk-comp-key "*" t))))
	(i 0)
	candidates)
    (dolist (jisyo list-jisyo)
      (with-current-buffer (skk-get-jisyo-buffer (symbol-value jisyo) 'nomsg)
	(goto-char skk-okuri-nasi-min)
	  (while (and (re-search-forward key nil t)
		      (< i 100))
	    (setq candidates (concat candidates
				     (buffer-substring-no-properties (point)
								     (progn (end-of-line)
									    (point)))))
	    (setq i (1+ i)))))
    (when candidates
      (split-string candidates "/" t))))

(provide 'skk-pre-henkan)

;;; skk-pre-henkan.el ends here
