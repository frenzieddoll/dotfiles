;;; init-auto-ansyc-byte-compile.el --- setting for auto-ansyc-byte-compile

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

;; (provide 'init-auto-ansyc-byte-compile)

(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/confbk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(defun confDirRecompile ()
  "オートコンパイルの対象ディレクトリ."
  (interactive)
  (byte-recompile-directory (expand-file-name "~/.emacs.d/conf") 0))




;;; init-auto-ansyc-byte-compile.el ends here
