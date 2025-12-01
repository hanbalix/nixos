require('config.options')
require('config.keybinds')
require('config.lazy')
require("lazy").setup({
  spec = {
    { import = "plugins" },  -- This line loads ALL lua/plugins/*.lua
  }
})

