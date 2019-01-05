;; diredの設定
;; ２画面ファイラー
(setq dired-dwim-target t)
;; filter
(require 'dired-filter)
(define-key dired-mode-map (kbd "/") dired-filter-map)
;; wdired set to "e"
(require 'wdired)
(setq wdired-allow-to-change-premissions t)
(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
;; コピーを使い安くする
(setq dired-dwim-target t)
(setq dired-launch-mailcap-friend '("env" "xdg-open"))
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
(setq dired-open-extensions
      '(("mkv" . "mpv")
        ("mp4" . "mpv")
        ("avi" . "mpv")
        ("wmv" . "mpv")
        ("playlist" . "mpv --playlist")
        ("exe" . "wine")
        ))

(require 'dired-subtree)

;;; iを置き換え
(define-key dired-mode-map (kbd "j") 'dired-subtree-insert)
;;; org-modeのようにTABで折り畳む
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-remove)
;;; C-x n nでsubtreeにナローイング
(define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)


;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
(defun dired-subtree-up-dwim (&optional arg)
  "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)
