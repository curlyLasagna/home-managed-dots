;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq! user-full-name "Luis Dale Gascon"
       user-mail-address "luis.gcodes@gmail.com")
(setq! doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
       doom-variable-pitch-font (font-spec :family "SF Mono" :size 15)
       doom-symbol-font (font-spec :family "Hack Nerd Font")
       doom-big-font (font-spec :family "CommitMono" :size 25)
       line-spacing 0.10)

(setq! doom-theme 'doom-rouge)

;; vscode bindings lmao
(map! :map +popup-mode-map
      :g "s-j" #'+popup/toggle)

(after! treemacs
  (setq! treemacs-position 'right))

(after! denote
  (setq! denote-directory (expand-file-name "~/Documents/notes/"))
  (setq! denote-known-keywords '("meeting" "info" "person" "task" "idea" "thought"))
  (setq! denote-file-type 'markdown-yaml)
  (add-hook! 'dired-mode-hook #'denote-dired-mode)
  (map! :leader :desc "denote"
        :n "d n" #'denote-open-or-create
        :n "d j" #'denote-journal-new-or-existing-entry
        :n "d l" #'denote-link-or-create
        )
  )

(after! doom-ui
  (whitespace-mode -1)
  (delete-selection-mode +1)
  (global-subword-mode +1)
  (repeat-mode 1)
  (global-goto-address-mode +1)
  (menu-bar-mode -1)
  (setq! truncate-string-ellipsis "…")
  (setq! display-line-numbers-type 'relative)
  (setq! confirm-kill-emacs nil)
  (setq! frame-title-format "Not Emacs")
  ;; Aesthetic
  ;; Draggable window divider by increasing width
  (setq! window-divider-default-right-width 3)
  (setq! window-divider-default-bottom-width 0)
  (map!
   :desc "Disable mouse scroll to modify text size"
   "<C-wheel-up>" nil
   "<C-wheel-down>" nil)
  )

(when (modulep! :ui doom-dashboard)
  (setq! +doom-dashboard-menu-sections
         '(
           ("Recently opened files"
            :icon (nerd-icons-faicon "nf-fa-file_text" :face 'doom-dashboard-menu-title)
            :action recentf-open-files)
           ("Reload last session"
            :icon (nerd-icons-octicon "nf-oct-history" :face 'doom-dashboard-menu-title)
            :when (cond ((modulep! :ui workspaces) (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                        ((require 'desktop nil t) (file-exists-p (desktop-full-file-name))))
            :action doom/quickload-session)
           ("Open org-agenda"
            :icon (nerd-icons-octicon "nf-oct-calendar" :face 'doom-dashboard-menu-title)
            :when (fboundp 'org-agenda) :action org-agenda)
           ("Open project"
            :icon (nerd-icons-octicon "nf-oct-briefcase" :face 'doom-dashboard-menu-title)
            :action projectile-switch-project)
           )
         )
  (setq! fancy-splash-image (concat doom-user-dir "img/bond.png"))
  )

(after! writeroom-mode
  (setq! writeroom-mode-line nil
         +zen-text-scale 1.10
         writeroom-width 0.3)
  ;; No line numbers
  (add-hook! 'writeroom-mode-enable-hook #'(lambda () (display-line-numbers-mode -1)))
  (add-hook! 'writeroom-mode-disable-hook #'(lambda () (display-line-numbers-mode 1)))
  ;; Disable writeroom from applying mixed-pitch text
  (remove-hook 'writeroom-mode-hook #'+zen-enable-mixed-pitch-mode-h)
  )


(after! corfu
  (setq! corfu-preview-current t)
  (setq! corfu-preselect 'prompt)
  (setq! corfu-auto-delay 0.1)
  )

(after! org
  (setq! +org-capture-notes-file "inbox.org")
  (setq! org-image-max-width 0.5)
  (setq! org-directory "~/Documents/org")
  (when (modulep! :lang org +dragndrop)
    (setq! org-download-image-dir (concat org-directory "/attachments")
           ))
  (map!
   :map org-mode-map
   :desc "Insert org heading" "C-s-<return>" #'org-insert-heading)
  (setq! org-refile-allow-creating-parent-nodes 'confirm)
  )

(after! dired
  (setq! dired-kill-when-opening-new-dired-buffer t))

(after! which-key
  (setq! which-key-idle-delay 0.8))

(after! tex
  (setq! +latex-viewers '(skim pdf-tools)))

(after! markdown-mode
  (map!
   :map markdown-mode-map
   :desc "Next cell" "<tab>" #'markdown-table-forward-cell
   :desc "Previous cell" "S-<tab>" #'markdown-table-backward-cell)
  )

(after! vertico
  (map!
   :map vertico-map
   :desc "Scroll up" "C-v" #'scroll-up-command
   :desc "Scroll down" "M-v" #'scroll-down-command
   ))

(after! modus-themes
  (setq! modus-themes-fringes nil))

(when (featurep :system 'macos)
  (setq! ns-use-proxy-icon 'nil)
  (setq! mac-right-option-modifier 'meta))

(when (modulep! :editor word-wrap)
  (+global-word-wrap-mode 1))

(after! lsp-ui
  (setq! lsp-ui-doc-enable nil)
  (setq! lsp-ui-doc-delay 0.2)
  (setq! lsp-ui-doc-show-with-cursor nil)
  (setq! lsp-ui-doc-position 'top)
  (setq! lsp-ui-doc-max-width 120)
  )

(after! web-mode
  (setq! web-mode-code-indent-offset 4)
  (setq! web-mode-markup-indent-offset 2)
  (add-hook 'web-mode-hook #'web-mode-toggle-current-element-highlight)
  )

(after! markdown-mode
  (setq! markdown-unordered-list-item-prefix "  - ")
  )

(use-package! doom-modeline
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 1)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-vcs-max-length 12)
  (doom-modeline-buffer-file-name-style 'file-name-with-project)
  )
