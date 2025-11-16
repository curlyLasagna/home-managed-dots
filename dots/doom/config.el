;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq! user-full-name "Luis Dale Gascon"
       user-mail-address "luis.gcodes@gmail.com")

(setq! doom-font (font-spec :family "ZedMono Nerd Font" :size 15)
       doom-variable-pitch-font (font-spec :family "JuliaMono" :size 15)
       doom-symbol-font (font-spec :family "Hack Nerd Font")
       doom-big-font (font-spec :family "CommitMono" :size 25)
       line-spacing 0.10)

(after! treemacs
  (setq! treemacs-position 'right))

(after! denote
  (setq! denote-directory (expand-file-name "~/Documents/de_notes/")))

(use-package! typst-ts-mode
  :mode ("\\.typ\\'" . typst-ts-mode)
  )

(whitespace-mode -1)
(delete-selection-mode +1)
(global-subword-mode +1)
(repeat-mode 1)
(global-goto-address-mode +1)
(setq! ns-use-native-fullscreen t)
(setq! doom-theme 'doom-opera-light)
(setq! tab-width 4)
(setq! truncate-string-ellipsis "…")
(setq! display-line-numbers-type 'relative)
(setq! confirm-kill-emacs nil)
(setq! frame-title-format "Notepad for the top 1\%% male")
;; Draggable window divider by increasing width
(setq! window-divider-default-right-width 3)
(setq! window-divider-default-bottom-width 0)

(map!
 :desc "Disable mouse scroll to modify text size"
 "<C-wheel-up>" nil
 "<C-wheel-down>" nil)

(after! consult
  (map!
   :leader
   :desc "Kill ring history"
   "s c" #'consult-yank-from-kill-ring)
  )

(after! gptel)


(after! writeroom-mode
  (setq! writeroom-mode-line nil
         +zen-text-scale 1.10
         writeroom-width 0.3)
  ;; No line numbers in zen
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
  (setq! org-image-max-width 0.5)
  (setq org-directory (expand-file-name "~/Documents/de_notes/"))
  (setq! org-agenda-files (list org-directory))
  (when (modulep! :lang org +dragndrop)
    (setq! org-download-image-dir (concat org-directory "/attachments"))
    )
  (map!
   :map org-mode-map
   :desc "Insert org heading" "C-s-<return>" #'org-insert-heading)
  (setq! org-refile-allow-creating-parent-nodes 'confirm)
  )

(after! dired
  (setq! dired-kill-when-opening-new-dired-buffer t))

(after! flycheck
  (flycheck-popup-tip-mode nil))

(after! which-key
  (setq! which-key-idle-delay 0.8))

(after! tex
  (setq! +latex-viewers '(skim pdf-tools)))

(after! markdown-mode
  (map!
   :map markdown-mode-map
   :desc "Next table cell" "<tab>" #'markdown-table-forward-cell
   :desc "Previous table cell" "S-<tab>" #'markdown-table-backward-cell)
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

;; TODO: Add a keybind for lsp-ui-imenu
(after! lsp-ui
  (setq! lsp-ui-doc-enable nil)
  (setq! lsp-ui-doc-delay 0.2)
  (setq! lsp-ui-doc-show-with-cursor nil)
  (setq! lsp-ui-doc-position 'top)
  (setq! lsp-ui-doc-max-width 120)
  (setq! lsp-ui-sideline-show-diagnostics nil)
  (setq! lsp-ui-imenu-window-fix-width t)
  (setq! lsp-ui-imenu-window-width 20)
  (setq! lsp-ui-sideline-show-diagnostics nil)
  )

(after! web-mode
  (setq! web-mode-code-indent-offset 4)
  (setq! web-mode-markup-indent-offset 2)
  (add-hook 'web-mode-hook #'web-mode-toggle-current-element-highlight)
  )

(after! markdown-mode
  (setq! markdown-unordered-list-item-prefix "  - ")
  )

(after! gptel
  (setq gptel-model 'gpt-4.1
        gptel-backend (gptel-make-gh-copilot "Copilot"))
  )


;; TODO: Customize a minimal modeline that only shows the major mode and lsp server running. Git metrics would be cool too
(setq! mode-line-format '("%e" mode-line-front-space
                          (:propertize
                           ("" mode-line-mule-info
                            mode-line-client
                            mode-line-modified
                            mode-line-remote
                            mode-line-window-dedicated)
                           display (min-width (6.0)))
                          mode-line-frame-identification
                          mode-line-buffer-identification "   "
                          mode-line-position
                          (project-mode-line project-mode-line-format)
                          (vc-mode vc-mode) "  "
                          ;; mode-line-modes
                          mode-name
                          ;; mode-line-misc-info
                          mode-line-end-spaces
                          )
       )

;; Disable suspend frame keymap
(map! "C-z" nil)
