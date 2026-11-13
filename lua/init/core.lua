-- [[ Setting options ]]
require 'config.core.globals'

require 'config.core.options'

-- [[ Basic Keymaps ]]
require 'config.core.keymaps'

require 'config.core.autocmds'

-- [[ Re-Install runtime files ]]
require 'init.runtimepath'
-- [[ Install `lazy.nvim` plugin manager ]]
require 'init.lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'config.lazy.lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
