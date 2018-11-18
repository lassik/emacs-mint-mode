;;; mint-mode.el --- major mode for editing .mint files.
;; -*- coding: utf-8; lexical-binding: t; -*-

;; Author: Diwank Tomer ( singh@diwank.name )
;; Version: 0.3.1
;; Homepage: https://github.com/creatorrr/emacs-mint-mode
;; URL: https://github.com/creatorrr/emacs-mint-mode
;; Created: 14 Nov 2018
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
  (require 'jsx-mode))

;; For highlighting css property names
(setq x-mint-style-props
    '("align-content" "align-content" "align-items" "align-items" "align-self" "align-self" "alignment-baseline" "all" "all" "animation" "animation-delay" "animation-direction" "animation-duration" "animation-fill-mode" "animation-iteration-count" "animation-name" "animation-play-state" "animation-timing-function" "appearance" "azimuth" "background" "background" "background-attachment" "background-attachment" "background-blend-mode" "background-clip" "background-color" "background-color" "background-image" "background-image" "background-origin" "background-position" "background-position" "background-repeat" "background-repeat" "background-size" "baseline-shift" "block-overflow" "block-size" "block-step" "block-step-align" "block-step-insert" "block-step-round" "block-step-size" "bookmark-label" "bookmark-label" "bookmark-level" "bookmark-level" "bookmark-state" "bookmark-state" "border" "border" "border-block" "border-block-color" "border-block-end" "border-block-end-color" "border-block-end-style" "border-block-end-width" "border-block-start" "border-block-start-color" "border-block-start-style" "border-block-start-width" "border-block-style" "border-block-width" "border-bottom" "border-bottom" "border-bottom-color" "border-bottom-color" "border-bottom-left-radius" "border-bottom-right-radius" "border-bottom-style" "border-bottom-style" "border-bottom-width" "border-bottom-width" "border-boundary" "border-collapse" "border-collapse" "border-color" "border-color" "border-end-end-radius" "border-end-start-radius" "border-image" "border-image-outset" "border-image-repeat" "border-image-slice" "border-image-source" "border-image-width" "border-inline" "border-inline-color" "border-inline-end" "border-inline-end-color" "border-inline-end-style" "border-inline-end-width" "border-inline-start" "border-inline-start-color" "border-inline-start-style" "border-inline-start-width" "border-inline-style" "border-inline-width" "border-left" "border-left" "border-left-color" "border-left-color" "border-left-style" "border-left-style" "border-left-width" "border-left-width" "border-radius" "border-right" "border-right" "border-right-color" "border-right-color" "border-right-style" "border-right-style" "border-right-width" "border-right-width" "border-spacing" "border-spacing" "border-start-end-radius" "border-start-start-radius" "border-style" "border-style" "border-top" "border-top" "border-top-color" "border-top-color" "border-top-left-radius" "border-top-right-radius" "border-top-style" "border-top-style" "border-top-width" "border-top-width" "border-width" "border-width" "bottom" "bottom" "box-decoration-break" "box-shadow" "box-sizing" "box-sizing" "box-sizing" "box-snap" "break-after" "break-after" "break-before" "break-before" "break-inside" "break-inside" "caption-side" "caption-side" "caret" "caret-color" "caret-color" "caret-shape" "chains" "clear" "clear" "clip" "clip" "clip-path" "clip-rule" "color" "color" "color" "color" "color-adjust" "color-interpolation-filters" "column-count" "column-fill" "column-gap" "column-gap" "column-rule" "column-rule-color" "column-rule-style" "column-rule-width" "column-span" "column-width" "columns" "contain" "content" "content" "continue" "continue" "counter-increment" "counter-increment" "counter-reset" "counter-reset" "counter-set" "cue" "cue" "cue-after" "cue-after" "cue-before" "cue-before" "cursor" "cursor" "cursor" "direction" "direction" "direction" "display" "display" "display" "dominant-baseline" "elevation" "empty-cells" "empty-cells" "fill" "fill-break" "fill-color" "fill-image" "fill-opacity" "fill-origin" "fill-position" "fill-repeat" "fill-rule" "fill-size" "filter" "flex" "flex-basis" "flex-direction" "flex-flow" "flex-grow" "flex-shrink" "flex-wrap" "float" "float" "float-defer" "float-offset" "float-reference" "flood-color" "flood-opacity" "flow" "flow-from" "flow-into" "font" "font" "font" "font-family" "font-family" "font-family" "font-feature-settings" "font-kerning" "font-language-override" "font-max-size" "font-min-size" "font-optical-sizing" "font-palette" "font-size" "font-size" "font-size" "font-size-adjust" "font-size-adjust" "font-stretch" "font-stretch" "font-style" "font-style" "font-style" "font-synthesis" "font-synthesis" "font-synthesis-small-caps" "font-synthesis-style" "font-synthesis-weight" "font-variant" "font-variant" "font-variant-alternates" "font-variant-caps" "font-variant-east-asian" "font-variant-emoji" "font-variant-ligatures" "font-variant-numeric" "font-variant-position" "font-variation-settings" "font-weight" "font-weight" "font-weight" "footnote-display" "footnote-policy" "gap" "glyph-orientation-vertical" "glyph-orientation-vertical" "grid" "grid" "grid-area" "grid-auto-columns" "grid-auto-flow" "grid-auto-rows" "grid-column" "grid-column-end" "grid-column-start" "grid-row" "grid-row-end" "grid-row-start" "grid-template" "grid-template" "grid-template-areas" "grid-template-areas" "grid-template-columns" "grid-template-columns" "grid-template-rows" "grid-template-rows" "hanging-punctuation" "height" "height" "hyphenate-character" "hyphenate-limit-chars" "hyphenate-limit-last" "hyphenate-limit-lines" "hyphenate-limit-zone" "hyphens" "image-orientation" "image-resolution" "image-resolution" "initial-letters" "initial-letters-align" "initial-letters-wrap" "inline-size" "inline-sizing" "inset" "inset-block" "inset-block-end" "inset-block-start" "inset-inline" "inset-inline-end" "inset-inline-start" "isolation" "justify-content" "justify-content" "justify-items" "justify-self" "left" "left" "letter-spacing" "letter-spacing" "lighting-color" "line-break" "line-clamp" "line-grid" "line-height" "line-height-step" "line-padding" "line-snap" "list-style" "list-style" "list-style-image" "list-style-image" "list-style-position" "list-style-position" "list-style-type" "list-style-type" "margin" "margin" "margin-block" "margin-block-end" "margin-block-start" "margin-bottom" "margin-bottom" "margin-inline" "margin-inline-end" "margin-inline-start" "margin-left" "margin-left" "margin-right" "margin-right" "margin-top" "margin-top" "marker" "marker-end" "marker-knockout-left" "marker-knockout-right" "marker-mid" "marker-pattern" "marker-segment" "marker-side" "marker-start" "mask" "mask-border" "mask-border-mode" "mask-border-outset" "mask-border-repeat" "mask-border-slice" "mask-border-source" "mask-border-width" "mask-clip" "mask-composite" "mask-image" "mask-mode" "mask-origin" "mask-position" "mask-repeat" "mask-size" "mask-type" "max-block-size" "max-height" "max-height" "max-inline-size" "max-lines" "max-lines" "max-width" "max-width" "min-block-size" "min-height" "min-height" "min-inline-size" "min-width" "min-width" "mix-blend-mode" "nav-down" "nav-left" "nav-right" "nav-up" "object-fit" "object-position" "offset" "offset-after" "offset-anchor" "offset-before" "offset-distance" "offset-end" "offset-path" "offset-position" "offset-rotate" "offset-start" "opacity" "opacity" "opacity" "order" "orphans" "orphans" "outline" "outline" "outline" "outline-color" "outline-color" "outline-color" "outline-offset" "outline-offset" "outline-style" "outline-style" "outline-style" "outline-width" "outline-width" "outline-width" "overflow" "overflow" "overflow-block" "overflow-inline" "overflow-wrap" "overflow-x" "overflow-y" "padding" "padding" "padding-block" "padding-block-end" "padding-block-start" "padding-bottom" "padding-bottom" "padding-inline" "padding-inline-end" "padding-inline-start" "padding-left" "padding-left" "padding-right" "padding-right" "padding-top" "padding-top" "page" "page-break-after" "page-break-before" "page-break-inside" "pause" "pause" "pause-after" "pause-after" "pause-before" "pause-before" "pitch" "pitch-range" "place-content" "place-items" "place-self" "play-during" "position" "position" "presentation-level" "quotes" "quotes" "region-fragment" "resize" "resize" "rest" "rest-after" "rest-before" "richness" "right" "right" "row-gap" "ruby-align" "ruby-merge" "ruby-position" "running" "scroll-behavior" "scroll-margin" "scroll-margin-block" "scroll-margin-block-end" "scroll-margin-block-start" "scroll-margin-bottom" "scroll-margin-inline" "scroll-margin-inline-end" "scroll-margin-inline-start" "scroll-margin-left" "scroll-margin-right" "scroll-margin-top" "scroll-padding" "scroll-padding-block" "scroll-padding-block-end" "scroll-padding-block-start" "scroll-padding-bottom" "scroll-padding-inline" "scroll-padding-inline-end" "scroll-padding-inline-start" "scroll-padding-left" "scroll-padding-right" "scroll-padding-top" "scroll-snap-align" "scroll-snap-stop" "scroll-snap-type" "scrollbar-color" "scrollbar-gutter" "scrollbar-width" "shape-image-threshold" "shape-inside" "shape-margin" "shape-outside" "speak" "speak" "speak-as" "speak-header" "speak-numeral" "speak-punctuation" "speech-rate" "stress" "string-set" "string-set" "stroke" "stroke" "stroke-align" "stroke-alignment" "stroke-break" "stroke-color" "stroke-dash-corner" "stroke-dash-justify" "stroke-dashadjust" "stroke-dasharray" "stroke-dasharray" "stroke-dashcorner" "stroke-dashoffset" "stroke-dashoffset" "stroke-image" "stroke-linecap" "stroke-linecap" "stroke-linejoin" "stroke-linejoin" "stroke-miterlimit" "stroke-miterlimit" "stroke-opacity" "stroke-opacity" "stroke-origin" "stroke-position" "stroke-repeat" "stroke-size" "stroke-width" "stroke-width" "tab-size" "table-layout" "table-layout" "text-align" "text-align" "text-align-all" "text-align-last" "text-combine-upright" "text-combine-upright" "text-decoration" "text-decoration" "text-decoration-color" "text-decoration-line" "text-decoration-skip" "text-decoration-skip-ink" "text-decoration-style" "text-decoration-width" "text-emphasis" "text-emphasis-color" "text-emphasis-position" "text-emphasis-skip" "text-emphasis-style" "text-group-align" "text-indent" "text-indent" "text-justify" "text-orientation" "text-orientation" "text-overflow" "text-overflow" "text-overflow" "text-shadow" "text-space-collapse" "text-space-trim" "text-spacing" "text-transform" "text-transform" "text-underline-offset" "text-underline-position" "text-wrap" "top" "top" "transform" "transform-box" "transform-origin" "transition" "transition-delay" "transition-duration" "transition-property" "transition-timing-function" "unicode-bidi" "unicode-bidi" "unicode-bidi" "user-select" "vertical-align" "vertical-align" "visibility" "voice-balance" "voice-duration" "voice-family" "voice-family" "voice-pitch" "voice-range" "voice-rate" "voice-stress" "voice-volume" "volume" "white-space" "white-space" "white-space" "widows" "widows" "width" "width" "will-change" "word-break" "word-spacing" "word-spacing" "word-wrap" "wrap-after" "wrap-before" "wrap-flow" "wrap-inside" "wrap-through" "writing-mode" "writing-mode" "z-index" "z-index"))

;; Define categories for syntax highlighting
(setq mint-font-lock-keywords
  (let* ((x-operators '("<{" "}>" "::" "=>" "|>" "<|"))
         (x-declarations '("style" "enum" "component" "module" "record" "routes" "provider" "store"))
         (x-initializers '("fun" "let" "where" "next" "state" "property"))

         (x-compound-types '("Result" "Maybe" "Html" "Promise" "Void" "Never"))
         (x-literal-types '("Number" "Bool" "String" "Object" "Time" "Array"))

         (x-keywords '("decode" "encode" "return" "connect" "use"))
         (x-specifiers '("as" "break" "return" "using" "get" "exposing" "ok" "error" "just" "nothing"))
         (x-blocks '("do" "sequence" "parallel" "if" "else" "case" "try" "catch" "void"))

         ;; generate regex string for each category of keywords
         (x-operators-regexp (regexp-opt x-operators))
         (x-declarations-regexp (regexp-opt x-declarations 'words))
         (x-initializers-regexp (regexp-opt x-initializers 'words))

         (x-compound-types-regexp (regexp-opt x-compound-types 'words))
         (x-literal-types-regexp (regexp-opt x-literal-types 'words))

         (x-keywords-regexp (regexp-opt x-keywords 'words))
         (x-specifiers-regexp (regexp-opt x-specifiers 'words))
         (x-blocks-regexp (regexp-opt x-blocks 'words))

         ;; Other misc categories
         (x-inline-marker-regexp "`")
         (x-style-prop-regexp (regexp-opt x-mint-style-props 'words)) )

    ;; Set font-lock mode face for each category
    `((,x-operators-regexp . font-lock-variable-name-face)
      (,x-declarations-regexp . font-lock-constant-face)
      (,x-initializers-regexp . font-lock-type-face)

      (,x-compound-types-regexp . font-lock-string-face)
      (,x-literal-types-regexp . font-lock-variable-name-face)

      (,x-keywords-regexp . font-lock-warning-face)
      (,x-specifiers-regexp . font-lock-builtin-face)
      (,x-blocks-regexp . font-lock-constant-face)

      (,x-inline-marker-regexp . font-lock-warning-face)
      (,x-style-prop-regexp . font-lock-variable-name-face) )))

;; Reformat function
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

(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)

;;;###autoload
(define-derived-mode mint-mode jsx-mode "mint mode"
  "Major mode for writing programs in mint lang."

  ;; hook for formatting on save
  (add-hook 'mint-mode-hook (lambda () (add-hook 'after-save-hook #'mint-format-file nil 'local)))

  ;; code for syntax highlighting
  (setq font-lock-defaults '((mint-font-lock-keywords))))


;; add the mode to the `features' list
(provide 'mint-mode)

;;; mint-mode.el ends here
