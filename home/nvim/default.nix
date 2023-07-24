{ pkgs, lib, ... }:
{
  programs.neovim-ide.enable = true;
  programs.neovim-ide.settings = {
    vim = {
      viAlias = true;
      vimAlias = true;
      preventJunkFiles = true;
      disableArrows = false;
      lineNumberMode = "number";
      useSystemClipboard = true;
      cmdHeight = 2;
      customPlugins = with pkgs.vimPlugins; [
        multiple-cursors
        vim-repeat
      ];
      lsp = {
        enable = true;
        folds = true;
        formatOnSave = true;
        lightbulb.enable = true;
        lspsaga.enable = true;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        scala = {
          inherit (pkgs) metals;
          enable = false;
        };
        nix = {
          enable = true;
          type = "nil";
        };
        rust.enable = false;
        ts = true;
        smithy.enable = false;
        dhall = false;
        elm = false;
        haskell = false;
        sql = true;
        python = true;
        clang = true;
        go = true;
      };
      plantuml.enable = false;
      fx.automaton.enable = true;
      visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        lspkind.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = "";
          eolChar = "";
          showCurrContext = true;
        };
        cursorWordline = {
          enable = true;
          lineTimeout = 0;
        };
      };
      statusline.lualine = {
        enable = true;
        theme = "tokyonight";
      };
      theme = {
        enable = true;
        name = "tokyonight";
        style = "storm";
        transparency = true;
      };
      autopairs.enable = true;
      neoclip.enable = true;
      autocomplete.enable = true;
      filetree.nvimTreeLua = {
        enable = true;
        hideDotFiles = false;
        openOnSetup = false;
        hideFiles = [ "node_modules" ".cache" ];
        treeSide = "right";
      };
      tabline.nvimBufferline.enable = true;
      treesitter = {
        enable = true;
        autotagHtml = true;
        context.enable = true;
      };
      keys = {
        enable = true;
        whichKey.enable = true;
      };
      comments = {
        enable = true;
        type = "nerdcommenter";
      };
      shortcuts = {
        enable = true;
      };
      surround = {
        enable = true;
      };
      telescope = {
        enable = true;
        # NOTE: still quite buggy in some terminals
        mediaFiles.enable = false;
      };
      markdown = {
        enable = true;
        glow.enable = true;
      };
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      mind = {
        enable = false;
        persistence = {
          dataDir = "~/.local/share/mind.nvim/data";
          statePath = "~/.local/share/mind.nvim/mind.json";
        };
      };
      chatgpt = {
        enable = false;
        openaiApiKey = null;
      };
      spider = {
        enable = true;
        skipInsignificantPunctuation = true;
      };
      dial.enable = true;
      hop.enable = true;
      notifications.enable = true;
      todo.enable = true;
    };
  };
}
