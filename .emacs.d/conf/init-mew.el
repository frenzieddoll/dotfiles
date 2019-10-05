(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-fcc "+outbox")
(setq exec-path (cons "/usr/bin" exec-path))

(setq user-mail-address "frenzieddoll@gmail.com")
(setq user-full-name "frenzieddoll")
(setq mew-smtp-server "smtp.gmail.com")
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
(setq mew-smtp-auth t)
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
  (setq mew-prog-text/html 'shr-render-region)) ;; 'mew-mime-text/html-w3m

;; veguharrgiapddif
