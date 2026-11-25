;;; -*- lexical-binding: t; no-byte-compile: t -*-

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
;;; This utility sets up Flymake for GXDE Roller.

(require 'flymake)

(defconst gxde-roller-flymake-root
  (file-name-as-directory
   (expand-file-name "../.." (file-name-directory
                              (or load-file-name buffer-file-name))))
  "Root directory of the GXDE Roller project.")

(defvar-local gxde-roller-flymake--cpplint-process nil
  "The cpplint process currently checking this buffer.")

(defconst gxde-roller-flymake--cpplint-regexp
  "^.+?:\\([0-9]+\\):  \\(.*\\)  \\[\\([^]]+\\)\\] \\[\\([0-9]\\)\\]$"
  "Regexp matching one line of cpplint's default (emacs) output.")

(defun gxde-roller-flymake--copy-cpplint-configs (relative-file temp-root)
  "Copy every CPPLINT.cfg above RELATIVE-FILE into TEMP-ROOT."
  (let ((dir "")
        (components (butlast (split-string relative-file "/"))))
    (while
        (let ((cfg (expand-file-name
                    "CPPLINT.cfg"
                    (expand-file-name dir gxde-roller-flymake-root))))
          (when (file-readable-p cfg)
            (let ((target (expand-file-name dir temp-root)))
              (make-directory target t)
              (copy-file cfg (expand-file-name "CPPLINT.cfg" target) t)))
          (when components
            (setq dir (concat dir (pop components) "/"))
            t)))))

(defun gxde-roller-flymake--cpplint-diagnostics (source output-buffer)
  "Parse cpplint output in OUTPUT-BUFFER into diagnostics for SOURCE."
  (let (diagnostics)
    (with-current-buffer output-buffer
      (goto-char (point-min))
      (while (re-search-forward gxde-roller-flymake--cpplint-regexp nil t)
        (let* ((line (max 1 (string-to-number (match-string 1))))
               (message (format "%s [%s]" (match-string 2) (match-string 3)))
               (region (flymake-diag-region source line)))
          (push (flymake-make-diagnostic source (car region) (cdr region)
                                         :warning message)
                diagnostics))))
    diagnostics))

(defun gxde-roller-flymake-cpplint (report-fn &rest _args)
  "Flymake backend running cpplint on the current buffer.
REPORT-FN is Flymake's callback."
  (unless (executable-find "cpplint")
    (error "Cannot find cpplint"))
  (when (process-live-p gxde-roller-flymake--cpplint-process)
    (kill-process gxde-roller-flymake--cpplint-process))
  (let* ((source (current-buffer))
         (relative-file (file-relative-name buffer-file-name
                                            gxde-roller-flymake-root))
         (temp-root (make-temp-file "gxde-roller-cpplint-" t))
         (copy (expand-file-name relative-file temp-root)))
    (make-directory (file-name-directory copy) t)
    (gxde-roller-flymake--copy-cpplint-configs relative-file temp-root)
    (save-restriction
      (widen)
      (let ((coding-system-for-write 'utf-8-unix))
        (write-region nil nil copy nil 'silent)))
    (setq gxde-roller-flymake--cpplint-process
          (make-process
           :name "gxde-roller-cpplint"
           :noquery t
           :connection-type 'pipe
           :buffer (generate-new-buffer " *gxde-roller-cpplint*")
           :command (list "cpplint" "--quiet"
                          (concat "--repository=" temp-root)
                          copy)
           :sentinel
           (lambda (process _event)
             (when (memq (process-status process) '(exit signal))
               (unwind-protect
                   (when (and (buffer-live-p source)
                              (eq process
                                  (buffer-local-value
                                   'gxde-roller-flymake--cpplint-process
                                   source)))
                     (funcall report-fn
                              (gxde-roller-flymake--cpplint-diagnostics
                               source (process-buffer process))))
                 (kill-buffer (process-buffer process))
                 (delete-directory temp-root t))))))))

(defun gxde-roller-flymake--add-cpplint-backend ()
  "Add the cpplint backend to this buffer's Flymake backends."
  (add-hook 'flymake-diagnostic-functions #'gxde-roller-flymake-cpplint nil t))

(defun gxde-roller-flymake-setup ()
  "Set up Flymake for a GXDE Roller C or C++ buffer."
  (when buffer-file-name
    ;; flymake-cc needs a Makefile with a check-syntax target, which this
    ;; project does not have; clangd covers compiler diagnostics instead.
    (remove-hook 'flymake-diagnostic-functions #'flymake-cc t)
    (when (executable-find "cpplint")
      (gxde-roller-flymake--add-cpplint-backend)
      ;; eglot replaces `flymake-diagnostic-functions' with its own backend
      ;; when it starts managing the buffer, so add cpplint back afterwards.
      (add-hook 'eglot-managed-mode-hook
                #'gxde-roller-flymake--add-cpplint-backend nil t))
    (flymake-mode 1)))

(provide 'gxde-roller-flymake)

;;; gxde-roller-flymake.el ends here
