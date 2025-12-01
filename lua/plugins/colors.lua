local function enable_transparency()
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

return {
    { "rose-pine/neovim", name = 'rose-pine', priority = 1000, config = function()
        if load_saved_theme() == 'rose-pine' then
            vim.cmd.colorscheme('rose-pine')
        end
        setup_theme()
    end, },
    { "Mofiqul/vscode.nvim", name = 'vscode', priority = 1000, config = function()
        if load_saved_theme() == 'vscode' then
            vim.cmd.colorscheme('vscode')
        end
        setup_theme()
    end, },
    { "folke/tokyonight.nvim", name = 'tokyonight', priority = 1000, config = function()
        if load_saved_theme() == 'tokyonight' then
            vim.cmd.colorscheme('tokyonight')
        end
        setup_theme()
    end, },
    { "neanias/everforest-nvim", name = 'everforest', priority = 1000, config = function()
        if load_saved_theme() == 'everforest' then
            vim.cmd.colorscheme('everforest')
        end
        setup_theme()
    end, },
    { "everviolet/nvim", name = 'everviolet', priority = 1000, config = function()
        if load_saved_theme() == 'everviolet' then
            vim.cmd.colorscheme('everviolet')
        end
        setup_theme()
    end, },
    { "catppuccin/nvim", name = 'catppuccin', priority = 1000, config = function()
        if load_saved_theme() == 'catppuccin' then
            vim.cmd.colorscheme('catppuccin')
        end
        setup_theme()
    end, },
    { "xero/miasma.nvim", name = 'miasma', priority = 1000, config = function()
        if load_saved_theme() == 'miasma' then
            vim.cmd.colorscheme('miasma')
        end
        setup_theme()
    end, },
    { "rebelot/kanagawa.nvim", name = 'kanagawa', priority = 1000, config = function()
        if load_saved_theme() == 'kanagawa' then
            vim.cmd.colorscheme('kanagawa')
        end
        setup_theme()
    end, },
    { "thesimonho/kanagawa-paper.nvim", name = 'kanagawa-paper', priority = 1000, config = function()
        if load_saved_theme() == 'kanagawa-paper' then
            vim.cmd.colorscheme('kanagawa-paper')
        end
        setup_theme()
    end, },
    { "ellisonleao/gruvbox.nvim", name = 'gruvbox', priority = 1000, config = function()
        if load_saved_theme() == 'gruvbox' then
            vim.cmd.colorscheme('gruvbox')
        end
        setup_theme()
    end, },
    { "luisiacc/gruvbox-baby", name = 'gruvbox-baby', priority = 1000, config = function()
        if load_saved_theme() == 'gruvbox-baby' then
            vim.cmd.colorscheme('gruvbox-baby')
        end
        setup_theme()
    end, },
    { "rmehri01/onenord.nvim", name = 'onenord', priority = 1000, config = function()
        if load_saved_theme() == 'onenord' then
            vim.cmd.colorscheme('onenord')
        end
        setup_theme()
    end, },
    { "alexvzyl/nordic.nvim", name = 'nordic', priority = 1000, config = function()
        if load_saved_theme() == 'nordic' then
            vim.cmd.colorscheme('nordic')
        end
        setup_theme()
    end, },
    { "savq/melange-nvim", name = 'melange', priority = 1000, config = function()
        if load_saved_theme() == 'melange' then
            vim.cmd.colorscheme('melange')
        end
        setup_theme()
    end, },
    { "jacoborus/tender.vim", name = 'tender', priority = 1000, config = function()
        if load_saved_theme() == 'tender' then
            vim.cmd.colorscheme('tender')
        end
        setup_theme()
    end, },
    { "bluz71/vim-moonfly-colors", name = 'moonfly', priority = 1000, config = function()
        if load_saved_theme() == 'moonfly' then
            vim.cmd.colorscheme('moonfly')
        end
        setup_theme()
    end, },
    { "bluz71/vim-nightfly-colors", name = 'nightfly', priority = 1000, config = function()
        if load_saved_theme() == 'nightfly' then
            vim.cmd.colorscheme('nightfly')
        end
        setup_theme()
    end, },
    { "vague-theme/vague.nvim", name = 'vague', priority = 1000, config = function()
        if load_saved_theme() == 'vague' then
            vim.cmd.colorscheme('vague')
        end
        setup_theme()
    end, },
    { "olivercederborg/poimandres.nvim", name = 'poimandres', priority = 1000, config = function()
        if load_saved_theme() == 'poimandres' then
            vim.cmd.colorscheme('poimandres')
        end
        setup_theme()
    end, },
    { "rockerboo/boo-colorscheme-nvim", name = 'boo', priority = 1000, config = function()
        if load_saved_theme() == 'boo' then
            vim.cmd.colorscheme('boo')
        end
        setup_theme()
    end, },
    { "datsfilipe/vesper.nvim", name = 'vesper', priority = 1000, config = function()
        if load_saved_theme() == 'vesper' then
            vim.cmd.colorscheme('vesper')
        end
        setup_theme()
    end, },
    { "ramojus/mellifluous.nvim", name = 'mellifluous', priority = 1000, config = function()
        if load_saved_theme() == 'mellifluous' then
            vim.cmd.colorscheme('mellifluous')
        end
        setup_theme()
    end, },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                },
            })
        end,
    },
}

