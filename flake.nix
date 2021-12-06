{
  description = "mo-utils utility collection.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: {
    overlay = final: prev: {
      mo-utils = prev.callPackage ./. { };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    }; in {
      defaultPackage = pkgs.mo-utils;
      packages = { inherit (pkgs) mo-utils; };
    }
  );
}
