{ pkgs, ... }:
{
  packages = with pkgs; [
  ];

  languages = {
    python = {
      enable = true;
    };
  };
}
