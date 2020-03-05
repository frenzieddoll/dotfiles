;;; init-mew.el --- setting for mew

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

;; (provide 'init-mew)

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(defvar mew-fcc "+outbox")
(setq exec-path (cons "/usr/bin" exec-path))

(setq user-mail-address "frenzieddoll@gmail.com")
(setq user-full-name "frenzieddoll")
(defvar mew-smtp-server "smtp.gmail.com")
(require 'mew)
(setq mail-user-agent 'mew-user-agent)
(define-mail-user-agent
  'mew-user-agent
  'mew-user-agent-compose
  'mew-draft-send-message
  'mew-draft-kill
  'mew-send-hook)

; Stunnel
(setq mew-prog-ssl "/usr/bin/stunnel")
; IMAP for Gmail
(setq mew-proto "%")
(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "frenzieddoll@gmail.com")
(setq mew-imap-auth  t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(defvar mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "frenzieddoll@gmail.com")
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-fcc "%Sent")
(setq mew-imap-trash-folder "%[Gmail]/Trash")
(setq mew-use-cached-passwd t)
(setq mew-ssl-verify-level 0)

(setq mew-use-cached-passwd t)
(setq mew-use-master-passwd t)

;; http://suzuki.tdiary.net/20140813.html#c04
(when (and (fboundp 'shr-render-region)
           ;; \\[shr-render-region] requires Emacs to be compiled with libxml2.
           (fboundp 'libxml-parse-html-region))
  (defvar mew-prog-text/html 'shr-render-region)) ;; 'mew-mime-text/html-w3m

(setq mew-use-text/html t)
(setq browse-url-browser-function 'eww-browse-url)
;; (condition-case nil
;;     (require 'eww)
;;   (file-error nil))

;; ファイルサーチをビルドイン関数で行なう

(load "google-contacts-mew.el" t)
(load "google-contacts.el" t)
(require 'google-contacts-mew)
(setq google-contacts-email "frenzieddoll@gmail.com")

;; ファイルサーチをビルドイン関数で行なう
(load "mew-search-with-buildin.el" t)
(load "multipart-decode.el" t)
;; (require 'mew-builtin-search)
(setq mew-search-method 'buildin)

;; 未読メールにUマークを付ける
(setq mew-use-unread-mark t)

(setq mew-thread-indent-strings ["+" "+" "|" " "])

;; (add-hook mew-init-hook '(lambda ()
;;                            (load "init-visual" t)))

;; (require 'mew-w3m)
;; (setq mew-prog-text/html 'w3m-region)
;; (setq mew-prog-text/xml 'w3m-region)
;; (setq mew-use-text/html t)
;; (setq mew-mime-multipart-alternative-list '("Text/Html" "Text/Plain" ".*"))
;; (add-hook 'mew-message-hook 'w3m-minor-mode)
;; (setq mew-file-max-size 10000000)

;; veguharrgiapddif

;;; init-mew.el ends here
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
