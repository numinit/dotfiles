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

      hlsearch = true;
      incsearch = true;

      splitbelow = true;
      splitright = true;

      # Enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals

      encoding = "utf-8";
      fileencoding = "utf-8";
    };

    plugins = {
      telescope.enable = true;
      harpoon = {
        enable = true;
        keymaps.addFile = "<leader>a";
      };
      lazy.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      lsp = {
        enable = true;
        keymaps = {
        silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            K = "hover";
          };
        };
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
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
