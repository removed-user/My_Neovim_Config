# Lua Types in a Neovim Plugin

In a Neovim Lua plugin, available types span three distinct layers: **standard Lua 5.1/LuaJIT runtime types**, **Neovim API/Vimscript bridge types**, and **LuaLS (LuaCATS) annotation types**.

---

## 1. Standard Lua 5.1 & LuaJIT Runtime Types

Neovim embeds LuaJIT (compatible with Lua 5.1). Every value at runtime resolves via `type(v)` to one of the **8 core Lua types** (plus LuaJIT's `cdata`):

- **`nil`**: Represents the absence of a value or an unset table key.
- **`boolean`**: `true` or `false` (in Lua, `0` and `""` evaluate as truthy).
- **`number`**: Double-precision floating-point numbers (`double`), plus 64-bit integer literals (`1LL`, `1ULL`) via LuaJIT FFI.
- **`string`**: Immutable sequences of bytes (8-bit clean).
- **`function`**: First-class Lua functions or C functions (`vim.api.*` bindings).
- **`table`**: The sole composite data structure, functioning simultaneously as 1-indexed arrays, dictionaries (hash maps), and objects/namespaces via metatables.
- **`thread`**: Independent execution coroutines created with `coroutine.create()`.
- **`userdata`**: Raw C memory blocks exposed to Lua:
  - **Full userdata**: Garbage-collected blocks with metatables (e.g., `luv` libuv handles like `uv_timer_t` or `uv_fs_t`).
  - **Light userdata**: Raw C pointers without metatables.
- **`cdata` (LuaJIT-specific)**: C data structures, pointers, and primitives allocated through the `ffi` library (e.g., `ffi.new("int")`).

---

## 2. Neovim C API & Vimscript Bridge Types

When interacting with `vim.api.*` or `vim.fn.*`, Lua values marshal across Neovim's internal MessagePack/API type system:

- **Primitives**:
  - `Nil`
  - `Boolean`
  - `Integer` (signed 64-bit `int64_t`)
  - `Float` (IEEE 754 `double`)
  - `String`
- **Containers**:
  - `Array`: 1-indexed contiguous Lua list tables.
  - `Dict`: Lua tables with string keys.
- **Special Sentinels**:
  - `vim.NIL`: Represents `v:null` or `nil` inside tables where standard Lua `nil` would delete the key.
  - `vim.empty_dict()`: Forces an empty `{}` to serialize as a Dictionary rather than an Array.
- **Typed Handles (`EXT` types)**: Opaque integer handles representing Neovim objects (`Buffer`, `Window`, `Tabpage`).
- **Callable References (`Luaref` / `Callable`)**: Internal references to Lua functions or callable tables passed into API functions like `vim.api.nvim_create_autocmd` or `vim.keymap.set`.

---

## 3. LuaLS / LuaCATS Annotation Types (Static Analysis)

When annotating a plugin with `---@type` or `---@param` for `lua_ls` (and tools like `lazydev.nvim`), Neovim's runtime (`\$VIMRUNTIME/lua/vim/`) exposes built-in type aliases alongside standard LuaCATS primitives:

- **LuaCATS Primitives & Modifiers**:
  - Core: `any`, `unknown`, `never`, `void`, `nil`, `boolean`, `number`, `integer`, `string`, `table`, `function`, `thread`, `userdata`, `lightuserdata`
  - Unions & Literals: `string|number`, `"n"|"v"|"i"`
  - Tuples & Generics: `[integer, integer]`, `T[]`, `table<string, any>`
- **Neovim Core Aliases**:
  - **API & Vimscript**: `vim.api.*`, `vim.fn.*`
  - **Libuv (`uv.*`)**: `uv.uv_timer_t`, `uv.uv_pipe_t`, `uv.uv_fs_event_t`, `uv.uv_process_t`
  - **LSP (`vim.lsp.*`)**: `vim.lsp.Client`, `vim.lsp.Config`, `lsp.Handler`
  - **Tree-sitter (`vim.treesitter.*`)**: `TSNode`, `TSTree`, `vim.treesitter.LanguageTree`, `vim.treesitter.Query`
  - **Options & Keysets**: `vim.bo`, `vim.wo`, `vim.go`, `vim.api.keyset.create_autocmd`, `vim.api.keyset.keymap`
