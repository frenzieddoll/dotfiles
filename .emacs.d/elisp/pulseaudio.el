;;; pulseaudio.el --- hoge -*- lexical-binding: t -*-

;; Author: Toshiaki Honda <frenzieddoll@gmail.com>
;; Maintainer: Toshiaki Honda <frenzieddoll@gmail.com>
;; Version: 0.1
;; Package-Requires: (pactl)
;; Homepage: hoge
;; Keywords: hoge


;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;;; Code:

(provide 'pulseaudio)

;;; pulseaudio.el ends here

(defgroup pulseaudio nil
  "Control PulseAudio volumes via `pactl'."
  :group 'external)

(defcustom pulseaudio-pactl-path (or (executable-find "pactl")
                                             "/usr/bin/pactl")
  "Absolute path of `pactl' executable."
  :type '(file :must-match t)
  :group 'pulseaudio)

(defcustom pulseaudio-volume-step "2dB"
  "Step to use when increasing or decreasing volume.

The value can be:

* an integer percentage, e.g. '10%';
* an integer in decibels, e.g. '2dB';
* a linear factor, e.g. '0.9' or '1.1'.

Integer percentages and integer decibel values are
required by pactl 10.0."
  :type 'string
  :group 'pulseaudio)

(defun pulseaudio--call-pactl (command)
  "Call `pactl' with COMMAND as its arguments.

  COMMAND is a single string separated by spaces,
  e.g. 'list short sinks'."
  (let ((locale (getenv "LC_ALL"))
        (args `("" nil
                ,pulseaudio-pactl-path
                nil t nil
                ,@(append '("--") (split-string command " ")))))
    (setenv "LC_ALL" "C")
    (apply #'call-process-region args)
    (setenv "LC_ALL" locale)))

(defun pulseaudio--get-things-list (thing)
  (let (things-list)
    (with-temp-buffer
      (pulseaudio--call-pactl (format "list short %ss" thing))
      (goto-char (point-min))
      (while (re-search-forward (rx (group (+ num)) (+ blank) (group (+ (not blank)))) nil t)
        (setq things-list (append things-list `((,(match-string 1) . ,(match-string 2)))))))
    things-list))

(defun pulseaudio--get-default-thing (thing)
  (let (thing-name)
    (with-temp-buffer
      (pulseaudio--call-pactl "info")
      (goto-char (point-min))
      (search-forward (format "default %s: " thing))
      (setq thing-name (buffer-substring (point) (point-at-eol))))
    thing-name))

(defun pulseaudio--get-shink-list ()
  (pulseaudio--get-things-list "sink"))

(defun my/pluseaudio-control--select-thing (thing)
  (let* ((valid-things (pulseaudio--get-things-list thing))
         (thing-name (completing-read (format "%s name: " thing)
                                      (mapcar 'cdr valid-things))))
    (if (member thing-name (mapcar 'cdr valid-things))
        thing-name
    (error (format "Invalid %s name" thing-name)))))

(defun pulseaudio--select-thing-by-name (thing)
   "Select which Pulse THING to act on, by name."
    (let ((thing-name (my/pluseaudio-control--select-thing thing)))
      (pulseaudio--call-pactl (format "set-default-%s %s" thing thing-name))
      (message (format "set default %s: %s" thing thing-name))))

(defun pulseaudio--toggle-thing-mute (thing thing-name)
  "Toggle muting of currently-selected Pulse THING."
  (let (muteStatus)
     (pulseaudio--call-pactl (format "set-%s-mute %s %s" "sink" thing-name "toggle"))
     (with-temp-buffer
       (pulseaudio--call-pactl (concat (format "get-%s-mute " "sink") thing-name))
       (goto-char (point-min))
       (setq muteStatus (buffer-substring (point) (point-at-eol))))
     (message muteStatus)))

(defun pulseaudio--toggle-default-thing-mute (thing)
    (pulseaudio--toggle-thing-mute
     thing (pulseaudio--get-default-thing thing)))

(defun pulseaudio--toggle-select-thing-mute (thing)
      (pulseaudio--toggle-thing-mute
       thing (my/pluseaudio-control--select-thing thing)))

(defun pulseaudio--get-thing-number (thing thing-name)
  (car (rassoc thing-name
               (pulseaudio--get-things-list thing))))

(defun pulseaudio--get-default-thing-number (thing)
  (pulseaudio--get-thing-number
   thing
   (pulseaudio--get-default-thing thing)))

(defun pulseaudio--get-volume (thing thing-name)
  (let (volume)
    (with-temp-buffer
      (pulseaudio--call-pactl (format "get-%s-volume %s" thing thing-name))
      (goto-char (point-min))
      (setq volume (buffer-substring (point) (point-at-eol))))
    volume))

(defun pulseaudio--get-default-volume (thing)
  (pulseaudio--get-volume thing (pulseaudio--get-default-thing thing)))

(defun pulseaudio--set-volume (volume thing thing-name)
  (pulseaudio--call-pactl (format "set-%s-volume %s %s" "sink" thing-name volume))
  (princ (pulseaudio--get-volume thing thing-name)))

(defun pulseaudio--default-set-volume (volume thing)
  (pulseaudio--set-volume volume thing (pulseaudio--get-default-thing thing)))

(defun pulseaudio--indecrease-volume (sign thing thing-name)
  (pulseaudio--set-volume (concat sign pulseaudio-volume-step) thing thing-name))

(defun pulseaudio--default-deincrease-volume (sign thing)
  (pulseaudio--default-set-volume
   (concat sign pulseaudio-volume-step)
   thing))

(defun pulseaudio--default-increase-volume (thing)
  (pulseaudio--default-deincrease-volume "+" thing))

(defun pulseaudio--default-decrease-volume (thing)
  (pulseaudio--default-deincrease-volume "-" thing))

;; User-facing functions.

;;;###autoload
(defun pulseaudio-increase-sink-volume ()
  "Increase the volume of the current Pulse sink."
  (interactive)
  (pulseaudio--default-increase-volume "sink"))

;;;###autoload
(defun pulseaudio-decrease-sink-volume ()
  "Increase the volume of the current Pulse sink."
  (interactive)
  (pulseaudio--default-decrease-volume "sink"))

;;;###autoload
(defun pulseaudio-select-sink-by-name ()
  (interactive)
  (pulseaudio--select-thing-by-name "sink"))

;;;###autoload
(defun pulseaudio-set-sink-volume (volume)
  "Set volume of currently-selected Pulse sink.

The value can be:

* a percentage, e.g. '10%';
* in decibels, e.g. '2dB';
* a linear factor, e.g. '0.9' or '1.1'.

Argument VOLUME is the volume provided by the user."
  (interactive "MVolume: ")
  (pulseaudio--default-set-volume volume "sink"))

;;;###autoload
(defun pulseaudio-toggle-sink-mute ()
  "Toggle muting of currently-selected Pulse sink."
  (interactive)
  (pulseaudio--toggle-default-thing-mute "sink"))

;;;###autoload
(defun pulseaudio-get-sink-volume ()
  (interactive)
  (princ (pulseaudio--get-default-volume "sink")))

(provide 'pulseaudio)

;;; pulseaudio.el ends here
