;;; config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Luis Dale Gascon
;;
;; Author: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Maintainer: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Created: August 02, 2025
(use-package! gpt-el
  :hook
  (
   ;; Enable auto-scroll
   (gptel-post-stream . gptel-auto-scroll)
   (gptel-post-response-functions . gptel-end-of-response)
   )
  :bind(
        ("C-c g g" . gptel)
        :map gptel-mode-map
        ("C-c g m" . gptel-menu)
        )
  )
(provide 'config)
;;; config.el ends here
