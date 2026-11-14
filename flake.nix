{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = nixpkgs.lib.genAttrs [ "rob-pc" "rob-laptop" ] (
      host:
      nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/${host}/default.nix
          ./common.nix
        ];
      }
    );
  };
}
