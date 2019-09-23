(require 'notmuch)

(defun refleshMail ()
     "reflesh mail."
     (interactive)
     (start-process-shell-command
      "sync Gmail"
      nil
      (format "offlineimap")))


(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq send-mail-program "msmtp")
(setq message-sendmail-extra-arguments '("--read-envelop-from"))
(setq message-sendmail-f-is-evil 't)
(setq message-kill-buffer-on-exit t)

(define-key notmuch-show-mode-map (kbd "C-c C-o") 'browse-url-at-point)
(define-key notmuch-search-mode-map "g" 'notmuch-poll-and-refresh-this-buffer)
(define-key notmuch-hello-mode-map "g" 'notmuch-poll-and-refresh-this-buffer)
(define-key notmuch-hello-mode-map (kbd "C-c C-r") 'refleshMail)
(define-key notmuch-search-mode-map (kbd "C-c C-r") 'refleshMail)

(define-key notmuch-search-mode-map "d"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "deleted" (notmuch-search-get-tags))
        (notmuch-search-tag '("-deleted"))
      (notmuch-search-tag '("+deleted" "-inbox" "-unread")))))
