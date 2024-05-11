{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    git
    gh
    alejandra
    nil
    fish
    gcc
    cargo
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    nushell = {
      enable = true;
      extraConfig = "
let fish_completer = {|spans|
    fish --command $'complete \"--do-complete=($spans | str join \" \")\"'
    | $\"value(char tab)description(char newline)\" + $in
    | from tsv --flexible --no-infer
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # carapace doesn't have completions for asdf
        asdf => $fish_completer
        nix => $fish_completer
    } | do $in $spans
}

$env.config = {
    # ...
    completions: {
        external: {
            enable: true
            completer: $external_completer
        }
    }
    # ...
}
      ";
    };

    carapace = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      extraPackages = with pkgs; [ tree-sitter nodejs ripgrep fd unzip ];
    };
  };

  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "nu";
    };
    stateVersion = "23.11";
  };
}
