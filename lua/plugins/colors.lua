local function enable_transparency()
    -- Uncomment if you want transparency enabled by default
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end

local function setup_theme()
    vim.cmd('hi Directory guibg=NONE')
    vim.cmd('hi SignColumn guibg=NONE')
    -- enable_transparency()
end

local persist_file = vim.fn.stdpath('data') .. '/colorscheme.txt'

local function save_colorscheme(name)
    local f = io.open(persist_file, 'w')
    if f then
        f:write(name)
        f:close()
    end
end

local function load_saved_theme()
    local f = io.open(persist_file, 'r')
    if f then
        local theme = f:read('*l')
        f:close()
        return theme
    end
    return nil
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        if vim.g.colors_name then
            save_colorscheme(vim.g.colors_name)
        end
        setup_theme()

        local ok, lualine = pcall(require, 'lualine')
        if ok then
            lualine.refresh()
        end
    end,
})

local themes = {
    { "rose-pine/neovim", name = 'rose-pine', priority = 1000 },
    { "Mofiqul/vscode.nvim", name = 'vscode', priority = 1000 },
    { "folke/tokyonight.nvim", name = 'tokyonight', priority = 1000 },
    { "neanias/everforest-nvim", name = 'everforest', priority = 1000 },
    { "everviolet/nvim", name = 'everviolet', priority = 1000 },
    { "catppuccin/nvim", name = 'catppuccin', priority = 1000 },
    { "xero/miasma.nvim", name = 'miasma', priority = 1000 },
    { "rebelot/kanagawa.nvim", name = 'kanagawa', priority = 1000 },
    { "thesimonho/kanagawa-paper.nvim", name = 'kanagawa-paper', priority = 1000 },
    { "ellisonleao/gruvbox.nvim", name = 'gruvbox', priority = 1000 },
    { "luisiacc/gruvbox-baby", name = 'gruvbox-baby', priority = 1000 },
    { "rmehri01/onenord.nvim", name = 'onenord', priority = 1000 },
    { "alexvzyl/nordic.nvim", name = 'nordic', priority = 1000 },
    { "savq/melange-nvim", name = 'melange', priority = 1000 },
    { "jacoborus/tender.vim", name = 'tender', priority = 1000 },
    { "bluz71/vim-moonfly-colors", name = 'moonfly', priority = 1000 },
    { "bluz71/vim-nightfly-colors", name = 'nightfly', priority = 1000 },
    { "vague-theme/vague.nvim", name = 'vague', priority = 1000 },
    { "olivercederborg/poimandres.nvim", name = 'poimandres', priority = 1000 },
    { "rockerboo/boo-colorscheme-nvim", name = 'boo', priority = 1000 },
    { "datsfilipe/vesper.nvim", name = 'vesper', priority = 1000 },
    { "ramojus/mellifluous.nvim", name = 'mellifluous', priority = 1000 },
}

-- Add setup config for each theme to call setup_theme on load
for _, theme in ipairs(themes) do
    theme.config = function() setup_theme() end
end

-- Return plugin specs normally (do not apply colorscheme here)
table.insert(themes, {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require('lualine').setup({
            options = { theme = 'auto' },
        })
    end,
})

-- Function to load saved colorscheme after all plugins
local function apply_saved_colorscheme()
    local theme = load_saved_theme()
    if theme then
        local ok, err = pcall(vim.cmd.colorscheme, theme)
        if not ok then
            print("Warning: Failed to load saved colorscheme: " .. theme)
        else
            setup_theme()
        end
    else
        vim.cmd.colorscheme('rose-pine')
        setup_theme()
    end
end

-- Schedule applying the saved colorscheme to run after startup
vim.schedule(apply_saved_colorscheme)

return themes

