return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      -- We push the adapter into the list inside the function
      -- This ensures it only runs AFTER the plugins are downloaded
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require("neotest-vitest")({
          filter_dir = function(name)
            return name ~= "node_modules"
          end,
        })
      )
    end,
  },
}
