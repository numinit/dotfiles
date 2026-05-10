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
      relativenumber = true;
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
      timeoutlen = 400;
      scrolloff = 6;
      sidescrolloff = 8;

      undofile = true;
      confirm = true;
      mouse = "a";

      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      fillchars = {
        eob = " ";
        fold = " ";
        foldopen = "▾";
        foldclose = "▸";
        foldsep = "│";
      };
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
          incremental_selection.enable = true;
        };
      };

      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ab" = "@block.outer";
            "ib" = "@block.inner";
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
          };
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
            ghost_text.enabled = true;
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
          lua_ls.enable = true;
          rust_analyzer = {
            enable = false;
            installRustc = true;
            installCargo = true;
            installRustfmt = true;
          };
        };
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 2000;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            sh = [ "shfmt" ];
            bash = [ "shfmt" ];
            lua = [ "stylua" ];
            c = [ "clang_format" ];
            cpp = [ "clang_format" ];
            json = [ "jq" ];
            yaml = [ "yamlfmt" ];
            "_" = [ "trim_whitespace" "trim_newlines" ];
          };
        };
      };

      lualine.enable = true;
      which-key.enable = true;

      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "▎";
            change.text = "▎";
            delete.text = "";
            topdelete.text = "";
            changedelete.text = "▎";
            untracked.text = "▎";
          };
          current_line_blame = true;
          current_line_blame_opts.delay = 500;
        };
      };

      todo-comments.enable = true;
      trouble.enable = true;
      fidget.enable = true;
      notify.enable = true;
      colorizer.enable = true;
      rainbow-delimiters.enable = true;
      nvim-ufo.enable = true;
      oil.enable = true;

      flash = {
        enable = true;
        settings.modes.search.enabled = false;
      };

      mini = {
        enable = true;
        modules = {
          ai = { };
          surround = { };
          pairs = { };
          indentscope = {
            symbol = "│";
            options.try_as_border = true;
          };
          move = { };
          bracketed = { };
          trailspace = { };
        };
      };
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2 expandtab";
      }
      {
        event = "TextYankPost";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.hl.on_yank({ timeout = 200 })
          end
        '';
      }
    ];
  };
}
