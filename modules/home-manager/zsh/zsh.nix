{ config, pkgs, settings, ... }: {
  programs.zsh = {
    enable = true;
    # enableCompletion = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      # {
      #   name = "zsh-autocomplete";
      #   src = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete";
      # }
    ];

    shellAliases = {
      ".." = "cd ..";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";

      # cbread = "wl-copy";
      # cbprint = "wl-paste";
      v = "nvim";
      vim = "nvim";
      c = "clear";
      #sv = "sudo nvim";
      # hs = "home-manager switch --flake .";
      # list-gens =
        # "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/";
      # update-input = "nix flake update $@";
      y = "yazi";
      gs = "git status --short";
      gd = "git diff";
      ga = "git add";
      gaa = "git add --all";
      gfa = "git fetch --all --tags --prune";
      gco = "git checkout";
      gcb = "git checkout -b";
      gcd = "git checkout -D";
      gcmsg = "git commit -m";
      gopull = "git pull origin \${git_current_branch}";
      gopush = "git push origin \${git_current_branch}";
      gprom = "git pull origin \${git_main_branch} --rebase --autostash";
      gprum = "git pull upstream \${git_main_branch} --rebase --autostash";
      glom = "git pull origin \${git_main_branch}";
      glum = "git pull upstream \${git_main_branch}";
      gluc = "git pull upstream \${git_current_branch}";
      glgg = "git log --graph --stat";
      glo = "git log --online -graph";
      generations = "nixos-rebuild list-generations";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    # initContent = builtins.readFile ./widgets.zsh;

  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

programs.zsh.initContent = ''
  eval "$(starship init zsh)"
'';


  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.eza.enable = true;
  programs.eza.enableZshIntegration = true;
  programs.yazi.enableZshIntegration = true;
  # programs.ghostty.enableZshIntegration = true;
  # programs.alacritty.enableZshIntegration = true;
  # programs.starship.enableZshIntegration = true;
  programs.atuin.enableZshIntegration = true;

}

