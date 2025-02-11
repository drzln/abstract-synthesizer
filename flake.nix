{
  description = "generic ruby dsl resources";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.ruby-nix.url = "github:inscapist/ruby-nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    nixpkgs,
    flake-utils,
    ruby-nix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ruby-nix.overlays.ruby];
      };
      rnix = ruby-nix.lib pkgs;
      rnix-env = rnix {
        name = "abstract-synthesizer";
        gemset = ./gemset.nix;
      };
      env = rnix-env.env;
      ruby = rnix-env.ruby;
    in {
      devShells = rec {
        default = dev;
        dev = pkgs.mkShell {
          buildInputs = [
            env
            ruby
          ];
        };
      };
    });
}
