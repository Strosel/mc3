{
  description = "Flux issue";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flux.url = "github:IogaMaster/flux";
  };

  outputs = {
    self,
    nixpkgs,
    flux,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [flux.overlays.default];
    };
  in {
    packages.${system}.default = pkgs.mkMinecraftServer {
      name = "myminecraftserver";
      src = ./mcman;
      hash = "";
    };

    devShells.${system}.default =
      pkgs.mkShell
      {
        name = "mc3-shell";
        buildInputs = with pkgs; [
          packwiz
          mcman
        ];
      };
  };
}
