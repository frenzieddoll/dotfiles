;;; init-dired.el -- setting for dired
;;; Commentary:
;;; Code:

;; diredの設定
;; ２画面ファイラー
(defvar dired-dwim-target t)
;; filter
(require 'dired-filter)
(define-key dired-mode-map (kbd "/") dired-filter-map)
;; wdired set to "e"
(require 'wdired)
(defvar wdired-allow-to-change-premissions t)
(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
;; コピーを使い安くする
(setq dired-dwim-target t)
(defvar dired-launch-mailcap-friend '("env" "xdg-open"))
(dired-launch-enable)
;; 再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sしたときにファイル名だけにマッチするように
(setq dired-isearch-filenames t)
;; .zipで終るファイルをZキーで展開できるように
(add-to-list 'dired-compress-file-suffixes '("\\.zip\\" ".zip" "unar"))
;; diredでlsオプションをつかう
(setq dired-listing-switches (purecopy "-alht"))
;; diredのコピーをバックグラウンドで行なう
(eval-after-load "dired-aux" '(require 'dired-async))


;; 外部アプリで開く
(require 'dired-open)
(when (eq system-type 'gnu/linux)
  (setq dired-open-extensions
        '(("mkv" . "mpv")
          ("mp4" . "mpv")
          ("avi" . "mpv")
          ("wmv" . "mpv")
          ("webm" . "mpv")
          ("mpg" . "mpv")
          ("flv" . "mpv")
          ("m4v" . "mpv")
          ("mp3" . "mpv")
          ("wav" . "mpv")
          ("m4a" . "mpv")
          ("3gp" . "mpv")
          ("rm" . "mpv")
          ("playlist" . "mpv --playlist")
          ("exe" . "wine")
          ;; ("pdf" . "zathura")
          ("zip" . "YACReader")
          ("rar" . "YACReader")
          ("tar" . "YACReader")
          ("xls" . "xdg-open")
          ("xlsx" . "xdg-open")
          ("gnumeric" . "gnumeric")
          ;; ("jpg" . "sxiv-rifle")
          ;; ("png" . "sxiv-rifle")
          ;; ("jpeg" . "sxiv-rifle")
          )))

(when (eq system-type 'darwin)
  (setq dired-open-extensions
        '(("key" . "open")
          ("docx" . "open")
          ("pdf" . "open")
          ("cmdf" . "open")
          ("xlsx" . "open")
          ("pxp" . "open")
          )))


(require 'dired-subtree)

;;; iを置き換え
(define-key dired-mode-map (kbd "<right>") 'dired-subtree-insert)
;;; org-modeのようにTABで折り畳む
(define-key dired-mode-map (kbd "<left>") 'dired-subtree-remove)
;;; C-x n nでsubtreeにナローイング
(define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)


;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
(defun dired-subtree-up-dwim (&optional arg)
  "Subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。."
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)

(define-key image-map (kbd "q") 'image-kill-buffer)
(define-key image-map (kbd "h") 'image-kill-buffer)
;; (defun kill-current-buffer ()
;;   (interactive "P")
;;   (kill-buffer b))
;; (define-key dired-mode-map (kbd "q")

(defun kill-current-buffer-and/or-dired-open-file ()
    "In Dired, dired-open-file for a file. For a directory, dired-find-file and
kill previously selected buffer."
    (interactive)
    (if (file-directory-p (dired-get-file-for-visit))
        (dired-find-alternate-file)
      (dired-view-file)))

(defun kill-current-buffer-and-dired-up-directory (&optional other-window)
  "In Dired, dired-up-directory and kill previously selected buffer."
  (interactive "P")
  (let ((b (current-buffer)))
    (dired-up-directory other-window)
    (kill-buffer b)))

(defun dired-open-file-other-window ()
  "In Dired, open file on other-window and select previously selected buffer."
  (interactive)
  (let ((cur-buf (current-buffer)) (tgt-buf (dired-open-file)))
    (switch-to-buffer cur-buf)
    (when tgt-buf
      (with-selected-window (next-window)
        (switch-to-buffer tgt-buf)))))

(defun dired-up-directory-other-window ()
  "In Dired, dired-up-directory on other-window"
  (interactive)
  (dired-up-directory t))


(define-key dired-mode-map (kbd "j") 'dired-next-line)
(define-key dired-mode-map (kbd "k") 'dired-previous-line)
(define-key dired-mode-map (kbd "h") 'kill-current-buffer-and-dired-up-directory)
(define-key dired-mode-map (kbd "l") 'kill-current-buffer-and/or-dired-open-file)
(define-key dired-mode-map (kbd "f") 'kill-current-buffer-and/or-dired-open-file)
(define-key dired-mode-map (kbd "b") 'kill-current-buffer-and-dired-up-directory)
(define-key dired-mode-map (kbd "q") 'kill-current-buffer-and-dired-up-directory)

(setq view-read-only t)
(require 'view)
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward )
(define-key view-mode-map (kbd "G") 'View-goto-line-last)
;; (define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
;; (define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
;; vi/w3m like
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "b") 'backward-char)
(define-key view-mode-map (kbd "n") 'next-line)
(define-key view-mode-map (kbd "p") 'previous-line)
(define-key view-mode-map (kbd "f") 'forward-char)
(define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") 'View-scroll-line-backward)

;;; init-dired.el ends here
