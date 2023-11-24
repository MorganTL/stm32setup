{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

    in rec {
      devShell = pkgs.mkShell {
        name = "STM32 slides";
        buildInputs = with pkgs; [
          nodejs
          nodePackages.npm
        ];
        shellHook = ''
        npm install markdown-to-slides
        '';
      };

      packages.default = pkgs.writeScriptBin "makeslide" ''
        markdown-to-slides slide.md -o slideshow.html
      '';
    }
  );
}