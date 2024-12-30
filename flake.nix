{
  description =
    "Dotfiles for numinit. There are many like it, but this one is mine.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    username_16.url = "github:numinit/string-option";

    home_00.url = "github:numinit/string-option";
    home_01.url = "github:numinit/string-option";
    home_02.url = "github:numinit/string-option";
    home_03.url = "github:numinit/string-option";
    home_04.url = "github:numinit/string-option";
    home_05.url = "github:numinit/string-option";
    home_06.url = "github:numinit/string-option";
    home_07.url = "github:numinit/string-option";
    home_08.url = "github:numinit/string-option";
    home_09.url = "github:numinit/string-option";
    home_10.url = "github:numinit/string-option";
    home_11.url = "github:numinit/string-option";
    home_12.url = "github:numinit/string-option";
    home_13.url = "github:numinit/string-option";
    home_14.url = "github:numinit/string-option";
    home_15.url = "github:numinit/string-option";
    home_16.url = "github:numinit/string-option";
    home_17.url = "github:numinit/string-option";
    home_18.url = "github:numinit/string-option";
    home_19.url = "github:numinit/string-option";
    home_20.url = "github:numinit/string-option";
    home_21.url = "github:numinit/string-option";
    home_22.url = "github:numinit/string-option";
    home_23.url = "github:numinit/string-option";
    home_24.url = "github:numinit/string-option";
    home_25.url = "github:numinit/string-option";
    home_26.url = "github:numinit/string-option";
    home_27.url = "github:numinit/string-option";
    home_28.url = "github:numinit/string-option";
    home_29.url = "github:numinit/string-option";
    home_30.url = "github:numinit/string-option";
    home_31.url = "github:numinit/string-option";
    home_32.url = "github:numinit/string-option";
    home_33.url = "github:numinit/string-option";
    home_34.url = "github:numinit/string-option";
    home_35.url = "github:numinit/string-option";
    home_36.url = "github:numinit/string-option";
    home_37.url = "github:numinit/string-option";
    home_38.url = "github:numinit/string-option";
    home_39.url = "github:numinit/string-option";
    home_40.url = "github:numinit/string-option";
    home_41.url = "github:numinit/string-option";
    home_42.url = "github:numinit/string-option";
    home_43.url = "github:numinit/string-option";
    home_44.url = "github:numinit/string-option";
    home_45.url = "github:numinit/string-option";
    home_46.url = "github:numinit/string-option";
    home_47.url = "github:numinit/string-option";
    home_48.url = "github:numinit/string-option";
    home_49.url = "github:numinit/string-option";
    home_50.url = "github:numinit/string-option";
    home_51.url = "github:numinit/string-option";
    home_52.url = "github:numinit/string-option";
    home_53.url = "github:numinit/string-option";
    home_54.url = "github:numinit/string-option";
    home_55.url = "github:numinit/string-option";
    home_56.url = "github:numinit/string-option";
    home_57.url = "github:numinit/string-option";
    home_58.url = "github:numinit/string-option";
    home_59.url = "github:numinit/string-option";
    home_60.url = "github:numinit/string-option";
    home_61.url = "github:numinit/string-option";
    home_62.url = "github:numinit/string-option";
    home_63.url = "github:numinit/string-option";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, flake-utils
    , string-option, ... }@args:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        username = string-option.extract "username_" args;
        homeDirectory = string-option.extract "home_" args;
      in {
        packages = rec {
          dotfiles = pkgs.writeShellScriptBin "dotfiles.sh" ''
            config="$1"
            if [ -z "$config" ]; then
              config=".#roadwarrior"
            else
              config="''${config##*.}"
              config="''${config##.#}"
              config=".#''$config"
            fi

            set -euo pipefail

            extra_args=()

            # Adds extra args. $1 is the prefix, $2 is the value, and $3 is
            # the maximal allowable length. The globally allowed max length
            # is 1000 characters.
            add_extra_args() {
              local prefix="$1"
              local value="$2"
              local maxlen="$3"
              local format=""

              if [ "$maxlen" -le 10 ]; then
                format='%d'
              elif [ "$maxlen" -le 100 ]; then
                format='%02d'
              elif [ "$maxlen" -le 1000 ]; then
                format='%03d'
              else
                echo "max length $maxlen was too large" >&2
                return 1
              fi

              if [ "''${#value}" -gt "$maxlen" ]; then
                echo "value '$value' was too long (max: $maxlen)" >&2
                return 1
              fi

              for ((i=0;i<''${#value};i++)); do
                  local char="''${value:i:1}"
                  extra_args+=(
                      --override-input
                      "''${prefix}$(printf "$format" "$i")"
                      "github:numinit/string-option/$(printf '0x%x' "'$char")"
                  )
              done
            }

            add_extra_args 'username_' "$(whoami)" 16
            add_extra_args 'home_' "$HOME" 64

            cd "${self}" && exec ${
              home-manager.packages.${system}.default
            }/bin/home-manager switch \
                --flake "''${config}" \
                ''${extra_args[@]+"''${extra_args[@]}"}
          '';
          default = dotfiles;
          homeConfigurations = let
            mkConfig = configModule:
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {
                  inherit nixpkgs system username homeDirectory;
                };
                modules = [
                  { nixpkgs.overlays = [ self.overlays.default ]; }
                  nixvim.homeManagerModules.nixvim
                  ./home
                  configModule
                ];
              };
          in {
            workstation = mkConfig ./home/workstation.nix;
            roadwarrior = mkConfig ./home/roadwarrior.nix;
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
