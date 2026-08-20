{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dottyp.url = "github:luiswirth/dottyp";
    dottyp.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    dottyp,
    ...
  }: let
    forEachSystem = f:
      nixpkgs.lib.genAttrs ["aarch64-darwin" "x86_64-linux"]
      (system: f nixpkgs.legacyPackages.${system});
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [typst tinymist];
        TYPST_PACKAGE_PATH = "${dottyp}/pkg";
      };
    });
  };
}
