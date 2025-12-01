local set = vim.opt_local              -- Current JSON buffer only

set.shiftwidth = 2                     -- 2 spaces for >>/<< indent
set.tabstop = 2                        -- Tab key = 2 spaces  
set.softtabstop = 2                    -- Backspace deletes 2 spaces
set.expandtab = true                   -- Tab → spaces (never real tabs)

set.number = true                      -- Line numbers
set.relativenumber = true              -- Relative numbers (j/k motions)

return {}
