;;; packages.el  -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Luis Dale Gascon
;;
;; Author: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Maintainer: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Created: July 23, 2025
;; Modified: July 23, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/curlyLasagna/packages
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(package! denote :pin "24b88f1fb5682b10266fd52b213bfedb10957a99")
(when (modulep! :tools denote +journal) (package! denote-journal :pin "3fe6f003777dce3b26536cb3ecd1b96155bf2f0d"))

(provide 'packages)
;;; packages.el ends here
