(require 'visual-regexp-steroids)
;; python regexpならばこれ
(setq vr/engine 'python)
;; elispでPCREから変換
;; (setq vr/engine 'pcre2el)
(global-set-key (kbd "M-%") 'vr/query-replace)
;; multiple-cursorsを使っているならこれで
(global-set-key (kbd "C-c m") 'vr/mc-mark)
;; 普段の正規表現isearchにも使いたいならこれを
(global-set-key (kbd "C-M-r") 'vr/isearch-backward)
(global-set-key (kbd "C-M-s") 'vr/isearch-forward)
