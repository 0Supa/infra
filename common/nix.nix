{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs = {
    config.allowUnfree = true;

    overlays = (import ./overlays) ++ [
      inputs.nixpkgs-wayland.overlays.default
      inputs.agenix.overlays.default
      inputs.fenix.overlays.default
      inputs.niri.overlays.niri
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      warn-dirty = false;
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://niri.cachix.org"
        "https://stylix.cachix.org"
        "https://technorino.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "stylix.cachix.org-1:iTycMb+viP8aTqhRDvV5qjs1jtNJKH9Jjvqyg4DYxhw="
        "technorino.cachix.org-1:u2mWFvgBuof1W3wr8VT5UQ10m4T1yoJb6fVnmhXf04o="
      ];
    };
  };

  _module.args = with pkgs.stdenv.hostPlatform; {
    unstable = import inputs.nixpkgs-unstable {
      system = pkgs.system;
      config.allowUnfree = true;
    };
  };
}
