;; テーマの設定
;; (require 'powerline)

;; (defun powerline-my-theme ()
;;   "Setup the my mode-line."
;;   (interactive)
;;   (setq powerline-current-separator 'utf-8)
;;   (setq-default mode-line-format
;;                 '("%e"
;;                   (:eval
;;                    (let* ((active (powerline-selected-window-active))
;;                           (mode-line (if active 'mode-line 'mode-line-inactive))
;;                           (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
;;                           (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
;;                           (separator-left (intern (format "powerline-%s-%s"
;;                                                           (powerline-current-separator)
;;                                                           (car powerline-default-separator-dir))))
;;                           (lhs (list (powerline-raw " " face1)
;;                                      (powerline-major-mode face1)
;;                                      (powerline-raw " " face1)
;;                                      (funcall separator-left face1 face2)
;;                                      (powerline-buffer-id nil )
;;                                      (powerline-raw " [ ")
;;                                      (powerline-raw mode-line-mule-info nil)
;;                                      (powerline-raw "%*")
;;                                      (powerline-raw " |")
;;                                      (powerline-process nil)
;;                                      (powerline-vc)
;;                                      (powerline-raw " ]")
;;                                      ))
;;                           (rhs (list (powerline-raw "%4l")
;;                                      (powerline-raw ":")
;;                                      (powerline-raw "%2c")
;;                                      (powerline-raw " | ")
;;                                      (powerline-raw "%6p")
;;                                      (powerline-raw " ")
;;                                      )))
;;                      (concat (powerline-render lhs)
;;                              (powerline-fill nil (powerline-width rhs))
;;                              (powerline-render rhs)))))))

;; (defun make/set-face (face-name fg-color bg-color weight)
;;   (make-face face-name)
;;   (set-face-attribute face-name nil
;;                       :foreground fg-color :background bg-color :box nil :weight weight))
;; (make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
;; (make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
;; (make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
;; (make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

;; (powerline-my-theme)

;; --------powerlineの設定ここまで----------------


(require 'smart-mode-line)
;;; この変数を定義しておかないとエラーになるバグあり
(setq sml/active-background-color "gray60")
;;; 桁番号も表示させる
;; (column-number-mode 1)
;;; 読み込み専用バッファは%で表示
(setq sml/read-only-char "%%")
;;; 修正済みバッファは*で表示
(setq sml/modified-char "*")
;;; helm-modeとauto-complete-modeのモードライン表示を隠す
;; (setq sml/hidden-modes '(" Helm" " AC"))
;;; これがないと表示がはみでる
(setq sml/extra-filler -10)
;;; sml/replacer-regexp-listはモードラインでのファイル名表示方法を制御
(add-to-list 'sml/replacer-regexp-list '("^.+/junk/[0-9]+/" ":J:") t)
;;; これを入れないとsmart-mode-lineを読み込むたびに
;;; Loading a theme can run Lisp code.  Really load? (y or n)
;;; と聞いてくる。
(setq sml/no-confirm-load-theme t)
(sml/setup)
(sml/apply-theme 'respectful)
;;; その他のthemeを設定
;;(sml/apply-theme 'dark)
;;(sml/apply-theme 'light)


;; ------------smart-mode-lineの設定ここまで-----------


;; (defconst color1 "SteelBlue")
;; (defconst color2 "salmon")

;; (set-face-attribute 'mode-line nil
;;                     :foreground "#fff"
;;                     :background color1
;;                     :bold t
;;                     :box nil)

;; (set-face-attribute 'powerline-active1 nil
;;                     :foreground "gray23"
;;                     :background color2
;;                     :bold t
;;                     :box nil
;;                     :inherit 'mode-line)

;; (set-face-attribute 'powerline-active2 nil
;;                     :foreground "white smoke"
;;                     :background "gray20"
;;                     :bold t
;;                     :box nil
;;                     :inherit 'mode-line)

;; (set-face-attribute 'mode-line-inactive nil
;;                     :foreground "#fff"
;;                     :background color1
;;                     :bold t
;;                     :box nil)

;; (set-face-attribute 'powerline-inactive1 nil
;;                     :foreground "gray23"
;;                     :background color2
;;                     :bold t
;;                     :box nil
;;                     :inherit 'mode-line)

;; (set-face-attribute 'powerline-inactive2 nil
;;                     :foreground "white smoke"
;;                     :background "gray20"
;;                     :bold t
;;                     :box nil
;;                     :inherit 'mode-line)

;; (powerline-center-theme)

;; (defun dither-xpm (color1 color2)
;;   "Return an XPM dither string representing."
;;   (format "/* XPM */
;; static char * dither[] = {
;; \"12 18 2 1\",
;; \".	c %s\",
;; \" 	c %s\",
;; \"....... . . \",
;; \".. . . .    \",
;; \"..... . . . \",
;; \".... . .    \",
;; \"....... .   \",
;; \".. . . .    \",
;; \"..... . . . \",
;; \".. . . .    \",
;; \"....... . . \",
;; \".. . .      \",
;; \"..... . . . \",
;; \".... . .    \",
;; \"....... .   \",
;; \".. . . .    \",
;; \"..... . . . \",
;; \".. . . .    \",
;; \"....... . . \",
;; \".. . .      \"};"  color1 color2))


;; (defconst color1 "#437")
;; (defconst color2 "#326")

;; (defvar arrow-right-1 (create-image (dither-xpm color1 color2) 'xpm t :ascent 'center))
;; (defvar arrow-right-2 (create-image (dither-xpm color2 "None") 'xpm t :ascent 'center))
;; (defvar arrow-left-1  (create-image (dither-xpm color2 color1) 'xpm t :ascent 'center))
;; (defvar arrow-left-2  (create-image (dither-xpm "None" color2) 'xpm t :ascent 'center))

;; (setq-default mode-line-format
;;  (list
;;         '(:eval (concat (propertize " %b " 'face 'mode-line-color-1)
;;                         (propertize " " 'display arrow-right-1)))
;;         '(:eval (concat (propertize " %m " 'face 'mode-line-color-2)
;;                         (propertize " " 'display arrow-right-2)))
;;         minor-mode-alist

;;         ;; Justify right by filling with spaces to right fringe - 16
;;         ;; (16 should be computed rahter than hardcoded)
;;         '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))

;;         '(:eval (concat (propertize " " 'display arrow-left-2)
;;                         (propertize " %Z%* " 'face 'mode-line-color-2)))
;;         '(:eval (concat (propertize " " 'display arrow-left-1)
;;                         (propertize "%4l:%2c  " 'face 'mode-line-color-1)))
;; ))

;; (make-face 'mode-line-color-1)
;; (set-face-attribute 'mode-line-color-1 nil
;;                     :foreground "#eee"
;;                     :background color1)

;; (make-face 'mode-line-color-2)
;; (set-face-attribute 'mode-line-color-2 nil
;;                     :foreground "#eee"
;;                     :background color2)

;; (set-face-attribute 'mode-line nil
;;                     :foreground "#eee"
;;                     :background "#214"
;;                     :box nil)
;; (set-face-attribute 'mode-line-inactive nil
;;                     :foreground "#eee"
;;                     :background "#000")



;; (load-theme 'atom-one-dark t)
;; (load-theme 'material t)
;; (load-theme 'kosmos t)
;; (load-theme 'dracula t)

;; (require 'doom-modeline)
;; (doom-modeline-mode 1)


(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

;; save時にmode line を光らせる
(add-hook 'after-save-hook
      (lambda ()
        (let ((orig-fg (face-background 'mode-line)))
          (set-face-background 'mode-line "dark green")
          (run-with-idle-timer 0.1 nil
                   (lambda (fg) (set-face-background 'mode-line fg))
                   orig-fg))))

;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; or for treemacs users
;; (doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)

;; ;; モードラインを隠す
;; (set-default 'my-mode-line-format mode-line-format)
;; (defun my-mode-line-off ()
;;   "Turn off mode line."
;;   (setq my-mode-line-format mode-line-format)
;;   (setq mode-line-format nil))
;; (defun my-toggle-mode-line ()
;;   "Toggle mode line."
;;   (interactive)
;;   (when mode-line-format
;;     (setq my-mode-line-format mode-line-format))
;;   (if mode-line-format
;;       (setq mode-line-format nil)
;;     (setq mode-line-format my-mode-line-format)
;;     (redraw-display))
;;   (message "%s" (if mode-line-format "( ╹ ◡╹)ｂ ON !" "( ╹ ^╹)ｐ OFF!")))
;; (add-hook 'find-file-hook #'my-mode-line-off)


;; カレントバッファ以外を暗くする
;; (when (require 'dimmer nil t)
;;   (setq dimmer-fraction 0.6)
;;   (setq dimmer-exclusion-regexp "^\\*helm\\|^ \\*Minibuf\\|^\\*Calendar")
;;   (dimmer-mode 1))
;; (with-eval-after-load "dimmer"
;;   (defun dimmer-off ()
;;     (dimmer-mode -1)
;;     (dimmer-process-all))
;;   (defun dimmer-on ()
;;     (dimmer-mode 1)
;;     (dimmer-process-all))
;;   (add-hook 'focus-out-hook #'dimmer-off)
;;   (add-hook 'focus-in-hook #'dimmer-on))

;; バッファの終わりをフリンジで確認
;; (setq-default indicate-buffer-boundaries
;;               '((top . nil) (bottom . right) (down . right)))
;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
