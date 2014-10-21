;;; java-unicode-conversions.el --- package to convert encoding

;;; Commentary:

;;; Code:
(defun ju-encode-char (ch)
  "Encode a single character.
CH the character to be encoded."
  (if (< ch #xff) ;Is ch a unibyte char
      ch ; if yes return it unchanged, otherwise encode it
    (format "\\u%04X" ch)))

(defun ju-decode-char (ch)
  "Decode a single character.
CH the character to be encoded."
  (if (integerp ch) ;Is ch a single character?
      ch ; if yes return it, otherwise parse it into an integer
    (string-to-number ch 16)))

(defun ju-decode-region (start end)
  "Decode a marked region.
START the initial position of the region.
END the final position of the region"
  (interactive "r")
  (let ((old-buf (current-buffer))
        (reg (delete-and-extract-region start end)))
    (insert
     (with-temp-buffer
       (insert reg)
       (goto-char 1)
       (setq more-chars (not (eobp)))
       (while more-chars
         (let ((cchar (char-after)))
           (if (equal cchar ?\\)
               (let ((big-char (buffer-substring-no-properties
                                (+ (point) 2)
                                (+ (point) 6))))
                 (delete-forward-char 6)
                 (insert (ju-decode-char big-char)))
             (forward-char)))
         (setq more-chars (not (eobp))))
       (delete-and-extract-region (point-min) (point-max))))))

(defun ju-encode-region (start end)
  "Encode a marked region.
START the initial position of the region.
END the final position of the region"
  (interactive "r")
  (let ((old-buf (current-buffer))
        (reg (delete-and-extract-region start end)))
    (insert
     (with-temp-buffer
       (insert reg)
       (goto-char 1)
       (setq more-chars (not (eobp)))
       (while more-chars
         (let ((cchar (char-after)))
           (delete-forward-char 1)
           (insert (ju-encode-char cchar)))
         (setq more-chars (not (eobp))))
       (delete-and-extract-region (point-min) (point-max))))))

(provide 'java-unicode-conversions)
;;; java-unicode-conversions.el ends here
