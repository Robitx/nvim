return {
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
        QF1008 = false,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
}
