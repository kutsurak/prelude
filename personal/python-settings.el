;;;; python-settings.el -- Configuration for python

;;; Commentary:

;;; Code:
(require 'jedi)

;; Enable for python mode
(add-hook 'python-mode-hook 'jedi:setup)

(defvar jedi-config:with-virtualenv nil)

(defvar jedi-config:vcs-root-sentinel ".git")
(defvar jedi-config:python-module-sentinel "__init__.py")

(defun get-project-root (buf repo-type init-file)
  "Find the project root of the given buffer, based on cues from
git (.git directory) and python (__init__.py file)."
  (vc-find-root (expand-file-name (buffer-file-name buf)) repo-type))

(defvar jedi-config:find-root-function 'get-project-root)

(defun current-buffer-project-root ()
  (funcall jedi-config:find-root-function
           (current-buffer)
           jedi-config:vcs-root-sentinel
           jedi-config:python-module-sentinel))

(defun jedi-config:setup-server-args ()
  (defmacro add-args (arg-list arg-name arg-value)
    `(setq ,arg-list (append ,arg-list (list ,arg-name ,arg-value))))

  (let ((project-root (current-buffer-project-root)))

    (make-local-variable 'jedi-server-args)
    (when project-root
      (add-args jedi:server-args "--sys-path" project-root))
    (when jedi-config:with-virtualenv
      (add-args jedi-server-args
                "--virtual-env"
                jedi-config:with-virtualenv))))

(add-hook 'python-mode-hook
          'jedi-config:setup-server-args)

(defun jedi-config:setup-keys ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "M-?") 'jedi:show-doc)
  (local-set-key (kbd "M-/") 'jedi:get-in-function-call))

(add-hook 'python-mode-hook 'jedi-config:setup-keys)

(setq jedi:get-in-function-call-delay 10000000)
(setq jedi:complete-on-dot t)


(provide 'python-settings)
;;; python-settings ends here
