{ flake-parts-lib, nixpkgs-lib, unstable, ... }:
let
  inherit (flake-parts-lib) mkPerSystemOption;
  inherit (nixpkgs-lib.lib)
    mkOption
    types
    mkEnableOption
    optional
    assertMsg
    ;
in
{
  config,
  self,
  inputs,
  ...
}:
{
  options.perSystem = mkPerSystemOption (
    { config, pkgs, system, ... }:
    let
      cfg = config.env;
    in
    {
      options.env.name = mkOption {
        description = ''
          Name.

          For default shell.
        '';
        type =  types.str;
        default = "default";
      };

      # Option implementation on top of devenv module
      config.devenv.shells.default = {
        devenv.root =
          let
            devenvRootFileContent = builtins.readFile self.inputs.devenv-root.outPath;
          in
          pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

        name = cfg.name;

        imports = [ ./devenv-mavproxy.nix ];

        packages = [

        ];
      };

      config.devenv.shells.debug = {
        devenv.root =
          let
            devenvRootFileContent = builtins.readFile self.inputs.devenv-root.outPath;
          in
          pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

        name = "cugordo";

        imports = [ ];
      };
    }
  );
}
