;; テーマの設定
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*")
                                     (powerline-raw " |")
                                     (powerline-process nil)
                                     (powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list (powerline-raw "%4l")
                                     (powerline-raw ":")
                                     (powerline-raw "%2c")
                                     (powerline-raw " | ")
                                     (powerline-raw "%6p")
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)

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



(load-theme 'atom-one-dark t)
;; (load-theme 'material t)
;; (load-theme 'kosmos t)
;; (load-theme 'dracula t)
