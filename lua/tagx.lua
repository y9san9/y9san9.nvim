-- Tags Extended Mini Plugin
--
-- You often have to work in monorepos. Moreover, now that we have LSPs Tags are
-- often used by people in extremely large projects (in my case its 12 millions
-- LoC project).
--
-- It is a pity that there's no builtin way search for tags of specific kind or
-- under specific directory. This plugin is a fix for that:
--
-- :tag Tag                    # simple tag search as before
-- :tag Tag;path=libs/**/java  # specific folder (respects search options)
-- :tag Tag;kind=f             # with specific kind
--
-- Or you can use both.

vim.o.tagfunc = "v:lua.TagxTagfunc"

function TagxTagfunc(pattern, flags, info)
  local parts = vim.split(pattern, ";")
  local real_pattern = parts[1]
  local path_filter, kind_filter

  for i = 2, #parts do
    local k, v = parts[i]:match("(%w+)=(%S+)")
    if k == "path" then path_filter = v end
    if k == "kind" then kind_filter = v end
  end

  local tags = vim.fn.taglist(real_pattern)

  return vim.tbl_filter(function(t)
    local path_ok = not path_filter or vim.fn.matchstr(t.filename, path_filter) ~= ""
    local kind_ok = not kind_filter or t.kind == kind_filter
    return path_ok and kind_ok
  end, tags)
end
