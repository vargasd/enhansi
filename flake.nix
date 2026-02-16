{
  description = "Color schemes that works with your terminal palette";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        {
          packages = {
            neovim = pkgs.vimUtils.buildVimPlugin {
              pname = "enhansi-nvim";
              src = ./.;
              version = self.shortRev or "dirty";
            };

            tmtheme = pkgs.stdenv.mkDerivation {
              pname = "enhansi-tmtheme";
              src = ./.;
              version = self.shortRev or "dirty";

              installPhase = ''
                mkdir -p $out
                cp enhansi.tmTheme $out/
              '';

              meta = {
                description = "Enhansi terminal color scheme theme file";
                license = pkgs.lib.licenses.mit;
              };
            };
          };
        };
      flake = {
        overlays.default = final: prev: {
          vimPlugins = (prev.vimPlugins or { }) // {
            enhansi-nvim = self.packages.${final.system}.neovim;
          };
          enhansi-tmtheme = self.packages.${final.system}.tmtheme;
        };
      };
    };
}
