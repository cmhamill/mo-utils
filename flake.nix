{
  description = "mo-utils utility collection.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: {
    overlays.default = final: prev: {
      mo-utils = prev.callPackage ./. { };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
    }; in {
      checks.build = pkgs.mo-utils;
      packages = {
        inherit (pkgs) mo-utils;
        default = pkgs.mo-utils;
      };
    }
  );
}
