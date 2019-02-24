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
(setq dired-listing-switches (purecopy "-alh"))

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
          ("playlist" . "mpv --playlist")
          ("exe" . "wine")
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

;;; init-dired.el ends here
