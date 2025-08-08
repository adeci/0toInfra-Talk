{
  description = "Minimal NixOS microvm example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, microvm }: {
    nixosConfigurations.my-microvm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        microvm.nixosModules.microvm
        ./configuration.nix
        {
          microvm = {
            hypervisor = "qemu";
            graphics.enable = false;
            shares = [{
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "9p";
            }];
            volumes = [];
            interfaces = [];
          };
        }
      ];
    };

    packages.x86_64-linux.default = self.nixosConfigurations.my-microvm.config.microvm.runner.qemu;
  };
}
