return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.sum", "go.mod", ".git" },
    settings = {
        gopls = {
            gofumpt = true,
        },
    },
}
