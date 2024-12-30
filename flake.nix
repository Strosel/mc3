{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default =
        pkgs.mkShell
        {
          name = "mc3-shell";
          buildInputs = with pkgs; [
            packwiz
          ];
        };

      apps.sync = let
        app = pkgs.writeShellApplication {
          name = "sync";
          runtimeInputs = with pkgs; [
            packwiz
          ];
          text = ''
            packwiz refresh
            packwiz modrinth export
          '';
        };
      in {
        type = "app";
        program = "${app}/bin/${app.name}";
      };
    });
}
