vim.filetype.add({
  pattern = {
    [".*/defaults/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/inventory%.ya?ml"] = "yaml.ansible",
    [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
    [".*/playbook.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/defaults/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/meta/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/site%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
  },
})
vim.treesitter.language.register("yaml", "yaml.ansible")
