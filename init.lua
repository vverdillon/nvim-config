require("core")
require("config.lazy")

-- .h considered as C file
vim.filetype.add({
    extension = {
        h = "c",
    },
})
