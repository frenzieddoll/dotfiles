;;eww の設定

(require 'eww)

;; 検索エンジンの変更
(setq eww-search-prefix "https://www.google.co.jp/search?btnl&q=")

(defun eww-disable-images ()
  "eww で画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "eww で画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
;; はじめから非表示
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

;; 外部ブラウザで開く
(setq eww-browse-with-external-link t)

;; 現在のurlをewwで開く
(defun browse-url-with-eww ()
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    ;; url
    (if url-region
      (eww-browse-url (buffer-substring-no-properties (car url-region)
                              (cdr url-region))))
    ;; org-link
    (setq browse-url-browser-function 'eww-browse-url)
    (org-open-at-point)))

(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

;; (define-key eww-link-keymap "f" 'ace-link-eww)
(define-key eww-mode-map (kbd "f") 'ace-link-eww)

;; (define-key eww-mode-map (kbd "H") 'eww-back-url)
;; (define-key eww-mode-map (kbd "L") 'eww-next-url)
(define-key eww-mode-map (kbd "s-l") 'eww-search-words)
(define-key eww-mode-map (kbd "M") 'eww-open-in-new-buffer)
(define-key eww-mode-map (kbd "s-w") 'eww-buffer-kill)
(define-key eww-mode-map (kbd "C-s-v") 'eww-enable-images)
(define-key eww-mode-map (kbd "s-v") 'eww-disable-images)
(global-set-key (kbd "C-c m") 'browse-url-with-eww)
(define-key eww-mode-map (kbd "s-e") 'eww-browse-with-external-browser)
