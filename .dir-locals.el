;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

(
 (nil
  . ((projectile-project-compilation-cmd . "home-manager switch --flake .#")))
 
 (nix-mode
  . (
     (lsp-nix-nixd-home-manager-options-expr
      . "(builtins.getFlake (builtins.to String ./.)).homeConfigurations.\"personal-macbook\".options")))
 )
