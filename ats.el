(setenv "PATSHOME" (concat (getenv "HOME") "/tool/ats/ATS2-Postiats-0.2.1"))

;; https://raw.githubusercontent.com/rsimoes/ATS-Lang/master/utils/emacs/ats-mode.el
(require 'ats-mode)
(setq auto-mode-alist
      (append '(("\\.dats$" . ats-mode))
              auto-mode-alist))

(add-hook 'ats-mode-hook
          '(lambda ()
             (require 'smart-compile)
             (setq smart-compile-alist
                   (append smart-compile-alist
                           '(("\\.dats$" . "patscc %f -o %n && ./%n"))))
             (with-eval-after-load 'flycheck
               (flycheck-ats2-setup))
             (require 'flycheck)
             (flycheck-mode)))

;; https://raw.githubusercontent.com/drvink/flycheck-ats2/master/flycheck-ats2.el
(require 'flycheck-ats2)
