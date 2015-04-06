;;;; kutsurak.el -- Personal settings for Prelude

;;; Commentary:

;;; Code:
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-c <backspace>") 'c-hungry-delete-backwards)
(global-set-key (kbd "C-c k") 'kill-region)

(prelude-require-package 'ido-vertical-mode)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;;; Prevent autosearch in ido-mode unless specifically requested to!
(setq ido-auto-merge-work-directories-length -1)
(define-key ido-file-dir-completion-map (kbd "C-c C-s")
  (lambda()
    (interactive)
    (ido-initiate-auto-merge (current-buffer))))

(require 'java-unicode-conversions)
(add-hook 'conf-javaprop-mode-hook 'kutsurak/ju-keybind)

;; Show me the REPL!
(slime-setup '(slime-fancy))
(global-set-key (kbd "<f9>") 'slime-selector)

;; org mode customization
(add-hook 'org-mode-hook 'auto-fill-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))

(custom-set-variables '(haskell-process-type 'cabal-repl))

(custom-set-variables '(haskell-tags-on-save t))

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t))

(custom-set-variables
 '(haskell-process-suggest-hoogle-imports t))

(provide 'kutsurak)
;;; kutsurak.el ends here
