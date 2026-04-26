" mapleader debe definirse ANTES de cualquier mapeo que use <leader>
let mapleader = " "

" ============================================================
" Plugins (vim-plug)
" ============================================================
call plug#begin('~/.vim/plugged')

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }         " fallback disponible
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }  " default

" AI completion
Plug 'github/copilot.vim'

" File tree
Plug 'preservim/nerdtree'

" File manager editable como buffer
Plug 'stevearc/oil.nvim'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocompletion engine + sources
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Formatting
Plug 'stevearc/conform.nvim'

" Editing helpers
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'
Plug 'folke/flash.nvim'           " navegacion rapida tipo easymotion

" Git — gitsigns reemplaza vim-gitgutter (mas rapido, mas features)
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

" Sessions
Plug 'tpope/vim-obsession'

" UI
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'uga-rosa/ccc.nvim'                     " color picker + preview inline
Plug 'stevearc/dressing.nvim'                " popups de input/select elegantes
Plug 'MunifTanjim/nui.nvim'                  " dependencia de noice
Plug 'rcarriga/nvim-notify'                  " notificaciones animadas
Plug 'folke/noice.nvim'                      " UI flotante para cmdline y mensajes
Plug 'folke/which-key.nvim'                  " popup de keymaps al pausar en <leader>
Plug 'SmiteshP/nvim-navic'                   " posicion LSP para breadcrumbs
Plug 'utilyre/barbecue.nvim', { 'tag': '*' } " breadcrumbs en winbar

" Folding mejorado con treesitter/LSP
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

" Animaciones suaves de scroll y cursor
Plug 'echasnovski/mini.animate', { 'tag': '*' }

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Icons — deben cargarse al final para decorar otros plugins
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ============================================================
" Theme — Catppuccin Mocha
" (para volver a Dracula: colorscheme dracula)
" ============================================================
lua << EOF
require('catppuccin').setup({
  flavour    = 'mocha',
  background = { light = 'latte', dark = 'mocha' },
  transparent_background = false,
  custom_highlights = function(colors)
    return {
      Visual = { bg = colors.mauve, fg = colors.base },
    }
  end,
  integrations = {
    treesitter       = true,
    telescope        = { enabled = true },
    bufferline       = true,
    cmp              = true,
    gitsigns         = true,
    indent_blankline = { enabled = true, scope_color = 'lavender' },
    noice            = true,
    notify           = true,
    which_key        = true,
    flash            = true,
    barbecue         = { dim_dirname = true, bold_basename = true, dim_context = false },
    native_lsp = {
      enabled    = true,
      underlines = {
        errors      = { 'undercurl' },
        hints       = { 'undercurl' },
        warnings    = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
})
EOF

set termguicolors
colorscheme catppuccin


" ============================================================
" nvim-web-devicons
" ============================================================
lua << EOF
require('nvim-web-devicons').setup({ default = true })
EOF

" ============================================================
" NERDTree
" ============================================================
let NERDTreeIgnore=[
  \ 'node_modules', '\.git$', '\.DS_Store', '\.next$',
  \ 'dist$', 'build$', 'coverage$', '\.nuxt$',
  \ '\.cache$', '\.turbo$'
  \ ]
let NERDTreeShowHidden=1
let NERDTreeWinSize=32
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=0

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1
  \ && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>E :NERDTreeFind<CR>

" ============================================================
" oil.nvim — file manager editable como buffer
" <leader>o abre panel flotante; dentro: <CR>=abrir, <BS>=subir, q=cerrar
" ============================================================
lua << EOF
require('oil').setup({
  default_file_explorer = false,  -- NERDTree sigue siendo el explorer default
  view_options          = { show_hidden = true },
  keymaps = {
    ['<CR>'] = 'actions.select',
    ['<BS>'] = 'actions.parent',
    ['-']    = 'actions.parent',
    ['_']    = 'actions.open_cwd',
    ['q']    = 'actions.close',
    ['g?']   = 'actions.show_help',
    ['gs']   = 'actions.change_sort',
    ['gx']   = 'actions.open_external',
    ['g.']   = 'actions.toggle_hidden',
  },
  float = {
    padding    = 2,
    max_width  = 80,
    max_height = 30,
    border     = 'rounded',
  },
})

vim.keymap.set('n', '<leader>o', require('oil').open_float,
  { silent = true, desc = 'Oil: file manager flotante' })
EOF

" ============================================================
" Copilot
" ============================================================
let g:copilot_filetypes = {
  \ 'javascript':      v:true,
  \ 'javascriptreact': v:true,
  \ 'typescript':      v:true,
  \ 'typescriptreact': v:true,
  \ 'css':             v:true,
  \ 'scss':            v:true,
  \ 'html':            v:true,
  \ 'json':            v:true,
  \ 'markdown':        v:true,
  \ }

imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")
let g:copilot_no_tab_map = v:true

imap <C-\>  <Plug>(copilot-dismiss)

" ============================================================
" Telescope
" ============================================================
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fr :Telescope oldfiles<CR>
nnoremap <leader>fs :Telescope lsp_document_symbols<CR>

lua << EOF
local telescope = require('telescope')
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      'node_modules', '.git/', '.next/', 'dist/', 'build/',
      'coverage/', '.cache/', '.turbo/'
    },
    layout_config = {
      horizontal = { preview_width = 0.55 }
    },
    preview = {
      treesitter = false,  -- evita el error ft_to_lang removido en Neovim 0.10+
    },
  },
  extensions = {
    fzf = {
      fuzzy                   = true,
      override_generic_sorter = true,
      override_file_sorter    = true,
      case_mode               = 'smart_case',
    },
  },
})
telescope.load_extension('fzf')
EOF

" ============================================================
" bufferline
" ============================================================
lua << EOF
require('bufferline').setup({
  options = {
    mode            = 'buffers',
    numbers         = 'ordinal',
    diagnostics     = 'nvim_lsp',
    show_buffer_icons       = true,
    show_buffer_close_icons = true,
    show_close_icon         = false,
    separator_style         = 'thin',
    always_show_bufferline  = true,
    custom_filter = function(buf)
      return vim.bo[buf].buftype ~= 'terminal'
    end,
    offsets = {
      {
        filetype   = 'NERDTree',
        text       = 'Explorer',
        text_align = 'center',
        separator  = true,
      },
    },
  },
})

vim.keymap.set('n', '<Tab>',   ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    require('bufferline').go_to(i, true)
  end, { silent = true, desc = 'Buffer ' .. i })
end

vim.keymap.set('n', '<leader>x', function()
  local bufnr  = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed <= 1 then
    vim.cmd('enew')
  else
    vim.cmd('BufferLineCyclePrev')
  end
  vim.cmd('bdelete ' .. bufnr)
end, { silent = true, desc = 'Cerrar buffer' })
EOF

" ============================================================
" nvim-treesitter
" ============================================================
lua << EOF
local ts_parsers = {
  'javascript', 'typescript', 'tsx', 'css', 'scss',
  'html', 'json', 'jsonc', 'lua', 'bash',
  'markdown', 'markdown_inline', 'regex', 'vim', 'vimdoc',
}

vim.api.nvim_create_autocmd('VimEnter', {
  once     = true,
  callback = function() require('nvim-treesitter').install(ts_parsers) end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern  = { 'javascript','typescript','tsx','jsx','css','scss','html','json','lua' },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
EOF

" ============================================================
" ccc.nvim — color picker + preview inline
" <leader>cc → abrir picker sobre el color bajo el cursor
" ============================================================
lua << EOF
local ccc = require('ccc')

ccc.setup({
  highlighter = {
    auto_enable = true,
    lsp         = true,
    filetypes   = {
      'css', 'scss', 'html',
      'javascript', 'typescript',
      'javascriptreact', 'typescriptreact',
      'lua', 'vim',
    },
  },
  pickers = {
    ccc.picker.hex,
    ccc.picker.css_rgb,
    ccc.picker.css_hsl,
    ccc.picker.css_hwb,
    ccc.picker.css_name,
  },
  outputs = {
    ccc.output.hex,
    ccc.output.css_rgb,
    ccc.output.css_hsl,
  },
})

vim.keymap.set('n', '<leader>cc', ':CccPick<CR>',
  { silent = true, desc = 'CCC: color picker' })
EOF

" ============================================================
" nvim-notify — notificaciones animadas
" ============================================================
lua << EOF
require('notify').setup({
  background_colour = '#1e1e2e',  -- catppuccin mocha base
  render   = 'compact',
  timeout  = 3000,
  max_width = 50,
  stages   = 'slide',
})
EOF

" ============================================================
" noice.nvim — cmdline flotante, mensajes y notificaciones
" ============================================================
lua << EOF
require('noice').setup({
  -- Desactivar el popup flotante para input()/inputlist() — NERDTree (m)
  -- usará el comportamiento nativo de Neovim (opciones fijas en la parte baja)
  input = { enabled = false },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown']                = true,
      ['cmp.entry.get_documentation']                  = true,
    },
  },
  presets = {
    bottom_search         = true,  -- busqueda / clasica en la parte inferior
    command_palette       = true,  -- cmdline centrada estilo palette
    long_message_to_split = true,  -- mensajes largos abren un split
    lsp_doc_border        = true,  -- borde en hover LSP
  },
  routes = {
    -- Silenciar el mensaje "N lines written" al guardar
    { filter = { event = 'msg_show', kind = '', find = 'written' }, opts = { skip = true } },
  },
})

-- Ver historial de notificaciones
vim.keymap.set('n', '<leader>nh', ':Noice telescope<CR>',
  { silent = true, desc = 'Noice: historial de notificaciones' })
EOF

" ============================================================
" dressing.nvim — input/select con UI moderna
" ============================================================
lua << EOF
require('dressing').setup({
  input  = {
    default_prompt = '> ',
    win_options    = { winblend = 0 },
  },
  select = {
    backend = { 'telescope', 'builtin' },
  },
})
EOF

" ============================================================
" which-key.nvim — popup de keymaps al pausar en <leader>
" ============================================================
lua << EOF
local wk = require('which-key')
wk.setup({ delay = 500 })

-- Etiquetas de grupo para los prefijos mas usados
wk.add({
  { '<leader>g', group = 'git' },
  { '<leader>f', group = 'find / telescope' },
  { '<leader>t', group = 'terminal' },
  { '<leader>c', group = 'code action' },
  { '<leader>r', group = 'rename' },
})
EOF

" ============================================================
" flash.nvim — navegacion rapida con 2-3 letras
" Nota: 's' reemplaza vim 'substitute' (equivalente a cl)
" ============================================================
lua << EOF
require('flash').setup({
  modes = {
    char = { enabled = false },  -- no interferir con f/t/F/T nativos
  },
})

vim.keymap.set({ 'n', 'x', 'o' }, 's',     function() require('flash').jump()             end, { desc = 'Flash: saltar a' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S',     function() require('flash').treesitter()        end, { desc = 'Flash: treesitter' })
vim.keymap.set('o',               'r',     function() require('flash').remote()             end, { desc = 'Flash: remote' })
vim.keymap.set({ 'o', 'x' },      'R',     function() require('flash').treesitter_search()  end, { desc = 'Flash: treesitter search' })
vim.keymap.set('c',               '<C-s>', function() require('flash').toggle()             end, { desc = 'Flash: toggle en busqueda' })
EOF

" ============================================================
" LSP + nvim-cmp + nvim-navic (breadcrumb data)
" ============================================================
lua << EOF
local cmp     = require('cmp')
local luasnip = require('luasnip')
local navic   = require('nvim-navic')

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ select = false }),
    ['<C-n>']     = cmp.mapping.select_next_item(),
    ['<C-p>']     = cmp.mapping.select_prev_item(),
    ['<C-d>']     = cmp.mapping.scroll_docs(4),
    ['<C-u>']     = cmp.mapping.scroll_docs(-4),
  }),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'luasnip',  priority = 750  },
    },
    {
      { name = 'buffer',   priority = 500  },
      { name = 'path',     priority = 250  },
    }
  ),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({
  virtual_text     = true,
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
})

vim.lsp.config('ts_ls',  { capabilities = capabilities })
vim.lsp.config('cssls',  { capabilities = capabilities })
vim.lsp.config('html',   { capabilities = capabilities })
vim.lsp.config('jsonls', {
  capabilities = capabilities,
  settings = { json = { validate = { enable = true } } },
})
vim.lsp.enable({ 'ts_ls', 'cssls', 'html', 'jsonls' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local o      = { buffer = ev.buf, silent = true }
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,    o)
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,   o)
    vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, o)
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,    o)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,        o)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,   o)
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,  o)
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,  o)
    vim.keymap.set('n', '<leader>d',  vim.diagnostic.open_float, o)

    -- K: peek fold si existe, sino hover LSP
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end, { buffer = ev.buf, silent = true, desc = 'Peek fold / LSP hover' })

    -- navic para breadcrumbs (requiere documentSymbol)
    if client and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, ev.buf)
    end
  end,
})
EOF

" ============================================================
" conform.nvim — formateo con Prettier
" <leader>p  → formatear buffer actual
" ============================================================
lua << EOF
require('conform').setup({
  formatters_by_ft = {
    javascript      = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript      = { 'prettier' },
    typescriptreact = { 'prettier' },
    css             = { 'prettier' },
    scss            = { 'prettier' },
    html            = { 'prettier' },
    json            = { 'prettier' },
    jsonc           = { 'prettier' },
    markdown        = { 'prettier' },
    yaml            = { 'prettier' },
  },
  -- Descomenta para formatear al guardar:
  -- format_on_save = { timeout_ms = 2000, lsp_fallback = true },
})

vim.keymap.set({ 'n', 'v' }, '<leader>p', function()
  require('conform').format({ async = true, lsp_fallback = true })
end, { silent = true, desc = 'Prettier: formatear' })
EOF

" ============================================================
" barbecue.nvim — breadcrumbs en winbar (clase > funcion > ...)
" ============================================================
lua << EOF
require('barbecue').setup({
  theme        = 'catppuccin',
  attach_navic = false,   -- se adjunta manualmente en LspAttach
  create_autocmd = true,
  show_dirname  = false,
  show_basename = true,
  show_modified = true,
})
EOF

" ============================================================
" nvim-ufo — folding con treesitter/LSP
" zR=abrir todo, zM=cerrar todo, za=toggle fold
" ============================================================
lua << EOF
vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99   -- abiertos por defecto al arrancar
vim.o.foldlevelstart = 99
vim.o.foldenable     = true

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
  -- Muestra "N lines" al lado del fold cerrado
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix      = ('  %d lines'):format(endLnum - lnum)
    local sufWidth    = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth    = 0
    for _, chunk in ipairs(virtText) do
      local chunkText  = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        table.insert(newVirtText, { chunkText, chunk[2] })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end,
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds,          { desc = 'Abrir todos los folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds,         { desc = 'Cerrar todos los folds' })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds,  { desc = 'Abrir folds (excepto...)' })
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith,        { desc = 'Cerrar folds con nivel' })
EOF

" ============================================================
" mini.animate — animaciones suaves de scroll y cursor
" ============================================================
lua << EOF
local animate = require('mini.animate')
animate.setup({
  scroll = { enable = false },  -- desactivado: choca con el scroll inercial del Magic Mouse
  cursor = { enable = false },  -- desactivado: puede causar lag visual con trackpad
  resize = {
    enable = true,
    timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
  },
  open  = { enable = false },
  close = { enable = false },
})
EOF

" ============================================================
" Ctrl+Click / Space+gt — abrir definicion en nueva tab
" ============================================================
set mouse=a

lua << EOF
local function open_definition_in_new_tab()
  local has_lsp = #vim.lsp.get_clients({ bufnr = 0 }) > 0
  if not has_lsp then
    vim.cmd('tab split')
    pcall(vim.cmd, 'normal! gf')
    return
  end

  vim.lsp.buf.definition({
    on_list = function(opts)
      local items = opts and opts.items
      if not items or #items == 0 then
        vim.notify('Definicion no encontrada', vim.log.levels.WARN)
        return
      end
      vim.cmd('tab split')
      local item = items[1]
      if item.filename then
        vim.cmd('edit ' .. vim.fn.fnameescape(item.filename))
      end
      if item.lnum then
        vim.api.nvim_win_set_cursor(0, { item.lnum, math.max(0, (item.col or 1) - 1) })
      end
    end,
  })
end

vim.keymap.set('n', '<C-LeftMouse>', function()
  local pos = vim.fn.getmousepos()
  if pos.winid ~= 0 then
    vim.api.nvim_set_current_win(pos.winid)
    vim.api.nvim_win_set_cursor(pos.winid, { pos.line, math.max(0, pos.column - 1) })
  end
  open_definition_in_new_tab()
end, { silent = true })

vim.keymap.set('n', '<leader>gt', open_definition_in_new_tab,
  { silent = true, desc = 'Ir a definicion en nueva tab' })
EOF

" ============================================================
" Comment.nvim + nvim-ts-context-commentstring
" ============================================================
lua << EOF
require('ts_context_commentstring').setup({ enable_autocmd = false })

require('Comment').setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
EOF

" ============================================================
" nvim-autopairs
" ============================================================
lua << EOF
require('nvim-autopairs').setup({ check_ts = true })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
EOF

" ============================================================
" gitsigns.nvim — reemplaza vim-gitgutter
" Mismos atajos + blame inline con <leader>gB
" ============================================================
lua << EOF
require('gitsigns').setup({
  signs = {
    add          = { text = '▎' },
    change       = { text = '▎' },
    delete       = { text = '▁' },
    topdelete    = { text = '▔' },
    changedelete = { text = '▎' },
    untracked    = { text = '┆' },
  },
  current_line_blame = false,
  current_line_blame_opts = {
    delay        = 500,
    virt_text_pos = 'eol',
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts        = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navegar hunks (mismos atajos que gitgutter)
    map('n', ']g', function()
      if vim.wo.diff then return ']g' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Siguiente hunk' })

    map('n', '[g', function()
      if vim.wo.diff then return '[g' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Hunk anterior' })

    map('n', '<leader>gp', gs.preview_hunk,              { desc = 'Git: preview hunk' })
    map('n', '<leader>gs', gs.stage_hunk,                { desc = 'Git: stage hunk' })
    map('n', '<leader>gu', gs.reset_hunk,                { desc = 'Git: undo hunk' })
    map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Git: blame inline toggle' })
    map('n', '<leader>gS', gs.stage_buffer,              { desc = 'Git: stage buffer completo' })
    map('n', '<leader>gR', gs.reset_buffer,              { desc = 'Git: reset buffer completo' })
    map('n', '<leader>gi', gs.diffthis,                  { desc = 'Git: diff este archivo' })

    -- text object: ih selecciona el hunk actual en visual/operator mode
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Seleccionar hunk' })
  end,
})
EOF

" ============================================================
" vim-fugitive
" ============================================================
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gL :Git log --oneline<CR>

" ============================================================
" diffview.nvim
" ============================================================
lua << EOF
require('diffview').setup({
  enhanced_diff_hl = true,
  view = {
    default      = { layout = 'diff2_horizontal' },
    merge_tool   = { layout = 'diff3_horizontal' },
    file_history = { layout = 'diff2_horizontal' },
  },
  file_panel = {
    listing_style = 'tree',
    win_config    = { width = 35 },
  },
})
EOF

nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gD :DiffviewClose<CR>
nnoremap <leader>gf :DiffviewFileHistory %<CR>
nnoremap <leader>gH :DiffviewFileHistory<CR>

" ============================================================
" vim-obsession (sesiones)
" ============================================================
nnoremap <leader>ss :Obsession .session.vim<CR>
nnoremap <leader>sr :source .session.vim<CR>

" ============================================================
" lualine
" ============================================================
lua << EOF
require('lualine').setup({
  options = {
    theme                = 'catppuccin',
    icons_enabled        = true,
    component_separators = { left = '|', right = '|' },
    section_separators   = { left = '',  right = ''  },
    globalstatus         = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      {
        function()
          if vim.fn.exists('*ObsessionStatus') == 1 then
            return vim.fn['ObsessionStatus']('[S]', '')
          end
          return ''
        end,
      },
      'location',
    },
  },
})
EOF

" ============================================================
" indent-blankline
" ============================================================
lua << EOF
require('ibl').setup({
  indent = { char = '│' },
  scope  = { enabled = true },
})
EOF

" ============================================================
" General
" ============================================================
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

" ============================================================
" UI
" ============================================================
syntax on
set number
set relativenumber
set cursorline
set signcolumn=yes
set scrolloff=8
set colorcolumn=80
set showmode
set showcmd
set wildmenu
set laststatus=2

" ============================================================
" Indentation
" ============================================================
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" ============================================================
" Search
" ============================================================
set hlsearch
set incsearch
set ignorecase
set smartcase

" ============================================================
" Files
" ============================================================
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir
set clipboard=unnamed

" ============================================================
" Splits
" ============================================================
set splitbelow
set splitright

" ============================================================
" Key mappings
" ============================================================

set ttimeoutlen=0

nnoremap <Esc> :nohlsearch<CR>

" Navegar entre splits — Colemak Mod-DH home row
nnoremap <leader>a <C-w>h
nnoremap <leader>n <C-w>j
nnoremap <leader>u <C-w>k
nnoremap <leader>i <C-w>l

" Better indentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" Mover lineas/bloques — Alt+n/e (posicion fisica j/k en Colemak) y Alt+flechas
nnoremap <A-n>    :m .+1<CR>==
nnoremap <A-e>    :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up>   :m .-2<CR>==
vnoremap <A-n>    :m '>+1<CR>gv=gv
vnoremap <A-e>    :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up>   :m '<-2<CR>gv=gv
inoremap <A-n>    <Esc>:m .+1<CR>==gi
inoremap <A-e>    <Esc>:m .-2<CR>==gi
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up>   <Esc>:m .-2<CR>==gi

" Terminal lateral derecho
nnoremap <leader>tc :botright 85vsplit \| terminal claude<CR>i
nnoremap <leader>tg :botright 85vsplit \| terminal gemini<CR>i
nnoremap <leader>tt :botright 85vsplit \| terminal<CR>i
tnoremap <Esc><Esc> <C-\><C-n>
