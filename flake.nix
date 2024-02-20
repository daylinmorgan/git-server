{
  description = "git repos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs makeBinPath;
    eachSystem = fn:
      genAttrs [ "x86_64-linux" ]
      (system: fn nixpkgs.legacyPackages.${system});
  in {
    devShells = eachSystem (_: pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [nim openssl];
      };
    });
  };
}
