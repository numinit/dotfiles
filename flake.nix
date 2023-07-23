{
  description =
    "Dotfiles for numinit. There are many like it, but this one is mine.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    string-option.url = "github:numinit/string-option";
    username_00.url = "github:numinit/string-option";
    username_01.url = "github:numinit/string-option";
    username_02.url = "github:numinit/string-option";
    username_03.url = "github:numinit/string-option";
    username_04.url = "github:numinit/string-option";
    username_05.url = "github:numinit/string-option";
    username_06.url = "github:numinit/string-option";
    username_07.url = "github:numinit/string-option";
    username_08.url = "github:numinit/string-option";
    username_09.url = "github:numinit/string-option";
    username_10.url = "github:numinit/string-option";
    username_11.url = "github:numinit/string-option";
    username_12.url = "github:numinit/string-option";
    username_13.url = "github:numinit/string-option";
    username_14.url = "github:numinit/string-option";
    username_15.url = "github:numinit/string-option";
  };

  outputs =
    { self, nixpkgs, home-manager, flake-utils, string-option, ... }@args:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        username = (builtins.replacestrings [ "+" ] [ "-" ]
          (string-option.extract "username_" args));
      in {
        packages = rec {
          dotfiles = pkgs.writeShellScriptBin "dotfiles.sh" ''
            config="$1"
            if [ -z "$config" ]; then
                config=".#workstation"
            fi

            set -euo pipefail
            username="$(whoami)"
            username="''${username:0:16}"

            extra_args=()
            for ((i=0;i<''${#username};i++)); do
                char="''${username:i:1}"
                if [ "$char" == '-' ]; then
                    char='@'
                elif [[ ! "$char" =~ ^[A-Za-z0-9]$ ]]; then
                    echo "Your username ('$username') has an invalid character!" >&2
                    exit 1
                fi
                extra_args+=(
                    --override-input
                    "username_$(printf '%02d' "$i")"
                    "github:numinit/string-option/$char"
                )
            done

            cd "${self}" && exec ${
              home-manager.packages.${system}.default
            }/bin/home-manager switch \
                --flake "''${config}" \
                ''${extra_args[@]+"''${extra_args[@]}"}
          '';
          default = dotfiles;
          homeConfigurations = {
            workstation = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit nixpkgs system username; };
              modules = [
                { nixpkgs.overlays = [ self.overlays.default ]; }
                ./home
                ./home/workstation.nix
              ];
            };
          };
        };
        apps = rec {
          dotfiles =
            flake-utils.lib.mkApp { drv = self.packages.${system}.dotfiles; };
          default = dotfiles;
        };
      }) // {
        overlays.default = final: prev:
          {
            # nop for now
          };
      };
}
