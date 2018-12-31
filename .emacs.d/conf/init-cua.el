;; cua-modeの設定
(cua-mode t)
(setq cua-enable-cua-keys nil)
(global-set-key (kbd "C-x SPC") 'cua-set-rectangle-mark)
