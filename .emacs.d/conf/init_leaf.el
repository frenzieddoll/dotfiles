(prog1 "prepare leaf"
  (prog1 "package"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize))

  (prog1 "leaf"
    (unless (package-installed-p 'leaf)
      (unless (assoc 'leaf package-archive-contents)
        (package-refresh-contents))
      (condition-case err
          (package-install 'leaf)
        (error
         (package-refresh-contents)       ; renew local melpa cache if fail
         (package-install 'leaf))))

    (leaf leaf-keywords
      :ensure t
      :config (leaf-keywords-init)))

  (prog1 "optional packages for leaf-keywords"
    ;; optional packages if you want to use :hydra, :el-get,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t
      :custom ((el-get-git-shallow-clone  . t)))))

(leaf *dired-tools
  :config

  (leaf dired-filter
    :ensure t
    :bind ((dired-mode-map
            ("/" . dired-filter-map))))

  (leaf wdired
    :ensure t
    :custom ((wdired-allow-to-change-permissions . t))
    :bind (dired-mode-map ("e" . wdired-change-to-wdired-mode)))

  (leaf dired
    :ensure t
    :custom ((dired-dwim-target . t)
             (dired-launch-mailcap-frend . '("env" "xdg-open"))
             (dired-launch-enable . t)
             (dired-recursive-copies . 'always)
             (dired-isearch-filenames . t)
             (dired-listing-switches . (purecopy "-alht"))))

  (leaf peep-dired
     :ensure t
     :bind (dired-mode-map
            ("P" . peep-dired)))

  (leaf async
    :ensure t
    :custom ((dired-async-mode . 1)
             (async-bytecomp-package-mode . 1)
             (async-bytecomp-allowed-packages . '(all))))

  (leaf dired-open
    :ensure t
    :when (eq system-type 'gnu/linux)
    :custom ((dired-open-extensions '(("mkv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mp4"  . "~/projects/dotfilesotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("avi"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("wmv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("webm" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mpg"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("flv"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("m4v"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mp3"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("wav"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("m4a"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("3gp"  . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("rm"   . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("rmvb" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("mpeg" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("VOB" . "~/projects/dotfiles/.emacs.d/script/mpv-rifle.sh")
                                      ("iso" . "mpv dvd:// -dvd-device")
                                      ("playlist" . "mpv --playlist")
                                      ("exe"  . "wine")
                                      ("pdf"  . "YACReader")
                                      ("zip"  . "YACReader")
                                      ("rar"  . "YACReader")
                                      ("tar"  . "YACReader")
                                      ("xls"  . "xdg-open")
                                      ("xlsx" . "xdg-open")
                                      ("jpg"  . "sxiv-rifle")
                                      ("png"  . "sxiv-rifle")
                                      ("jpeg" . "sxiv-rifle")
                                      ("gif"  . "sxiv-rifle")
                                      ("png"  . "sxiv-rifle")))))
  (leaf dired-open-extensions
    :ensure t
    :when (eq system-type 'darwin)
    :custom ((dired-open-extensions '(("key" . "open")
                                      ("docx" . "open")
                                      ("pdf" . "open")
                                      ("cmdf" . "open")
                                      ("xlsx" . "open")
                                      ("pxp" . "open")
                                      ("bmp" . "open")
                                      ))))

  (leaf dired-subtree
    :ensure t
    :bind ((dired-mode-map
            ("<right>" . dired-subtree-insert)
            ("<left>" . dired-subtree-remove)
            ("C-x n n" . dired-subtree-narrow))))
