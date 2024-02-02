{ config, pkgs, lib, user, ... }:
let
  inherit (pkgs) rustToolchain sheldon mise firge-nerd;
  homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user;
  home.homeDirectory = "${homePrefix}/${user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # stdenv tools
    gnutar
    gnumake
    gcc13
    gzip
    coreutils
    findutils
    gnused
    gawk
    gnugrep
    xz
    bzip2
    gnupatch

    # essentials
    vim
    git
    git-lfs
    wget
    curl
    readline
    openssl
    openssh
    gnupg
    tree

    # GUI apps
    wezterm

    # utils
    tmux
    lsd
    jq
    fzf
    bat
    neovim
    starship
    zoxide
    direnv
    gh
    du-dust
    sheldon
    cargo-clean-all

    # nix devtools
    nil
    nixpkgs-fmt
    cachix

    # fonts
    firge-nerd

    # programming languages
    mise # ... manager
    rustToolchain
  ];

  # ** this should be synced with `install.sh`. **
  home.file = {
    ".zshrc".source = ./zshrc;
    ".wezterm.lua".source = ./wezterm.lua;
    ".tmux.conf".source = ./tmux.conf;
    ".config/starship.toml".source = ./config/starship.toml;
    ".config/bat/config".source = ./config/bat/config.conf;
    ".config/nvim/init.vim".source = ./config/nvim/init.vim;
    ".config/mise/config.toml".source = ./config/mise/config.toml;
    ".config/sheldon/plugins.toml".source = ./config/sheldon/plugins.toml;
    ".config/git/gitmessage.txt".source = ./config/git/gitmessage.txt;
    ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      hash = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
    };
  };

  home.activation = {
    activateMise = lib.hm.dag.entryAfter [ "onFilesChange" "installPackages" ] ''
      $DRY_RUN_CMD /bin/zsh -l -c 'mise trust ~/.config/mise/config.toml && mise install'
    '';
    updateSheldon = lib.hm.dag.entryAfter [ "onFilesChange" "installPackages" ] ''
      $DRY_RUN_CMD /bin/zsh -l -c 'sheldon lock'
    '';
  };

  home.extraActivationPath = [ mise sheldon ];

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kh/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  fonts.fontconfig.enable = true;

  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
