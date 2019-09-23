(require 'notmuch)

(defun refleshMail ()
     "reflesh mail."
     (interactive)
     (start-process-shell-command
      "sync Gmail"
      nil
      (format "offlineimap")))
