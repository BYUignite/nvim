local M = {}

local function apply_patch_if_needed(repo, target, patch, predicate, label)
  if vim.fn.filereadable(target) == 0 then
    return false, label .. " target file not found: " .. target
  end

  if vim.fn.filereadable(patch) == 0 then
    return false, label .. " patch file not found: " .. patch
  end

  local lines = vim.fn.readfile(target)
  local contents = table.concat(lines, "\n")
  local needs_patch = predicate(contents)

  if not needs_patch then
    return true, label .. " patch not needed"
  end

  local result = vim.system({ "git", "-C", repo, "apply", patch }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ""
    local stdout = result.stdout or ""
    return false, label .. " patch failed\nstderr: " .. stderr .. "\nstdout: " .. stdout
  end

  return true, label .. " patch applied"
end

function M.ensure_molten_patch()
  local repo = vim.fn.expand("~/.local/share/nvim/site/pack/core/opt/molten-nvim")
  local outputchunks = repo .. "/rplugin/python3/molten/outputchunks.py"
  local patch = vim.fn.stdpath("config") .. "/lua/plugins/patch/molten_outputchunks_prefer_png.patch"

  local ok, msg = apply_patch_if_needed(
    repo,
    outputchunks,
    patch,
    function(contents)
      return contents:find('png_data = data%.get%("image/png"%)') == nil
    end,
    "molten prefer png"
  )
  if not ok then
    return false, msg
  end

  return true, "molten patches ensured"
end

return M
