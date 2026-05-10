{ pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    colorschemes.catppuccin.enable = true;

    opts = {
      virtualedit = "block";
      cursorline = true;

      number = true;
      signcolumn = "yes";

      hlsearch = true;
      incsearch = true;

      splitbelow = true;
      splitright = true;

      ignorecase = true;
      smartcase = true;

      encoding = "utf-8";
      fileencoding = "utf-8";

      updatetime = 250;
    };

    diagnostic.settings = {
      virtual_text = true;
      severity_sort = true;
      underline = true;
      float.border = "rounded";
    };

    plugins = {
      telescope.enable = true;
      harpoon.enable = true;
      rustaceanvim.enable = true;
      web-devicons.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          keymap.preset = "enter";
          completion = {
            documentation.auto_show = true;
            list.selection.preselect = true;
          };
          signature.enabled = true;
          sources.default = [ "lsp" "path" "snippets" "buffer" ];
        };
      };

      lsp = {
        enable = true;
        autoLoad = true;
        inlayHints = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            "<leader>e" = "open_float";
          };
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gi = "implementation";
            gr = "references";
            gt = "type_definition";
            K = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>f" = "format";
          };
        };
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          rust_analyzer = {
            enable = false;
            installRustc = true;
            installCargo = true;
            installRustfmt = true;
          };
        };
      };

      lualine.enable = true;
    };

    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2 expandtab";
      }
    ];
  };
}
