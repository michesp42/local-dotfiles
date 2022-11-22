;; -*- lexical-binding: t; -*-

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(defvar mice/default-font-size 117)
(defvar mice/default-variable-font-size 140)

(defun mice/set-font-faces ()
  (message "Setting font faces...")
  (set-face-attribute 'default nil
                      :font "JetBrains Mono Nerd Font"
                      :weight 'light
                      :height mice/default-font-size)
  (set-face-attribute 'variable-pitch nil
                      :font "Iosevka Aile"
                      :weight 'light
                      :height mice/default-variable-font-size
                      :weight 'regular)
  (set-face-attribute 'fixed-pitch nil
                      :weight 'light
                      :font "JetBrains Mono Nerd Font"
                      :height mice/default-font-size)
  (set-face-attribute 'font-lock-comment-face nil
                      :slant 'italic)
  (set-face-attribute 'font-lock-keyword-face nil
                      :slant 'italic))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (mice/set-font-faces))))
  (mice/set-font-faces))

(add-to-list 'default-frame-alist '(font . "JetBrains Mono Nerd Font-12"))

(defun mice/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  ;; link to where I learned about `with-eval-after-load`: https://emacs.stackexchange.com/questions/62981/error-invalid-face-org-level-1
  (with-eval-after-load 'org-faces
    (dolist (face '((org-level-1 . 1.3)
                    (org-level-2 . 1.2)
                    (org-level-3 . 1.13)
                    (org-level-4 . 1.05)
                    (org-level-5 . 1.05)
                    (org-level-6 . 1.05)
                    (org-level-7 . 1.05)
                    (org-level-8 . 1.05)))
      (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'regular :height (cdr face)))

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    ;; WARNING: comment out if using doom-themes -> block-nil, begin-line, end-line
    ;; (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch
    ;;                  :background (color-darken-name (face-attribute 'default :background) 3))
    (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch)
                        :height mice/default-variable-font-size)
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch)
                        :height mice/default-variable-font-size)
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    ;;(set-face-attribute 'org-block-begin-line nil :inherit '(font-lock-comment-face fixed-pitch)
    ;;                  :background (color-darken-name (face-attribute 'default :background) 5))
    ;;(set-face-attribute 'org-block-end-line nil :inherit '(font-lock-comment-face fixed-pitch)
    ;;                  :background (color-darken-name (face-attribute 'default :background) 5))
    (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-document-title nil    :height 1.5)))

(defun mice/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode)
  (visual-line-mode 1))

(use-package org
  :commands (org-capture org-agenda)
  :hook
  (org-mode . mice/org-mode-setup)

  :config
  (setq org-hide-emphasis-markers t)
  (setq org-ellipsis "  ")
  (setq org-directory "~/documents/org")
  (setq org-agenda-files
        '("~/documents/org/agendas/tasks.org"
          "~/documents/org/agendas/longterm.org"
          "~/documents/org/agendas/birthdays.org"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-info-drawer t)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq header-line-format " ")		;; create blank space at the top of org file

  ;; (setq org-agenda-block-separator ""
  ;;      org-fontify-whole-heading-line t
  ;;      org-fontify-done-headline t
  ;;      org-fontify-quote-and-verse-blocks t)
  (mice/org-font-setup))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (mice/org-font-setup))))
  (mice/org-font-setup))

(use-package org-tempo
  :straight (:type built-in)
  :config
  (add-hook
   'org-mode-hook
   (lambda ()
     (setq-local electric-pair-inhibit-predicate
                 `(lambda (c)
                    (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c)))))))

(use-package org-bullets
  :custom
  (org-bullets-bullet-list '(" "))
  :hook (org-mode . org-bullets-mode))

(defun mice/org-mode-visual-fill ()
  (setq visual-fill-column-width 125
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . mice/org-mode-visual-fill))

(defun mice/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/init.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mice/org-babel-tangle-config)))

(setq-default
 delete-by-moving-to-trash t
 fill-column 80
 help-window-select t
 inhibit-startup-screen t
 initial-scratch-message ""
 mouse-yank-at-point t
 native-comp-async-report-warnings-errors 'silent
 read-process-output-max (* 1024 1024)
 recenter-positions '(5 bottom)
 scroll-conservatively 101
 scroll-margin 5
 select-enable-clipboard t
 sentence-end-double-space nil
 show-help-function nil
 tab-width 4
 uniquify-buffer-name-style 'forward
 use-short-answers t
 window-combination-resize t
 x-stretch-cursor t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(savehist-mode 1)
(set-fringe-mode 10)
(column-number-mode)
(global-display-line-numbers-mode t)
(electric-pair-mode 1)
(save-place-mode 1)
(delete-selection-mode 1)
(global-subword-mode 1)
(mouse-avoidance-mode 'exile)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(set-default-coding-systems 'utf-8)

(setq history-length 25)
(setq visible-bell t)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(setq display-line-numbers-type 'relative)
(setq global-prettify-symbols-mode t)

;; Set frame transparency
;; (defvar mice/frame-transparency '(90 . 90))
;; (set-frame-parameter (selected-frame) 'alpha mice/frame-transparency)
;; (add-to-list 'default-frame-alist `(alpha . ,mice/frame-transparency))

;; fullscreen by default
;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(dolist (mode '(org-mode-hook
                term-mode-hook
                dired-mode-hook
                shell-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; TODO
(add-hook 'prog-mode-hook #'flymake-mode)
(add-hook 'shell-mode-hook (lambda () (hl-line-mode -1)))
(add-hook 'vterm-mode-hook (lambda () (hl-line-mode -1)))

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq custom-file (no-littering-expand-etc-file-name "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  :init
  (doom-themes-visual-bell-config)
  (load-theme 'doom-nord t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t))

(use-package vterm)

(use-package vterm-toggle
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 ;;(display-buffer-reuse-window display-buffer-in-direction)
                 ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                 (direction . bottom)
                 (dedicated . t) ;dedicated is supported in emacs27
                 (reusable-frames . visible)
                 (window-height . 0.3))))

(global-set-key [C-f1] 'vterm-toggle)
(global-set-key [C-f2] 'vterm-toggle-cd)
(define-key vterm-mode-map (kbd "s-n")   'vterm-toggle-forward)
(define-key vterm-mode-map (kbd "s-p")   'vterm-toggle-backward)

(use-package dired
  :straight (:type built-in)
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package which-key
  :init
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → " )
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(use-package all-the-icons)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :config (rainbow-mode 1))

(use-package dashboard
  :init
  (setq dashboard-banner-logo-title "Welcome to never-ending configuration!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          ;; (projects . 5)
                          (agenda . 5)
                          (registers . 5)))
  :config
  (dashboard-setup-startup-hook))

;; configure initial-buffer-choice to show dashboard in frames created with emacsclient -c
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package yasnippet
  :custom
  (yas-verbosity 2)
  :config
  (yas-global-mode 1)
  (yas-reload-all)
  (setq yas-snippet-dirs '("~/.local/share/emacs/snippets")))

(use-package denote
  :config
  (setq denote-directory (expand-file-name "~/documents/org/notes"))
  (setq denote-known-keywords
        '("fun" "emacs" "physics" "engineering" "electronics" "personal"
          "programming" "math" "technology"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-file-type nil)
  (setq denote-prompts '(title keywords))

  (setq denote-allow-multi-word-keywords t)
  (setq denote-date-format nil)
  (setq denote-link-fontify-backlinks t)
  (setq denote-dired-rename-expert nil)
  (add-hook 'find-file-hook #'denote-link-buttonize-buffer)

  (setq denote-dired-directories
        (list denote-directory
              (thread-last denote-directory (expand-file-name "journal"))
              (expand-file-name "~/documents/org/notes")))
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

  (defun my-denote-journal ()
    "Create an entry tagged 'journal', while prompting for a title."
    (interactive)
    (denote
     (denote--title-prompt)
     '("journal")))

  (let ((map global-map))
    (define-key map (kbd "C-c n j") #'my-denote-journal)
    (define-key map (kbd "C-c n n") #'denote)
    (define-key map (kbd "C-c n N") #'denote-type)
    (define-key map (kbd "C-c n d") #'denote-date)
    (define-key map (kbd "C-c n s") #'denote-subdirectory)
    ;; If you intend to use Denote with a variety of file types, it is
    ;; easier to bind the link-related commands to the `global-map', as
    ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
    ;; `markdown-mode-map', and/or `text-mode-map'.
    (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
    (define-key map (kbd "C-c n I") #'denote-link-add-links)
    (define-key map (kbd "C-c n l") #'denote-link-find-file) ; "list" links
    (define-key map (kbd "C-c n b") #'denote-link-backlinks)
    ;; Note that `denote-dired-rename-file' can work from any context, not
    ;; just Dired bufffers.  That is why we bind it here to the
    ;; `global-map'.
    (define-key map (kbd "C-c n r") #'denote-dired-rename-file))

  (with-eval-after-load 'org-capture
    (require 'denote-org-capture)
    (setq denote-org-capture-specifiers "%l\n%i\n%?")
    (add-to-list 'org-capture-templates
                 '("n" "New note (with denote.el)" plain
                   (file denote-last-path)
                   #'denote-org-capture
                   :no-save t
                   :immediate-finish nil
                   :kill-buffer t
                   :jump-to-captured t))))

(use-package vertico
  :custom
  (vertico-cycle t)
  :config
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face 'vertico-current)
                   "  ")
                 cand)))
  :init
  (vertico-mode))

(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-recent-file
   consult--source-project-recent-file
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  )

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'left)
  :init
  (marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-scroll-margin 7)
  (corfu-echo-documentation nil)

  :config
  (setq completion-category-overrides '((eglot (styles orderless))))

  :bind (:map corfu-map
              ("C-n" . 'corfu-next)
              ("C-p" . 'corfu-previous)
              ("<escape>" . 'corfu-quit)
              ("<return>" . 'corfu-insert)
              ("M-d" . 'corfu-show-documentation)
              ("M-l" . 'corfu-show-location))
  :init
  (global-corfu-mode))

(use-package emacs
  :init
  (setq completion-cycle-threshold 5)
  (setq tab-always-indent 'complete))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config

  ;; `kind-icon' depends `svg-lib' which creates a cache directory that defaults to the
  ;; `user-emacs-directory'.
  ;; Change  directory to a location appropriate to `no-littering' conventions, a
  ;; package which moves directories of other packages to sane locations.
  ;; (svg-lib-icons-dir (no-littering-expand-var-file-name "svg-lib/cache/"))
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package eglot)

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)
(use-package tree-sitter-indent)

(setq c-basic-offset 2)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package csharp-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

(use-package clojure-mode
  :hook
  (clojure-mode . subword-mode))

;; (use-package sly)

(use-package go-mode
  :hook (go-mode . eglot-ensure))

;; (use-package haskell-mode)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode nil)))
(add-hook 'java-mode-hook 'eglot-ensure)

;; (use-package julia-mode
;;   :hook
;;   (julia-mode-hook . 'julia-repl-mode))

;; (use-package julia-repl
;;   :config
;;   (set-language-environment "UTF-8")
;;   (julia-repl-set-terminal-backend 'vterm))

;; (use-package auctex
;;   :defer t)

(use-package lua-mode)

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; (use-package jupyter)

;; (use-package ob
;;   :hook
;;   (org-babel-after-execute . org-redisplay-inline-images)
;;   :config (progn
;;             (org-babel-do-load-languages
;;              'org-babel-load-languages
;;              '((julia . t)
;;                (lua . t)
;;                (emacs-lisp . t)
;;                (python . t)
;;                (latex . t)
;;                (shell . t)
;;                (jupyter . t))))			; NOTE: Must be last

;;   (setq org-babel-default-header-args:sh    '((:results . "output replace"))
;;         org-babel-default-header-args:bash  '((:results . "output replace"))
;;         org-babel-default-header-args:shell '((:results . "output replace"))
;;         org-babel-default-header-args:jupyter-julia '((:async . "yes")
;;                                                       (:session . "jl")
;;                                                       (:exports . "both")
;;                                                       (:kernel . "julia"))
;;         org-babel-default-header-args:jupyter-python '((:async . "yes")
;;                                                        (:session . "py")
;;                                                        (:exports . "both")
;;                                                        (:kernel . "python3")))

;;   ;; turn off needing to confirm before evaluation
;;   (setq org-confirm-babel-evaluate nil))

;; (use-package python-mode
;;   :config
;;   (setq python-indent-offset 4)
;;   :hook
;;   (python-mode . eglot-ensure))

(use-package rust-mode
  :hook
  (rust-mode . eglot-ensure)
  :config
  (setq rust-format-on-save t))

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq prettify-symbols-alist scala-prettify-symbols-alist))

(setq sh-basic-offset 2)
(add-hook 'sh-mode-hook #'eglot-ensure)

(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode))
