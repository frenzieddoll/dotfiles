;;; leaf-keywords-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords"
;;;;;;  "leaf-keywords.el" "abd23ab06d8e3f3b64cd2e6fc4949fb9")
;;; Generated autoloads from leaf-keywords.el

(autoload 'leaf-key-chord "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords" "\
Bind CHORD to COMMAND in KEYMAP (`global-map' if not passed).

CHORD must be 2 length of string
COMMAND must be an interactive function or lambda form.

KEYMAP, if present, should be a keymap and not a quoted symbol.
For example:
  (leaf-key-chord \"jk\" 'undo 'c-mode-map)

\(fn CHORD COMMAND &optional KEYMAP)" nil t)

(autoload 'leaf-key-chords "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords" "\
Bind multiple BIND for KEYMAP defined in PKG.
BIND is (KEY . COMMAND) or (KEY . nil) to unbind KEY.
This macro is minor change version form `leaf-keys'.

OPTIONAL:
  BIND also accept below form.
    (:{{map}} :package {{pkg}} (KEY . COMMAND) (KEY . COMMAND))
  KEYMAP is quoted keymap name.
  PKG is quoted package name which define KEYMAP.
  (wrap `eval-after-load' PKG)

  If DRYRUN-NAME is non-nil, return list like
  (LEAF_KEYS-FORMS (FN FN ...))

  If omit :package of BIND, fill it in LEAF_KEYS-FORM.

NOTE: BIND can also accept list of these.

\(fn BIND &optional DRYRUN-NAME)" nil t)

(autoload 'leaf-key-chords* "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords" "\
Similar to `leaf-key-chords', but overrides any mode-specific bindings for BIND.

\(fn BIND)" nil t)

(autoload 'leaf-keywords-init "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords" "\
Add additional keywords to `leaf'.
If RENEW is non-nil, renew leaf-{keywords, normalize} cache.

\(fn &optional RENEW)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords"
;;;;;;  "leaf-keywords.el" (0 0 0 0))
;;; Generated autoloads from leaf-keywords.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../projects/dotfiles/.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords" '("leaf-")))

;;;***

;;;***

;;;### (autoloads nil "leaf-keywords" "../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords.el"
;;;;;;  "abd23ab06d8e3f3b64cd2e6fc4949fb9")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords.el

(autoload 'leaf-key-chord "leaf-keywords" "\
Bind CHORD to COMMAND in KEYMAP (`global-map' if not passed).

CHORD must be 2 length of string
COMMAND must be an interactive function or lambda form.

KEYMAP, if present, should be a keymap and not a quoted symbol.
For example:
  (leaf-key-chord \"jk\" 'undo 'c-mode-map)

\(fn CHORD COMMAND &optional KEYMAP)" nil t)

(autoload 'leaf-key-chords "leaf-keywords" "\
Bind multiple BIND for KEYMAP defined in PKG.
BIND is (KEY . COMMAND) or (KEY . nil) to unbind KEY.
This macro is minor change version form `leaf-keys'.

OPTIONAL:
  BIND also accept below form.
    (:{{map}} :package {{pkg}} (KEY . COMMAND) (KEY . COMMAND))
  KEYMAP is quoted keymap name.
  PKG is quoted package name which define KEYMAP.
  (wrap `eval-after-load' PKG)

  If DRYRUN-NAME is non-nil, return list like
  (LEAF_KEYS-FORMS (FN FN ...))

  If omit :package of BIND, fill it in LEAF_KEYS-FORM.

NOTE: BIND can also accept list of these.

\(fn BIND &optional DRYRUN-NAME)" nil t)

(autoload 'leaf-key-chords* "leaf-keywords" "\
Similar to `leaf-key-chords', but overrides any mode-specific bindings for BIND.

\(fn BIND)" nil t)

(autoload 'leaf-keywords-init "leaf-keywords" "\
Add additional keywords to `leaf'.
If RENEW is non-nil, renew leaf-{keywords, normalize} cache.

\(fn &optional RENEW)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "leaf-keywords"
;;;;;;  "../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "leaf-keywords" '("leaf-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords-defaults.el"
;;;;;;  "../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/leaf-keywords-20210222.1243/leaf-keywords.el"
;;;;;;  "leaf-keywords.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; leaf-keywords-autoloads.el ends here
