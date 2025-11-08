;;; app-launcher-for-windows.el --- Launch applications from Emacs -*- lexical-binding: t -*-

;; Author: Sebastien Waegeneire
;; Created: 2024
;; License:
;; Version: 0.1
;; Package-Requires: ((emacs "27.1"))
;; Homepage: https://github.com/sebastienwae/app-launcher

;; This file is not part of GNU Emacs.

;;; Commentary:

;;; Acknowledgements:


(defcustom app-launcher-apps-directories
  '("c:/ProgramData/Microsoft/Windows/Start Menu/Programs/")
  "Directories in which to search for applications (.desktop files)."
  :type '(repeat directory))

(defcustom app-launcher--action-function #'app-launcher--action-function-default
  "Define the function that is used to run the selected application."
  :type 'function)

(defun makeFilePathTuple (path)
  (let ((file-name (file-name-sans-extension
                    (file-name-nondirectory path))))
    (cons file-name path)))

(defun findLnkFiles (dir)
  (when (file-exists-p dir)
    (directory-files-recursively dir ".*\\.lnk$")))

(defun flatten (list)
  "Flatten a nested list."
  (if (null list)
      nil
    (if (listp (car list))
        (append (flatten (car list)) (flatten (cdr list)))
      (cons (car list) (flatten (cdr list))))))

(defun app-launcher-list-desktop-files ()
  (mapcar 'makeFilePathTuple
          (flatten
           (mapcar 'findLnkFiles app-launcher-apps-directories))))

(defun app-launcher-list-apps ()
    (mapcar 'car (app-launcher-list-desktop-files)))

(defun app-launcher--action-function-default (selected)
  (let ((result (cdr (assoc selected (app-launcher-list-desktop-files)))))
  (if result
      (call-process-shell-command result)
    (progn
      (message "Nothing")
      nil)))
  )

;;;###autoload
(defun app-launcher-run-app ()
  (interactive)
  (let* ((candidates (app-launcher-list-apps))
	     (result (completing-read
		          "Run app: "
                  candidates
                  )))
    (funcall app-launcher--action-function result)))

;; Provide the app-launcher feature
(provide 'app-launcher-for-windows)
