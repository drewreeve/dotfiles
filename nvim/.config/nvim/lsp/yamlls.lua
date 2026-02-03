return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
