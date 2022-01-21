local nightfox = require("nightfox")

nightfox.setup(
    {
        alt_nc = true,
        inverse = {
            match_paren = true,
            visual = true,
            search = true
        }
    }
)
nightfox.load()
