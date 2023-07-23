{ config, pkgs, lib, username, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Appearance
      bufferline-nvim
      indent-blankline-nvim
      lualine-nvim
      alpha-nvim
      nvim-colorizer-lua
      #nvim-headlines
      nvim-web-devicons
      noice-nvim
      statuscol-nvim
      nvim-ufo

      # Appearance: Themes
      dracula-vim
      one-nvim
      tokyonight-nvim
      catppuccin-nvim

      # DAP
      nvim-dap
      nvim-dap-python
      nvim-dap-ui

      # Fuzzy Finder
      cheatsheet-nvim
      #nvim-better-digraphs
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim

      # General Deps
      nui-nvim
      plenary-nvim
      popup-nvim

      null-ls-nvim
      lspkind-nvim
      nvim-lspconfig
      lspsaga-nvim

      # Git
      gitsigns-nvim
      vim-fugitive

      # Navigation
      nvim-tree-lua
      vim-tmux-navigator

      # Progrmming: Treesitter
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          bash
          c
          css
          dhall
          dockerfile
          elm
          go
          haskell
          hcl
          html
          java
          javascript
          json
          latex
          lua
          markdown
          markdown-inline
          nix
          python
          regex
          ruby
          rust
          scss
          sql
          terraform
          toml
          tsx
          typescript
          vim
          yaml
        ]))
      nvim-nu
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      which-key-nvim

      # Programming: Autocompletion setup
      nvim-cmp
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-treesitter
      cmp-vsnip
      vim-vsnip
      vim-vsnip-integ

      # Programming: AI shit
      #nvim-codeium # AI completion prediction
      ChatGPT-nvim

      # Programming: Database support
      vim-dadbod
      vim-dadbod-ui

      ## Project management
      direnv-vim
      project-nvim

      # Text Helpers
      #nvim-regexplainer
      todo-comments-nvim
      venn-nvim
      vim-table-mode

      # Text objects
      nvim-autopairs
      nvim-comment
      nvim-surround
    ];

    extraPackages = with pkgs;
      [
        # Bash
        shellcheck
        shfmt

        # grammer
        vale

        # Git
        gitlint

        # Go
        gopls

        # JavaScript
        nodePackages.typescript-language-server

        # lua
        luaformatter
        lua-language-server

        # Make
        # cmake-language-server

        # Markdown
        nodePackages.markdownlint-cli
        # This is a cli utility as we can't display all this in cli
        pandoc

        # Nix
        deadnix
        statix
        nil
        nixfmt

        # SQL
        sqls
        postgresql

        # TOML
        taplo-cli

        # Vimscript
        nodePackages.vim-language-server

        # YAML
        nodePackages.yaml-language-server
        yamllint

        # general purpose / multiple langs
        efm-langserver
        nodePackages.prettier

        # utilities used by various programs
        # telescope
        ripgrep
        fd

      ] ++ (if pkgs.stdenv.isLinux then
        [
          # Grammer
          # Not available on mac using brew to install it
          ltex-ls
        ]
      else
        [

        ]) ++ (if username != "nix-on-droid" then
          [
            # HTML/CSS/JS
            nodePackages.vscode-langservers-extracted
          ]
        else
          [

          ]);

    extraConfig = ''
      colorscheme catppuccin-macchiato
      luafile ${builtins.toString ./init.lua}
    '';
  };

  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/lua/injected.lua".text = ''
      return {}
    '';
    "nvim/init_lua.lua".source = ./init.lua;
  };
}
