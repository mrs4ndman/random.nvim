## Random compilation of functions that seem useful :D

### Installation ↓
- With `lazy.nvim`
```lua
{
  "mrs4ndman/random.nvim",
  lazy = false,
  config = function()
    require("random")
  end,
}
```

- Putting strings like `;`, `}` and any other (with spaces) at the beginning / end of a line:
    - Takes strings as arguments
    - It doesn't work well with multiple of the same string at the beginning / end

```lua
vim.keymap.set("n", "<leader>;", function()
  require("random").put_at_end(";")
end)

vim.keymap.set("n", "<leader>}", function()
  require("random").put_at_end("}")
end)

vim.keymap.set("n", "<leader>-", function()
  require("random").put_at_beginning("- ")
end)
```

- Increasing / decreasing current line Markdown header level 
```lua
vim.keymap.set("n", "<leader>hi", function()
  require("random").increase_header()
end)

vim.keymap.set("n", "<leader>hd", function()
  require("random").decrease_header()
end)
```

- Create Markdown codeblocks of the desired language via `vim.ui.input` and dropping you inside them
```lua
vim.keymap.set("n", "<leader>C", function()
  require("random").md_block()
end)
```

- Swap current character under the cursor with the previous / next one
```lua
vim.keymap.set("n", "<leader>sb", function()
  require("random").swap_char_backwards()
end)

vim.keymap.set("n", "<leader>sf", function()
  require("random").swap_char_forwards()
end)
```

<br />
<!---->
<!-- ### Examples (Missing the GIFs, sorry ;) ) -->
<!---->
<!-- <details> -->
<!--     <summary>Put at beginning / end</summary> -->
<!-- </details> -->
<!-- <br /> -->
<!---->
<!-- <details> -->
<!--     <summary>Increase / decrease markdown header level</summary> -->
<!-- </details> -->
<!-- <br /> -->
<!---->
<!-- <details> -->
<!--     <summary><code>vim.ui.input</code> markdown codeblocks</summary> -->
<!-- </details> -->
<!-- <br /> -->
<!---->
<!-- <details> -->
<!--     <summary>Swap current character with previous / next one</summary> -->
<!-- </details> -->
<!-- <br /> -->



