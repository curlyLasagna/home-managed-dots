;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

(
 (nil
  . ((projectile-project-compilation-cmd . "home-manager switch --flake .#")))
 (nix-mode
  . (
     (eglot-workspace-configuration
      .
      (:nixd
       (:options
        (:home-manager
         (:expr
          "(builtins.getFlake (builtins.toString ./.)).homeConfigurations.\"personal-macbook\".options")))))))
 )
