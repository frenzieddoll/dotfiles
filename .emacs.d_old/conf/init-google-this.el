(require 'selected)
(selected-global-mode 1)
(when (require 'selected nil t)
  (define-key selected-keymap (kbd "g") #'my:google-this))

(require 'google-this)
(with-eval-after-load "google-this"
  (defun my:google-this ()
    "検索確認をスキップして直接検索実行"
    (interactive)
    (google-this (current-word) t)))
