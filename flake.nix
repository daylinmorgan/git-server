{
  description = "git repos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs;
    supportedSystems = ["x86_64-linux"];
    forAllSystems = f: genAttrs supportedSystems (system: f nixpkgs.legacyPackages.${system});
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [nim openssl];
      };
    });
  };
}
