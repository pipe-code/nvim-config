# Plan de Implementación — Neovim Setup

> Stack: TypeScript · React/TSX · CSS/SCSS · HTML · JSON
> Teclado: Split 32 teclas · Colemak Mod-DH · Leader = Space

---

## Plugins instalados

| Categoría      | Plugin                                      | Estado |
|----------------|---------------------------------------------|--------|
| Tema           | dracula/vim                                 | ✅     |
| IA             | github/copilot.vim                          | ✅     |
| Explorador     | preservim/nerdtree                          | ✅     |
| Buscador       | nvim-telescope/telescope.nvim               | ✅     |
| LSP            | neovim/nvim-lspconfig                       | ✅     |
| Autocompletado | hrsh7th/nvim-cmp + cmp-nvim-lsp/buffer/path | ✅     |
| Snippets       | L3MON4D3/LuaSnip + cmp_luasnip             | ✅     |
| Comentarios    | numToStr/Comment.nvim                       | ✅     |
| Comentarios    | JoosepAlviste/nvim-ts-context-commentstring | ✅     |
| Edición        | tpope/vim-surround                          | ✅     |
| Edición        | windwp/nvim-autopairs                       | ✅     |
| Git            | airblade/vim-gitgutter                      | ✅     |
| Git            | tpope/vim-fugitive                          | ✅     |
| Git            | sindrets/diffview.nvim                      | ✅     |
| Sesiones       | tpope/vim-obsession                         | ✅     |
| UI             | nvim-lualine/lualine.nvim                   | ✅     |
| UI             | nvim-tree/nvim-web-devicons                 | ✅     |
| UI             | lukas-reineke/indent-blankline.nvim         | ✅     |
| UI             | akinsho/bufferline.nvim                     | ✅     |
| Sintaxis       | nvim-treesitter/nvim-treesitter             | ✅     |

## LSP Servers activos

- **ts_ls** — TypeScript / JavaScript
- **cssls** — CSS / SCSS
- **html** — HTML
- **jsonls** — JSON (con validación)

---

## Roadmap

### Completado
- [x] Setup base + tema Dracula
- [x] LSP + autocompletado (nvim-cmp + LuaSnip)
- [x] Git workflow: gitgutter (hunks) + fugitive (comandos) + diffview (diffs visuales)
- [x] Gestión de sesiones (vim-obsession)
- [x] Keybindings optimizados para Colemak Mod-DH (split 32 teclas)
- [x] Statusline con indicador de sesión activa

### Pendiente — Alta prioridad
- [ ] **conform.nvim** — formateo automático al guardar (prettier + eslint)
- [ ] **nvim-lint** — linting asíncrono (eslint)
- [ ] **which-key.nvim** — overlay visual de atajos (ayuda durante aprendizaje)

### Pendiente — Media prioridad
- [ ] **nvim-dap** — debugging (breakpoints, variables, call stack)
- [ ] **nvim-dap-ui** — interfaz visual para DAP
- [ ] Migración de vim-plug a **lazy.nvim** (carga lazy, más rápido)

### Pendiente — Baja prioridad
- [ ] **oil.nvim** — reemplazar NERDTree por explorador de archivos como buffer
- [ ] **noice.nvim** — UI mejorada para mensajes y cmdline

---

## Notas de arquitectura

- `init.vim` delega todo a `~/.vimrc` para mantener compatibilidad vim/nvim
- La configuración Lua se embebe con bloques `lua << EOF` en el vimrc
- Los keymaps de LSP se activan solo en buffers con servidor LSP adjunto (autocmd `LspAttach`)
- Treesitter se instala async en `VimEnter` (no bloquea el arranque)
