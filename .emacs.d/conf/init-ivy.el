;;; init-ivy.el -- setting for ivy/counsel
;;; Commentary:
;;; Code:

(require 'ivy)
;; デフォルトの入力補完がivyになる
(ivy-mode 1)
;; M-x, C-x C-fなどのEmacsの基本的な組み込みコマンドをivy版にリマップする

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 30)
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

;; define function
(defun bjm/ivy-dired-recent-dirs ()
  "Present a list of recently used directories and open the selected one in dired"
  (interactive)
  (let ((recent-dirs
         (delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))))

    (let ((dir (ivy-read "Directory: "
                         recent-dirs
                         :re-builder #'ivy--regex
                         :sort nil
                         :initial-input nil)))
      (dired dir))))

(global-set-key (kbd "C-x C-d") 'bjm/ivy-dired-recent-dirs)

;; counsel設定
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
(global-set-key (kbd "C-c h") 'counsel-recentf)
(define-key ivy-minibuffer-map (kbd "C-m") 'ivy-alt-done)
(define-key ivy-minibuffer-map (kbd "C-i") 'ivy-immediate-done)
(global-set-key (kbd "C-c i") 'imenus)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-;") 'swiper)
(defvar swiper-include-line-number-in-search t) ;; line-numberでも検索可能
(global-set-key (kbd "C-x C-d") 'bjm/ivy-dired-recent-dirs)


;; ;; migemo + swiper（日本語をローマ字検索できるようになる）
;; (require 'avy-migemo)
;; (avy-migemo-mode 1)
;; (require 'avy-migemo-e.g.swiper)


;; ;;; 下記は任意で有効化
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;; ;; これらは counsel-mode で自動で設定されるため、明示的に設定しなくてよい
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-load-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

(defun yank-browse (string)
      "Browse the `kill-ring' to choose which entry to yank."
      (interactive
       (minibuffer-with-setup-hook #'minibuffer-completion-help
         (let* ((kills (delete-dups (append kill-ring-yank-pointer kill-ring nil)))
                (entries
                 (mapcar (lambda (string)
                           (let ((pos 0))
                             ;; FIXME: Maybe we should start by removing
                             ;; all properties.
                             (setq string (copy-sequence string))
                             (while (string-match "\n" string pos)
                               ;; FIXME: Maybe completion--insert-strings should
                               ;; do that for us.
                               (put-text-property
                                (match-beginning 0) (match-end 0)
                                'display (eval-when-compile
                                           (propertize "\\n" 'face 'escape-glyph))
                                string)
                               (setq pos (match-end 0)))
                             ;; FIXME: We may use the window-width of the
                             ;; wrong window.
                             (when (>= (* 3 (string-width string))
                                       (* 2 (window-width)))
                               (let ((half (- (/ (window-width) 3) 1)))
                                 ;; FIXME: We're using char-counts rather than
                                 ;; width-count.
                                 (put-text-property
                                  half (- (length string) half)
                                  'display (eval-when-compile
                                             (propertize "……" 'face 'escape-glyph))
                                  string)))
                             string))
                         kills))
                (table (lambda (string pred action)
                         (cond
                          ((eq action 'metadata)
                           '(metadata (category . kill-ring)))
                          (t
                           (complete-with-action action entries string pred))))))
           ;; FIXME: We should return the entry from the kill-ring rather than
           ;; the entry from the completion-table.
           ;; FIXME: substring completion doesn't work well because it only matches
           ;; subtrings before the first \n.
           ;; FIXME: completion--insert-strings assumes that boundaries of
           ;; candidates are obvious enough, but with kill-ring entries this is not
           ;; true, so we'd probably want to display them with «...» around them.
           (list (completing-read "Yank: " table nil t)))))
      (setq this-command 'yank)
      (insert-for-yank string))


;; (global-set-key (kbd "M-y") 'yank-browse)


;;; init-ivy.el ends here
