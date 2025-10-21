{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland?rev=0f2e1c75ea21ebec5e54522bf544fdf757ac8b9d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix.url = "github:nix-community/fenix";
    niri.url = "github:sodiboo/niri-flake";
    waybar.url = "github:Alexays/Waybar";
    stylix.url = "github:nix-community/stylix/release-25.05";
    technorino.url = "git+https://github.com/2547techno/technorino?submodules=1";
    redlib.url = "github:0Supa/redlib";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    uploader-basic.url = "github:0Supa/uploader-basic";
  };
  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;

      mkHost =
        system: hostname:
        let
          builder =
            if system == "darwin" then inputs.nix-darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
          config = builder {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/${system}/${hostname}
              ./common
              { config._module.args = { inherit hostname; }; }
            ];
          };
          key = "${system}Configurations";
        in
        {
          ${key} = {
            ${hostname} = config;
          };
        };

      systems = builtins.attrNames (builtins.readDir ./hosts);

      hosts = builtins.concatMap (
        system:
        let
          hostnames = builtins.attrNames (builtins.readDir (./hosts + "/${system}"));
        in
        map (hostname: mkHost system hostname) hostnames
      ) systems;

    in
    builtins.foldl' lib.recursiveUpdate { } hosts;
}
