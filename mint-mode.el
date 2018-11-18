;;; mint-mode.el --- major mode for editing .mint files. -*- coding: utf-8; lexical-binding: t; -*-

;; Author: Diwank Tomer ( singh@diwank.name )
;; Version: 0.4.1
;; Homepage: https://github.com/creatorrr/emacs-mint-mode
;; URL: https://github.com/creatorrr/emacs-mint-mode
;; Created: 18 Nov 2018
;; Keywords: mint languages processes convenience tools files
;; Package-Requires: ((jsx-mode "0.1.10"))

;;; License:

;; mint-mode.el --- major mode for editing .mint files.
;; Copyright (C) 2018 Diwank Tomer <github.com/creatorrr>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; Major mode for writing programs in mint lang. Provides:
;; - Syntax highlighting
;; - Auto format on save using `mint format`
;;
;; For more info on mint, visit: https://mint-lang.com

;;; Code:
(eval-when-compile
  (require 'jsx-mode)
  (require 'seq)
  (require 'subr-x))

;; Utils
(defun string-not-empty-p (str)
  "Return t if STR is not empty."
  (not (string-empty-p str)))

(defun get-tokens (filename)
  "Get tokens defined from data file FILENAME."

  (let* ((script-dir (file-name-directory load-file-name))
         (filepath (expand-file-name filename script-dir))
         (contents (with-temp-buffer
                     (insert-file-contents-literally filepath)
                     (buffer-string)) )

         (raw-tokens (split-string contents "\n"))
         (trimmed-tokens (mapcar 'string-trim raw-tokens)) )

    ;; Return list minus empty lines
    (seq-filter 'string-not-empty-p trimmed-tokens) ))

;; For highlighting language tokens
;; Simple
(defvar lang-blocks (get-tokens "./tokens/lang/blocks.txt"))
(defvar lang-declarators (get-tokens "./tokens/lang/declarators.txt"))
(defvar lang-initializers (get-tokens "./tokens/lang/initializers.txt"))
(defvar lang-keywords (get-tokens "./tokens/lang/keywords.txt"))
(defvar lang-specifiers (get-tokens "./tokens/lang/specifiers.txt"))
(defvar lang-literal-types (get-tokens "./tokens/lang/literal-types.txt"))

;; Compound
(defvar lang-compound-types (get-tokens "./tokens/lang/compound-types.txt"))
(defvar lang-operators (get-tokens "./tokens/lang/operators.txt"))

;; For highlighting html tags
(defvar html-tags (get-tokens "./tokens/html/tags.txt"))

;; For highlighting css tokens
(defvar style-colors (get-tokens "./tokens/style/colors.txt"))
(defvar style-properties (get-tokens "./tokens/style/properties.txt"))
(defvar style-units (get-tokens "./tokens/style/units.txt"))

;; Define regular expressions for syntax highlighting
(setq mint-font-lock-keywords

         ;; For simple keywords like `do`, `fun` etc.
  (let* ((regex-blocks (regexp-opt lang-blocks 'words))
         (regex-declarators (regexp-opt lang-declarators 'words))
         (regex-initializers (regexp-opt lang-initializers 'words))
         (regex-keywords (regexp-opt lang-keywords 'words))
         (regex-specifiers (regexp-opt lang-specifiers 'words))
         (regex-literal-types (regexp-opt lang-literal-types 'words))

         ;; For compound type constructors like `Maybe(Number)`
         (regex-compound-type-constructors
          (mapconcat (lambda (type)
                       (concat (regexp-quote type) "[[:space:]]*" "("))

                     lang-compound-types
                     "\\|") )


         ;; For compound type classes like `Maybe.just`
         (regex-compound-type-classes
          (mapconcat (lambda (type)
                       (concat (regexp-quote type) "\\."))

                     lang-compound-types
                     "\\|") )

         ;; For operators like `=>`
         (regex-operators
          (mapconcat (lambda (type)
                       (concat "[[:space:]]+" (regexp-quote type) "[[:space:]]*"))

                     lang-operators
                     "\\|") )

         ;; For html tag-open (no style applied)
         (regex-html-tag-open
          (mapconcat (lambda (type)
                       (concat "<" "[[:space:]]*" (regexp-quote type) "[[:space:]]*" ">"))
                     html-tags
                     "\\|") )

         (regex-html-tag-open-with-attr
          (mapconcat (lambda (type)
                       (concat "<" "[[:space:]]*" (regexp-quote type) "[[:space:]]+" "[a-zA-Z\\-]+" "[[:space:]]*" "="))
                     html-tags
                     "\\|") )

         ;; For html tag-open (style applied)
         (regex-html-tag-open-with-style
          (mapconcat (lambda (type)
                       (concat "<" "[[:space:]]*" (regexp-quote type) "[[:space:]]*" "::"))
                     html-tags
                     "\\|") )

         ;; For html tag-close
         (regex-html-tag-close
          (mapconcat (lambda (type)
                       (concat "<" "/" "[[:space:]]*" (regexp-quote type) "[[:space:]]*" ">"))
                     html-tags
                     "\\|") )

         ;; ;; For style colors
         (regex-style-colors (regexp-opt style-colors 'words))

         ;; For style property names
         (regex-style-properties
          (mapconcat (lambda (type)
                       (concat (regexp-quote type) "[[:space:]]*" ":"))

                     style-properties
                     "\\|") )

         ;; For style units
         (regex-style-units
          (mapconcat (lambda (type)
                       (concat "[[:digit:]]+" "[[:space:]]*" (regexp-quote type)))

                     style-units
                     "\\|") )

         ;; Other misc categories
         (regex-inline-marker "`"))

    ;; Set font-lock mode face for each category
    `((,regex-blocks . font-lock-constant-face)
      (,regex-declarators . font-lock-constant-face)
      (,regex-initializers . font-lock-type-face)
      (,regex-keywords . font-lock-warning-face)
      (,regex-specifiers . font-lock-builtin-face)
      (,regex-literal-types . font-lock-variable-name-face)

      (,regex-compound-type-constructors . font-lock-type-face)
      (,regex-compound-type-classes . font-lock-string-face)
      (,regex-operators . font-lock-variable-name-face)

      (,regex-html-tag-open . font-lock-variable-name-face)
      (,regex-html-tag-open-with-attr . font-lock-variable-name-face)
      (,regex-html-tag-open-with-style . font-lock-variable-name-face)
      (,regex-html-tag-close . font-lock-variable-name-face)

      (,regex-style-colors . font-lock-constant-face)
      (,regex-style-properties . font-lock-variable-name-face)
      (,regex-style-units . font-lock-builtin-face)

      (,regex-inline-marker . font-lock-warning-face) )))

;; Function for reformatting .mint source files
(defun mint-format-file ()
  "Formats current file using `mint format`."

  (let* ((file buffer-file-name)
         (error-file (make-temp-file "mint-format-errors-file"))
         (command (concat "mint format " file " > " error-file))

         ;; Error container
         (error-buffer (get-buffer-create "*prettier errors*"))

         ;; Revert options
         (ignore-auto t)
         (noconfirm t)
         (preserve-modes t)

         ;; Run command in process
         (result (call-process-shell-command command nil nil nil)) )

    ;; Check command result
    (if (zerop result)

      ;; Update formatted file and destroy error-buffer
      (progn
        (kill-buffer error-buffer)
        (revert-buffer ignore-auto noconfirm preserve-modes))

      ;; Show errors
      (progn
        (with-current-buffer error-buffer
          (setq buffer-read-only nil)
          (erase-buffer)
          (insert-file-contents error-file t nil nil)
          (ansi-color-apply-on-region (point-min) (point-max))
          (compilation-mode))

        (display-buffer error-buffer)) )

    ;; Remove temporary error file
    (delete-file error-file) ))

;;;###autoload
(define-derived-mode mint-mode jsx-mode "mint mode"
  "Major mode for writing programs in mint lang."

  ;; hook for formatting on save
  (add-hook 'mint-mode-hook (lambda () (add-hook 'after-save-hook #'mint-format-file nil 'local)))

  ;; For correctly formatting ansi terminal color codes
  (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
  (add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)

  ;; code for syntax highlighting
  (setq font-lock-defaults '((mint-font-lock-keywords))))


;; add the mode to the `features' list
(provide 'mint-mode)

;;; mint-mode.el ends here
