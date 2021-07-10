require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Class = '',
      Color = '',
      Constant = '',
      Constructor = '',
      Enum = '了',
      EnumMember = '',
      File = '',
      Folder = '',
      Function = '',
      Interface = 'ﰮ',
      Keyword = '',
      Method = 'ƒ',
      Module = '',
      Property = '',
      Snippet = '﬌',
      Struct = '',
      Text = '',
      Unit = '',
      Value = '',
      Variable = '',
      Vsnip = '',
    },
})
