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
      '(("mkv" . "mplayer -fixed-vo")
        ("mp4" . "mplayer -fixed-vo")
        ("avi" . "mplayer -fixed-vo")
        ("list" . "mplayer -fixed-vo")
        ("exe" . "wine")
        ))
