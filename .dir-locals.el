;;; -*- no-byte-compile: t -*-

;;; Copyright (C) 2026 CharOfString <root@charofstring.cc>
;;;
;;; This program is free software: you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by the Free
;;; Software Foundation, either version 3 of the License, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but WITHOUT
;;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;;; FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
;;; more details.
;;;
;;; You should have received a copy of the GNU General Public License along
;;; with this program. If not, see <https://www.gnu.org/licenses/>. 
;;; ---------------------------------------------------------------------------
;;; Directory local var for GXDE Roller that helps set up Emacs.
;;; Please also refer to tools/emacs/gxde-roller-flymake.el for setting up
;;; flymake.

((nil . ((fill-column . 80)
         (indent-tabs-mode . nil)))
 (c-mode . ((c-basic-offset . 2)
            ;; Headers are C++ in this project.
            (eval . (when (and buffer-file-name
                               (string-suffix-p ".h" buffer-file-name))
                      (c++-mode)))))
 (c-ts-mode . ((eval . (when (and buffer-file-name
                                  (string-suffix-p ".h" buffer-file-name))
                         (c++-ts-mode)))))
 (c++-mode . ((c-basic-offset . 2)))
 (c-ts-base-mode . ((c-ts-mode-indent-offset . 2)))
 (prog-mode
  . (;; Flymake (eglot + clangd + clang-tidy, and cpplint) replaces Flycheck's
     ;; C/C++ checkers here.
     (flycheck-disabled-checkers
      . (c/c++-clang c/c++-gcc c/c++-cppcheck c/c++-googlelint))
     (eval
      . (when (derived-mode-p 'c++-mode 'c++-ts-mode)
          (let ((file (expand-file-name
                       "tools/emacs/gxde-roller-flymake.el"
                       (locate-dominating-file default-directory
                                               ".dir-locals.el"))))
            (when (file-readable-p file)
              (load file nil t)
              (gxde-roller-flymake-setup))))))))
