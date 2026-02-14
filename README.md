# enhansi

Color schemes that work with your terminal palette.

## Neovim

Use your favorite package manager to set up. For customization:

```lua
-- defaults shown below
require('enhansi').setup({
    -- when true, uses extended colors for diff background (see below); otherwise, sets foreground to red/green/blue
    extended = true,
    -- when supplied, these will be set for the gui colors. This gets around the ctermul issue, but you need a way to get the actual hex colors into your config
    rgb_colors = {
        -- black, red, green, yellow, blue, magenta, cyan, gray (darkwhite), dim (brightblack), white
        dark = {
            -- red, green, yellow, blue, magenta, cyan
        }
        bg = {
            -- red, green, blue
        }
    }
})
```

### Extended Color Palette

I like a nice background for diff views. Unfortunately, 16 colors isn't really enough to have a bright, dim, and background colors. So I've borrowed some colors from the 8-bit color space:

- 17 (very dark blue) for `DiffChange`
- 22 (very dark lime green) for `DiffAdd`
- 52 (very dark red) for `DiffDelete`

Look into your terminal emulator docs for how to override the default hex colors for these, since not all support setting colors outside of the first 16. If your emulator doesn't support this, diffs may not look great with your terminal colors. You can set `extended = false` to switch foreground-based diff coloring.

### Undercurl Color support

Unfortunately, due to [this issue](https://github.com/neovim/neovim/issues/8583), there is currently no way to provide undercurls with an 8-bit color. I've opted to use the named colors (red, yellow, cyan, blue) for undercurls in the `Spell*`/`DiagnosticUnderline*` highlights, which will use 24-bit color space. This means that your undercurls may be a bit jarring for your terminal colors. This is mostly why the `rgb_colors` option exists.

## Bat

[enhansi.tmTheme](./enhansi.tmTheme) can be used as a bat theme. See the [bat README](https://github.com/sharkdp/bat/blob/master/README.md#adding-new-themes) for instructions.
