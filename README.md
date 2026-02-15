# enhansi

Color schemes that work with your terminal palette.

## Neovim

Use your favorite package manager to set up. For customization:

```lua
-- defaults shown below
require('enhansi').setup({
  custom_colors = {
    -- background = false to disable background and use foreground colors
    background = {
      red = 52, -- or override these to use other colors in the 8-bit color space
      green = 22,
      blue = 17,
    },
    special = {
      red = "red", -- you can use hex codes for these since neovim won't use your chosen colors (see below)
      yellow = "yellow",
      blue = "blue",
      cyan = "cyan",
      green = "green",
    },
  },
})
```

### Extended Color Palette

I like a nice background for diff views. Unfortunately, 16 colors isn't really enough to have a bright, dim, and background colors. So I've borrowed some colors from the 8-bit color space:

- 17 (very dark blue) for `DiffChange`
- 22 (very dark lime green) for `DiffAdd`
- 52 (very dark red) for `DiffDelete`

Look into your terminal emulator docs for how to override the default hex colors for these, since not all support setting colors outside of the first 16. If your emulator doesn't support this, diffs may not look great with your terminal colors. You can set `custom_colors.background = false` to switch foreground-based diff coloring, or use another 8-bit color which matches your terminal colorscheme better.

### Undercurl Color Support

Unfortunately, due to [this issue](https://github.com/neovim/neovim/issues/8583), there is currently no way to provide undercurls with an 8-bit color. I've opted to use the named colors (red, yellow, cyan, blue) for undercurls in the `Spell*`/`DiagnosticUnderline*` highlights, which will use 24-bit color space. This means that your undercurls may be a bit jarring for your terminal colors. You can override with hex colors if it's too ugly.

## Bat

[enhansi.tmTheme](./enhansi.tmTheme) can be used as a bat theme. See the [bat README](https://github.com/sharkdp/bat/blob/master/README.md#adding-new-themes) for instructions.
