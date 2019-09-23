;;; init-googletranslate.el -- setting for googletranslate
;;; Commentary:
;;; Code:

(require 'google-translate)
;; (defvar google-translate-english-chars "[:ascii:]’“”–"
;;   "これらの文字が含まれているときは英語とみなす")
;; (defun google-translate-enja-or-jaen (&optional string)
;;   "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
;;   (interactive)
;;   (setq string
;;         (cond ((stringp string) string)
;;               (current-prefix-arg
;;                (read-string "Google Translate: "))
;;               ((use-region-p)
;;                (buffer-substring (region-beginning) (region-end)))
;;               (t
;;                (save-excursion
;;                  (let (s)
;;                    (forward-char 1)
;;                    (backward-sentence)
;;                    (setq s (point))
;;                    (forward-sentence)
;;                    (buffer-substring s (point)))))))
;;   (let* ((asciip (string-match
;;                   (format "\\`[%s]+\\'" google-translate-english-chars)
;;                   string)))
;;     (run-at-time 0.1 nil 'deactivate-mark)
;;     (google-translate-translate
;;      (if asciip "en" "ja")
;;      (if asciip "ja" "en")
;;      string)))
;; (global-unset-key (kbd "C-o"))
;; (global-set-key (kbd "C-o") 'google-translate-enja-or-jaen)
;; (exwm-input-set-key (kbd "C-o") 'google-translate-enja-or-jaen)



(defun google-translate-enja-or-jaen (&optional string)
  "Translate words in region or current position. Can also specify query with C-u"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (thing-at-point 'word))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" "[:ascii:]’“”–")
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))


(global-unset-key (kbd "C-c C-o"))
(global-set-key (kbd "C-c C-o") 'google-translate-enja-or-jaen)
;; (exwm-input-set-key (kbd "C-o") 'google-translate-enja-or-jaen)
;; (global-set-key (kbd "C-'") 'google-translate-enja-or-jan)

;; Fix error of "Failed to search TKK"
(defun google-translate--get-b-d1 ()
    ;; TKK='427110.1469889687'
  (list 427110 1469889687))
;;; init-googletranslate.el ends here
