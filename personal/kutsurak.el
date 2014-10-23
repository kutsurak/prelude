;;;; kutsurak.el -- Personal settings for Prelude

;;; Commentary:

;;; Code:
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-c <backspace>") 'c-hungry-delete-backwards)
(global-set-key (kbd "C-c k") 'kill-region)

(require 'java-unicode-conversions)

;; org mode customization
(add-hook 'org-mode-hook 'auto-fill-mode)

(provide 'kutsurak)
;;; kutsurak.el ends here
