{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;  [
      #dracula-theme.theme-dracula
      #vscodevim.vim
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
    ];
    /*
      userSettings = {
      "files.autoSave"= "afterDelay";
      "git.autofetch"= true;
      "git.enableSmartCommit"= true;
      "editor.formatOnSave"= true;
      "editor.minimap.enabled"= false;
      "nix.enableLanguageServer"= true;
      "nix.serverSettings"= {
        "nil"= {
            "diagnostics"= {
                "ignored"= [
                    "unused_binding"
                ];
            };
            "formatting"= {
                "command"= [
                    "nixpkgs-fmt"
                ];
            };
        };
      };
      };
    */
  };
}
