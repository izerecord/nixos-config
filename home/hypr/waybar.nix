{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style =
      ''
        * {
          border: none;
          border-radius: 0;
          font-family: Source Code Pro;
        }
        window#waybar {
          background: #16191C;
          color: #AAB2BF;
        }
        #workspaces button {
          padding: 0 5px;
        }
      ''
      };
  }
