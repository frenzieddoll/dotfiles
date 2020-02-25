;;; init-company.el --- setting for company

;; Copyright (C) 2019 by Toshiaki HONDA

;; Author: Toshiaki HONDA <frenzieddoll@gmail.com>
;; URL:
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

;; (provide 'init-company)
(require 'company)
(global-company-mode) ; 全バッファで有効にする
;; 手動補完
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
;; デフォルトは0.5,nil:手動補完
(setq company-idle-delay 0.01)
;; デフォルトは4
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(defvar company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
;; (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key company-active-map (kbd "C-h") nil) ;; バックスペースを取り


;; (set-face-attribute 'company-tooltip nil                  ; ポップアップ全体
;;   :foreground "black" :background "ivory1")
;; (set-face-attribute 'company-tooltip-common nil           ; 入力中の文字列と一致する部分
;;   :foreground "black" :background "ivory1")
;; (set-face-attribute 'company-tooltip-selection nil        ; 選択項目の全体
;;   :foreground "ivory1" :background "DodgerBlue4")
;; (set-face-attribute 'company-tooltip-common-selection nil ; 選択項目のうち入力中の文字列と一致する部分
;;   :foreground "ivory1" :background "DodgerBlue4")
;; (set-face-attribute 'company-preview-common nil           ; 候補が1つしかなくて自動で入力される場合
;;   :background "black" :foreground "yellow" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil             ; ポップアップのスクロールバー
;;   :background "Midnight Blue")
;; (set-face-attribute 'company-scrollbar-bg nil             ; ポップアップのスクロールバー
;;                     :background "ivory1")

;; yasnippetとの連携
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;;; init-company.el ends here
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
