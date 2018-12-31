;; 日本語設定
;; 文字コードセット
;; (prefer-coding-system 'utf-8)
(set-language-environment 'japanese)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; splash screen を無効化
(setq inhibit-splash-screen t)

;; 同じ内容を履歴に記録しない
(setq history-delete-duplicates t)

;; 複数のディレクトリで同じファイル名のファイルを開いたときのバッファ名を調整する
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffer-re "[^*]+")

;; ファイルの開いた位置を保持する
;; (require 'saveplace)
;; (setq-dafault save-place t)
;; (setq save-place-file (concat user-emacs-directory "places")

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-delay 0.125)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; cooding set
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; バックアップファイ及び、自動セーブの無効
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;; メニューバー、ツールバー、スクロールバーの非表示
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; フォント
;; (set-default-font "SourceHanCodeJP R")
;; (set-frame-font "Ricty" 15)
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 150)

;; モードラインに関する設定
;; (size-indication-mode t)
;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (display-time-mode t)

;; 列番号表示
(column-number-mode t)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; 起動時に*scratch*バッファを表示する
(setq initial-buffer-choice t)

;; beep音を消す
(setq ring-bell-function 'ignore)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)
;; ウィンドウ内に収まらないときだけ格好内も光らせる
;; (setq show-paren-style 'mixed)
;; カーソルの点滅をやめる
(blink-cursor-mode 0)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)
;; 保存時に行末のスペースを削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; 開き括弧を挿入すると自動で閉じ括弧を挿入
(setq electric-pair-mode t)
;; auto-fill-modeを切る
(auto-fill-mode 0)

;; yes or noをy,nにする
(fset 'yes-or-no-p 'y-or-n-p)