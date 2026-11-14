{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.bootvine = {
    url = "git+https://codeberg.org/wvhulle/bootvine";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, bootvine, ... }: {
    nixosConfigurations = nixpkgs.lib.genAttrs [ "rob-pc" "rob-laptop" ] (
      host:
      nixpkgs.lib.nixosSystem {
        modules = [
          bootvine.nixosModules.default
          ./hosts/${host}/default.nix
          ./common.nix
        ];
      }
    );
  };
}
