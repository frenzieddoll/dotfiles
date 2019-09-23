;; setting of popwin for helm
(require 'popwin)
;; helm bufferをpopupする
(setq helm-display-function #'display-buffer)
(when (require 'popwin)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:special-display-config
    '(("*complitation*" :noselect t)
      ("helm" :regexp t :height 0.4)
      ("Backtrace" :regexp t :height 0.4)
      ("quickrun" :regexp t :height 0.4)
      )))
