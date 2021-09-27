(leaf mew
    :disabled t
    :when (file-exists-p '"/usr/bin/stunnel")
    :ensure t
    :require t
    :commands mew mew-send
    :defvar mew-fcc mew-smtp-server mew-smtp-auth
    :custom ((mew-fcc . "+outbox")
             (exec-path . '(cons "/usr/bin" exec-path))
             (user-mail-address . "frenzieddoll@gmail.com")
             (user-full-name . "frenzieddoll")
             (mew-smtp-server . "smtp.gmail.com")
             (mail-user-agent . 'mew-user-agent)
             (mew-prog-ssl . "/usr/bin/stunnel")
             (mew-proto . "%")
             (mew-imap-server . "imap.gmail.com")
             (mew-imap-user . "frenzieddoll@gmail.com")
             (mew-imap-auth .  t)
             (mew-imap-ssl . t)
             (mew-imap-ssl-port . "993")
             (mew-smtp-auth . t)
             (mew-smtp-ssl . t)
             (mew-smtp-ssl-port . "465")
             (mew-smtp-user . "frenzieddoll@gmail.com")
             (mew-smtp-server . "smtp.gmail.com")
             (mew-fcc . "%Sent")
             (mew-imap-trash-folder . "%[Gmail]/Trash")
             (mew-use-cached-passwd . t)
             (mew-ssl-verify-level . 0)
             (mew-use-cached-passwd . t)
             (mew-use-master-passwd . t)
             (mew-use-text/html . t)
             (browse-url-browser-function . 'eww-browse-url)
             (mew-use-unread-mark . t)
             (mew-thread-indent-strings . ["+" "+" "|" " "])

             )
    :init
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook)
    :config
    ;; ファイルサーチをビルドイン関数で行なう
    (load "mew-search-with-buildin.el" t)
    (load "multipart-decode.el" t)
    ;; (require 'mew-builtin-search)
    (setq mew-search-method 'buildin)

    ;; (setq mew-thread-indent-strings  ["+" "+" "|" " "])
    (leaf *addSettings
      :when (fboundp 'shr-render-region)
      :when (fboundp 'libxml-parse-html-region)
      :custom ((mew-prog-text/html . 'shr-render-region))
      )
    )

(leaf *mewOriginal
  ;; :disabled t
  :when (file-exists-p "/bin/stunnel")
  :config
  ;; (load "init-mew" t)
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


  )
