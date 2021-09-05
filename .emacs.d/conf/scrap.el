(leaf *minor-mode
  :disabled t
  :config
  (leaf skk
    :ensure ddskk
    ;; :defun (skk-get)
    :require t skk-study
    :defvar skk-user-directory
    :defun skk-toggle-kana skk-hiragana-set skk-katakana-set
    :hook ((isearch-mode-hook . skk-isearch-mode-setup)
           (isearch-mode-end-hook . skk-isearch-mode-cleanup))
    :bind (("C-x j" . skk-mode)
           ("C-j" . nil)
           ("C-j" . skk-hiragana-set)
           ("C-l" . skk-latin-mode)
           (minibuffer-local-map
            ("C-j" . skk-kakutei)
            ("C-l" . skk-latin-mode)))
    :custom `((skk-user-directory . "~/.emacs.d/ddskk")
              (skk-initial-search-jisyo . "~/.emacs.d/ddskk/jisyo")
              (skk-large-jisyo . "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L")
              (skk-egg-like-newline . t)
              (skk-delete-implies-kakutei . t)
              (skk-henkan-strict-okuri-precedence . t)
              (skk-isearch-start-mode . 'latin)
              (skk-search-katakana . t))
    :preface
    (defun skk-hiragana-set nil
      (interactive)
      (cond (skk-katakana
             (skk-toggle-kana nil))
            (t
             (skk-kakutei))))
    (defun skk-katakana-set nil
      (interactive)
      (cond (skk-katakana
             (lambda))
            (skk-j-mode
             (skk-toggle-kana nil))
            (skk-latin-mode
             (dolist (skk-kakutei (skk-toggle-kana nil))))))
    )

  (leaf cua
    :bind (("C-x SPC" . cua-set-rectangle-mark))
    :custom ((cua-mode . t)
             (cua-enable-cua-keys . nil)))

  (leaf company
    :ensure t
    :leaf-defer nil
    :diminish company-mode
    :bind ((company-active-map
            ("M-n" . nil)
            ("M-p" . nil)
            ("C-s" . company-filter-candidates)
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)
            ("<tab>" . company-complete-selection)
            ("C-h" . nil)
            ("C-f" . company-complete-selection)
            )
           (company-search-map
            ("C-n" . company-select-next)
            ("C-p" . company-select-previous)))
    :custom `((company-tooltip-limit         . 12)
              (company-idle-delay            . 0)
              (company-minimum-prefix-length . 3)
              (company-transformers          . '(company-sort-by-occurrence))
              (global-company-mode           . t)
              (company-dabbrev-downcase      . nil)
              (company-backends . '(company-capf))
              )
    :config
    (leaf company-math
      :ensure t
      :disabled t
      :unless (eq system-type 'dawin)
      :defvar (company-backends)
      :preface
      (defun c/latex-mode-setup ()
        (setq-local company-backends
                    (append '((company-math-symbols-latex
                               company-math-symbols-unicode
                               company-latex-commands))
                            company-backends)))
      :hook ((org-mode-hook . c/latex-mode-setup)
             (tex-mode-hook . c/latex-mode-setup)
             (yatex-mode-hook . c/latex-mode-setup))
      )

    (leaf company-quickhelp
      :disabled t
      :when (display-graphic-p)
      :ensure t
      :custom ((company-quickhelp-delay . 0.8)
               (company-quickhelp-mode  . t))
      :bind (company-active-map
             ("M-h" . company-quickhelp-manual-begin))
      :hook ((company-mode-hook . company-quickhelp-mode))
      )

    (leaf *companyFor
      :disabled t
      :when (eq system-type 'gnu/linux)
      :config
      (leaf company-tabnine
        :doc "M-x company-tabnine-install-binary to install binary"
        :disabled t
        :ensure t
        :config
        (add-to-list 'company-backends #'company-tabnine))

      (leaf company-prescient
        :ensure t
        :custom ((company-prescient-mode . t)))

      (leaf company-c-headers
        :ensure t
        :config (add-to-list 'company-backends 'company-c-headers))

      (leaf company-box
        :url "https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-company.el"
        :when (version<= "26.1" emacs-version)
        ;; :disabled (eq window-system 'x)
        :disabled t
        :ensure t
        :diminish company-box-mode
        :defvar (company-box-icons-alist company-box-icons-all-the-icons)
        :init (leaf all-the-icons :ensure t :require t)
        :custom ((company-box-max-candidates . 50)
                 (company-box-icons-alist    . 'company-box-icons-all-the-icons))
        :hook ((company-mode-hook . company-box-mode))
        :config
        (when (memq window-system '(ns mac))
          (declare-function all-the-icons-faicon 'all-the-icons)
          (declare-function all-the-icons-material 'all-the-icons)
          (declare-function all-the-icons-octicon 'all-the-icons)
          (setq company-box-icons-all-the-icons
                `((Unknown       . ,(all-the-icons-material "find_in_page" :height 0.9 :v-adjust -0.2))
                  (Text          . ,(all-the-icons-faicon "text-width" :height 0.85 :v-adjust -0.05))
                  (Method        . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
                  (Function      . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
                  (Constructor   . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-purple))
                  (Field         . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
                  (Variable      . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
                  (Class         . ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
                  (Interface     . ,(all-the-icons-material "share" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
                  (Module        . ,(all-the-icons-material "view_module" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
                  (Property      . ,(all-the-icons-faicon "wrench" :height 0.85 :v-adjust -0.05))
                  (Unit          . ,(all-the-icons-material "settings_system_daydream" :height 0.9 :v-adjust -0.2))
                  (Value         . ,(all-the-icons-material "format_align_right" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
                  (Enum          . ,(all-the-icons-material "storage" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
                  (Keyword       . ,(all-the-icons-material "filter_center_focus" :height 0.9 :v-adjust -0.2))
                  (Snippet       . ,(all-the-icons-material "format_align_center" :height 0.9 :v-adjust -0.2))
                  (Color         . ,(all-the-icons-material "palette" :height 0.9 :v-adjust -0.2))
                  (File          . ,(all-the-icons-faicon "file-o" :height 0.9 :v-adjust -0.05))
                  (Reference     . ,(all-the-icons-material "collections_bookmark" :height 0.9 :v-adjust -0.2))
                  (Folder        . ,(all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05))
                  (EnumMember    . ,(all-the-icons-material "format_align_right" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-lblue))
                  (Constant      . ,(all-the-icons-faicon "square-o" :height 0.9 :v-adjust -0.05))
                  (Struct        . ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.2 :face 'all-the-icons-orange))
                  (Event         . ,(all-the-icons-faicon "bolt" :height 0.85 :v-adjust -0.05 :face 'all-the-icons-orange))
                  (Operator      . ,(all-the-icons-material "control_point" :height 0.9 :v-adjust -0.2))
                  (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.85 :v-adjust -0.05))
                  (Template      . ,(all-the-icons-material "format_align_center" :height 0.9 :v-adjust -0.2))))
          (setq company-box-icons-alist 'company-box-icons-all-the-icons)))
      )
    )

  (leaf ivy
    :req "emacs-24.5"
    :ensure t
    :leaf-defer nil
    ;; :disabled t
    :custom `((ivy-re-builders-alist        . '((t . ivy--regex-plus)))
              (ivy-use-selectable-prompt    . t)
              (ivy-mode                     . t)
              (counsel-mode                 . t)
              (dired-recent-mode            . t)
              (ivy-use-virtual-buffers      . t)
              (ivy-truncate-lines           . nil)
              (ivy-wrap                     . t)
              (enable-recursive-minibuffers . t)
              (ivy-height                   . 15)
              (ivy-extra-directories        . nil)
              (ivy-format-functions-alist   . '((t . ivy-format-function-arrow)))
              )

    :bind (("C-x b" . ivy-switch-buffer)
           (ivy-minibuffer-map
            ;; ESC連打でミニバッファを閉じる
            ("<escape>" . minibuffer-keyboard-quit)
            ("C-m"      . ivy-alt-done)
            ("C-i"      . ivy-immediate-done)))
    :init
    (leaf counsel
      :doc "Various completion functions using Ivy"
      :req "emacs-24.5" "swiper-0.13.0"
      :tag "tools" "matching" "convenience" "emacs>=24.5"
      :url "https://github.com/abo-abo/swiper"
      :emacs>= 24.5
      :ensure t
      :ensure smex
      ;; :ensure t
      :defvar counsel-find-file-ignore-regexp
      :custom ((counsel-mode                    . 1)
               (counsel-find-file-ignore-regexp . (regexp-opt '("./" "../")))
               (recentf-max-saved-items         . 2000)
               (recentf-auto-cleanup            . 'never)
               (recentf-exclude                 . '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/" "/Geheimnis"))
               (recentf-mode                    . 1)
               (counsel-yank-pop-separator      . "\n-------\n")
               )

      :bind
      (("M-x"     . counsel-M-x)
       ("C-x C-f" . counsel-find-file)
       ("C-c h"   . counsel-recentf)
       ("C-c i"   . counsel-imenu)
       ("M-y"     . counsel-yank-pop)
       ("C-x C-b" . counsel-ibuffer)
       ;; ("C-M-f" . counsel-ag)
       )
      :config

      (leaf counsel-osx-app
        ;; :ensure t
        :when (eq system-type 'darwin)
        :bind ("s-d" . counsel-osx-app)
        :custom
        ((counsel-osx-app-location.
          '("/Applications"
            "/Applications/Downloads"
            "/Applications/Flip4Mac"
            "/Applications/GoogleJapaneseInput.localized"
            ;; "/Applications/Igor Pro 6.1 Folder"
            "/Applications/Igor Pro 6.3 Folder"
            "/Applications/iWork '09"
            "/Applications/Microsoft Office 2011"
            "/Applications/Python 2.7"
            "/Applications/RIETAN_VENUS"
            "/Applications/Utilities")))
        )
      (leaf *pi
        ;; :ensure t
        :disabled t
        :when (string-match "raspberrypi" (system-name))
        :preface
        (defun app-launch (command)
          (interactive (list (read-shell-command "$ ")))
          (start-process-shell-command command nil command))

        :bind ("s-d" . app-launch)
        )

      )

    (leaf swiper
      :ensure t
      :when (string-match "archlinuxhonda" (system-name))
      :defvar swiper-include-line-number-in-search
      :bind (("C-s" . swiper)
             ("C-r" . swiper)
             (swiper-map
              ("C-j" . skk-hiragana-set)
              ("C-l" . skk-latin-mode))
             )
      :custom (swiper-include-line-number-in-search . t))

    :config
    (leaf ivy-hidra
      :ensure t
      :disabled t
      :custom (ivy-read-action-function . #'ivy-hydra-read-action)
      )

    (leaf ivy-dired-history
      ;; :disabled t
      :require t
      :ensure t
      :defvar session-globals-include
      :bind ((dired-mode-map
              ("," . dired))
             (ivy-dired-history-map
              ("C-m" . ivy-alt-done)))
      :config
      (leaf *afterLoad
        :after session
        :config (add-to-list 'session-globals-include 'ivy-dired-history-variable))
      )
    )

  (leaf *hs-minor-mode
    :hook ((emacs-lisp-mode-hook . hs-minor-mode))
    :when (string-match "archlinuxhonda" (system-name))
    :custom ((hs-minor-mode . t))
    :bind (("C-'" . hs-toggle-hiding))
    )

  (leaf highlight-indent-guides
    :when (eq system-type 'gnu/linux)
    :when (string-match "archlinuxhonda" (system-name))
    :ensure t
    :hook ((prog-mode-hook . highlight-indent-guides-mode))
    :custom '((highlight-indent-guides-method . 'column)
              ;; (highlight-indent-guides-auto-enable . t)
              ;; (highlight-indent-guides-responsive . t)
              ;; (highlight-indent-guides-mode . t)
              )
    )

  (leaf visual-regexp-steroids
    :ensure t
    :require t
    :bind (("M-%" . vr/query-replace)
           ;; multiple-cursorsを使っているならこれで
           ("C-c m" . vr/mc-mark)
           ;; 普段の正規表現isearchにも使いたいならこれを
           ("C-M-r" . vr/isearch-backward)
           ("C-M-s" . vr/isearch-forward))
    :custom `((vr/engine . 'python))
    )

  (leaf page-ext
    ;; :disabled t
    :require t)



  (leaf smartparens
    :disabled t
    :when window-system
    :ensure t
    :require smartparens-config
    :custom ((sp-highlight-pari-overly . nil)
             (sp-navigate-interactive-always-progress-point . t)
             (smartparens-global-strict-mode . t))
    :bind ((smartparens-mode-map
            ;;;;
            ;;;; navigation

            ;; basic (fbnp-ae)
            ("C-M-f" . sp-forward-sexp)
            ("C-M-b" . sp-backward-sexp)
            ("C-M-n" . sp-next-sexp)
            ("C-M-p" . sp-previous-sexp)
            ("C-M-a" . sp-beginning-of-sexp)
            ("C-M-e" . sp-end-of-sexp)

            ;; checkin/checkout
            ("C-M-i" . sp-down-sexp)
            ("C-M-o" . sp-backward-up-sexp)

            ;; misc
            ("C-M-k"   . sp-kill-sexp)
            ("C-M-w"   . sp-copy-sexp)
            ("C-M-t"   . sp-transpose-sexp)
            ("C-M-SPC" . sp-mark-sexp)

            ;;;;
            ;;;; depth-changing commands

            ;; basic
            ("M-s"           . sp-splice-sexp)
            ("M-r"           . sp-splice-sexp-killing-around)
            ("M-<up>"        . nil)
            ("M-<down>"      . nil)
            ("C-M-u"         . sp-splice-sexp-killing-backward)
            ("C-M-d"         . sp-splice-sexp-killing-forward)
            ("M-("           . sp-wrap-round)
            ("M-["           . sp-wrap-square)
            ("M-{"           . sp-wrap-qurly)

            ;; barf/slurp
            ("C-)" . sp-forward-slurp-sexp)
            ("C-}" . sp-forward-barf-sexp)
            ("C-(" . sp-backward-slurp-sexp)
            ("C-{" . sp-backward-barf-sexp)

            ;; split/join
            ("M-S-s" . sp-split-sexp)
            ("M-j"   . sp-join-sexp)

            ;;;;
            ;;;; misc

            ;; change constructure
            ("M-?"     . sp-convolute-sexp)
            ("C-c s a" . sp-absorb-sexp)
            ("C-c s e" . sp-emit-sexp)
            ("C-c s p" . sp-convolute-sexp)
            ("C-c s t" . sp-transpose-hybrid-sexp)

            ;; change elements
            ("C-c s (" . sp-rewrap-sexp)
            ("C-c s r" . sp-change-inner)
            ("C-c s s" . sp-change-enclosing)))
    )

  (leaf sudo-edit
    :ensure t
    :require
    :custom ((sudo-edit-indicator-mode . t))
    )

  (leaf undo-tree
    :ensure t
    :when (string-match "archlinuxhonda" (system-name))
    :custom ((global-undo-tree-mode . t))
    )

  (leaf align
      :require t
      :config
      (add-to-list 'align-rules-list
                   '(yatex-table
                     (regexp . "\\( *\\)&")
                     (repeat . t)
                     (modes . '(yatex-mode))))
      (add-to-list 'align-rules-list
                   '(yatex-table
                     (regexp . "\\( *\\)\\\\\\\\")
                     (repeat . t)
                     (modes . '(yatex-mode))))
      (add-to-list 'align-rules-list
                   '(haskell-equal
                     (regexp . "\\( *\\)=\\(\\s-*\\)")
                     (repeat . t)
                     (modes . '(haskell-mode))))
      )

  )
