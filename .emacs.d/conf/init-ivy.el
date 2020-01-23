;;; init-ivy.el -- setting for ivy/counsel
;;; Commentary:
;;; Code:


(when (require 'ivy nil t)

  ;; M-o を ivy-hydra-read-action に割り当てる．
  (when (require 'ivy-hydra nil t)
    (setq ivy-read-action-function #'ivy-hydra-read-action))

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
  (setq ivy-truncate-lines nil)

  ;; keybinding
  (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
  (define-key ivy-minibuffer-map (kbd "C-m") 'ivy-alt-done)

  (define-key ivy-minibuffer-map (kbd "C-i") 'ivy-immediate-done)
  ;; リスト先頭で `C-p' するとき，リストの最後に移動する
  (setq ivy-wrap t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 15)
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))

  (dired-recent-mode 1)
  (when (require 'ivy-dired-history nil t)
    (define-key dired-mode-map "," 'dired)
    (with-eval-after-load "session"
      (add-to-list 'session-globals-include 'ivy-dired-history-variable))
    (define-key ivy-dired-history-map (kbd "C-m") 'ivy-alt-done))


  ;; アクティベート
  (ivy-mode 1))

(defvar recentf-max-saved-items 2000)
(defvar recentf-auto-cleanup 'never)
(defvar recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(recentf-mode 1)

(when (require 'counsel nil t)

  ;; keybinding
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  (global-set-key (kbd "C-c h") 'counsel-recentf)
  (global-set-key (kbd "C-c i") 'imenus)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-M-f") 'counsel-ag)
  (counsel-mode 1)

  (when (eq system-type 'darwin)
   (global-set-key (kbd "s-d") 'counsel-osx-app)
   (with-eval-after-load "counsel-osx-app"
     (custom-set-variables
      '(counsel-osx-app-location
        '("/Applications"
          "/Applications/Downloads"
          "/Applications/Flip4Mac"
          "/Applications/GoogleJapaneseInput.localized"
          ;; "/Applications/Igor Pro 6.1 Folder"
          "/Applications/Igor Pro 6.3 Folder"
          "/Applications/iWork '09"
          "/Applications/Microsoft Office 2011"
          "/Applications/Python 2.7"
          "/Applications/RIETAN_VENUS"
          "/Applications/Utilities"))))))

(when (require 'swiper nil t)
  (global-set-key (kbd "C-c C-;") 'swiper)
  ;; line-numberでも検索可能
  (defvar swiper-include-line-number-in-search t))

;;; init-ivy.el ends here
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
