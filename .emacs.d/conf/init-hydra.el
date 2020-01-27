;;; 30_dired.el --- 30_dired.el
;;; Commentary:
;;; Code:
;; (setq debug-on-error t)

;; Dired files deleted by trash and no ask recursive
(setq delete-by-moving-to-trash t
      dired-recursive-copies 'always
      dired-recursive-deletes 'always)

(with-eval-after-load 'dired
  (bind-key "RET" 'dired-open-in-accordance-with-situation dired-mode-map)
  (bind-key "e" 'wdired-change-to-wdired-mode dired-mode-map)
  (bind-key "o" 'dired-view-file-other-window dired-mode-map)
  (bind-key "[" 'dired-hide-details-mode dired-mode-map)
  (bind-key "a" 'dired-list-all-mode dired-mode-map)
  (bind-key "q" 'dired-dwim-quit-window dired-mode-map)
  (bind-key "W" 'dired-get-fullpath-filename dired-mode-map)    ;; w:file name only
  (bind-key "z" 'dired-zip-files dired-mode-map)    ;; Create an archive containing the marked files
  (bind-key "<left>" 'dired-up-alternate-directory dired-mode-map)
  (bind-key "<right>" 'dired-open-in-accordance-with-situation dired-mode-map)
  (bind-key "C-x C-j" 'dired-jump))


;; direx
(setq direx:leaf-icon "  " direx:open-icon "▾ " direx:closed-icon "▸ ")
(push '(direx:direx-mode :position left :width 30 :dedicated t)
      popwin:special-display-config)

(bind-key [f11] 'direx:jump-to-project-directory)
(defun direx:jump-to-project-directory ()
  "If in project, launch direx-project otherwise start direx."
  (interactive)
  (let ((result (ignore-errors
                  (direx-project:jump-to-project-root-other-window)
                  t)))
    (unless result
      (direx:jump-to-directory-other-window))))


;; When dired opened in two windows, move or copy in the other dired
(setq dired-dwim-target t)


;; Recursively copy directory
(setq dired-recursive-copies 'always)


;; Dired with directory first
(use-package ls-lisp)
(setq ls-lisp-use-insert-directory-program nil ls-lisp-dirs-first t)


;; Add [Dir] to the directory buffer
(defun dired-my-append-buffer-name-hint ()
  "Append a auxiliary string to a name of dired buffer."
  (when (eq major-mode 'dired-mode)
    (let* ((dir (expand-file-name list-buffers-directory))
           ;; Add a drive letter for Windows
           (drive (if (and (eq 'system-type 'windows-nt)
                           (string-match "^\\([a-zA-Z]:\\)/" dir))
                      (match-string 1 dir) "")))
      (rename-buffer (concat (buffer-name) " [" drive "dir]") t))))
(add-hook 'dired-mode-hook 'dired-my-append-buffer-name-hint)


;; Toggle listing dot files in dired
;; https://github.com/10sr/emacs-lisp/blob/master/docs/elpa/dired-list-all-mode-20161115.118.el
(when (require 'dired-list-all-mode nil t)
   (setq dired-listing-switches "-lhFG"))


;; Quit-window according to screen division
(defun dired-dwim-quit-window ()
  "`quit-window 'according to screen division."
  (interactive)
  (quit-window (not (delq (selected-window) (get-buffer-window-list)))))


;; Get fullpath-filename with W (for file name only w)
(defun dired-get-fullpath-filename ()
  "Copy file name (full path) of cursor position."
  (interactive)
  (kill-new (dired-get-filename))
  (message (dired-get-filename)))


;; File are opened in separate buffer, directories are opened in same buffer
;; http://nishikawasasaki.hatenablog.com/entry/20120222/1329932699
(defun dired-open-in-accordance-with-situation ()
  "Files are opened in separate buffers, directories are opened in the same buffer."
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))


;; View-file-other-window
;; http://y0m0r.hateblo.jp/entry/20120219/1329657774
(defun dired-view-file-other-window ()
  "View-file other window."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (file-directory-p file)
    (or (and (cdr dired-subdir-alist)
         (dired-goto-subdir file))
        (dired file))
      (view-file-other-window file))))


;; Move to higher directory without make new buffer
(defun dired-up-alternate-directory ()
   "Move to higher directory without make new buffer."
   (interactive)
   (let* ((dir (dired-current-directory))
          (up (file-name-directory (directory-file-name dir))))
     (or (dired-goto-file (directory-file-name dir))
         ;; Only try dired-goto-subdir if buffer has more than one dir.
         (and (cdr dired-subdir-alist)
              (dired-goto-subdir up))
         (progn
           (find-alternate-file up)
           (dired-goto-file dir)))))


;; Automatic deletion for empty files (Valid in all modes)
;; https://uwabami.github.io/cc-env/Emacs.html#org57f6557
(defun my:delete-file-if-no-contents ()
  "Automatic deletion for empty files."
  (when (and (buffer-file-name (current-buffer))
             (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))
(if (not (memq 'my:delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'my:delete-file-if-no-contents after-save-hook)))


;; Hide .DS_Store when dotfiles listed
(when (eq system-type 'darwin)
(use-package dired-x)
(setq dired-omit-mode t)
(setq-default dired-omit-files-p t)
(setq dired-omit-files "^\\.DS_Store\\|^\\.dropbox"))


;; zip file can be expanded with Z key
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))


;; Create an archive containing the marked files
;; https://stackoverflow.com/questions/1431351/how-do-i-uncompress-unzip-within-emacs
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")
  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command
     (concat "zip "
             zip-file
             " "
             (concat-string-list
              (mapcar
               #'(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))
  (revert-buffer))
(defun concat-string-list (list)
   "Return a string which is a concatenation of all elements of the list separated by spaces"
   (mapconcat '(lambda (obj) (format "%s" obj)) list " "))


;; hydra-dired
(define-key dired-mode-map
  "."
  (defhydra hydra-dired (:hint nil :color pink)
    "
_+_ mkdir   _v_iew         _m_ark         _z_ip     _w_ get filename    _r_oot-dir   _T_erminal
_C_opy      view _o_ther   _U_nmark all   un_Z_ip   _W_ get fullpath    _h_ome-dir   _F_inder
_D_elete    open _f_ile    _u_nmark       _s_ort    _g_ revert buffer   _b_ook-dir   counsel-_T_ramp
_R_ename    ch_M_od        _t_oggle       _e_dit    _[_ hide detail     _d_ropbox   _._togggle hydra
"
  ("[" dired-hide-details-mode)
  ("+" dired-create-directory)
  ("RET" dired-open-in-accordance-with-situation :exit t)
  ("f" dired-open-in-accordance-with-situation :exit t)
  ("C" dired-do-copy)   ;; Copy all marked files
  ("D" dired-do-delete)
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("o" dired-view-file-other-window :exit t)
  ("?" dired-summary :exit t)
  ("R" dired-do-rename)
  ("a" dired-list-all-mode)
  ("g" revert-buffe)
  ("e" wdired-change-to-wdired-mode :exit t)
  ("s" dired-sort-toggle-or-edit)
  ("T" counsel-tramp :exit t)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file :exit t)
  ("w" dired-copy-filename-as-kill)
  ("W" dired-get-fullpath-filename)
  ("z" dired-zip-files)
  ("Z" dired-do-compress)
  ("b" my:book-dir)
  ("r" my:root-dir)
  ("h" my:home-dir)
  ("d" my:dropbox)
  ("F" my:finder-app)
  ("T" my:iterm-app)
  ("q" nil)
  ("." nil :color blue)))

(defun my:root-dir ()
  "Open root dir."
  (interactive)
  (find-file "/"))
(defun my:home-dir ()
  "Open home dir."
  (interactive)
  (find-file "~/"))
(defun my:dropbox ()
  "Open home dir."
  (interactive)
  (find-file "~/Dropbox"))
(defun my:book-dir ()
  "Open book dir."
  (interactive)
  (find-file "~/Dropbox/book/"))
(defun my:finder-app ()
  "Launch for finder.app with current dir."
  (interactive)
  (shell-command "open ."))
(defun my:iterm-app ()
  "Open iterm.app with current dir."
  (interactive)
  (let ((dir default-directory))
    (shell-command (concat "open -a iterm.app " dir))))

;; Local Variables:
;; byte-compile-warnings: (not free-vars callargs)
;; End:
;;; 30_dired.el ends here

;; for org-mode
(defhydra hydra-global-org (:color blue
                            :hint nil)
  "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _w_ clock in    _c_apture
 _s_top        _o_ clock out   _l_ast capture
_r_eset        _j_ clock goto
_p_rint
"
  ("t" org-timer-start)
  ("s" org-timer-stop)
  ;; Need to be at timer
  ("r" org-timer-set-timer)
  ;; Print timer value to buffer
  ("p" org-timer)
  ("w" (org-clock-in '(4)))
  ("o" org-clock-out)
  ;; Visit the clocked task from any buffer
  ("j" org-clock-goto)
  ("c" org-capture)
  ("l" org-capture-goto-last-stored))


;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local)
;; End:
