(use-package js2-mode
  :ensure js2-mode
  :mode "\\.js\\'"
  :init
  (progn
    (add-hook 'js-mode-hook 'js2-mode)
    (add-hook 'js2-mode-hook 'ac-js2-mode)))

(provide 'my-javascript)
