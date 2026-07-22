---@module 'lazy'
---@type LazySpec
return {
      -- Add/delete/replace surroundings (brackets, quotes, etc.)

      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']

      require('mini.surround').setup()

        custom_surrounds = {

          [M - v] = {
            add = { '${', '}' },
            find = '%${.-}',
            delete = '^(%%${)().-(%%})()$',
            change = {
              target = '^(%%${)().-(%%})()$',
            },
          },
         },

}
