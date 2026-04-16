-- function written by codex

local M = {}

function M.ensure_otter_patch()
  local repo = vim.fn.expand("~/.local/share/nvim/site/pack/core/opt/otter.nvim")
  local patch = vim.fn.stdpath("config") .. "/lua/plugins/patch/treesitter_iterator.lua.patch"
  local target = repo .. "/lua/otter/tools/treesitter_iterator.lua"

  if vim.fn.filereadable(target) == 0 then
    return false, "otter target file not found: " .. target
  end

  if vim.fn.filereadable(patch) == 0 then
    return false, "otter patch file not found: " .. patch
  end

  local lines = vim.fn.readfile(target)
  local needs_patch = false
  for _, line in ipairs(lines) do
    if line:find("_rawquery", 1, true) ~= nil then
      needs_patch = true
      break
    end
  end

  if not needs_patch then
    return true, "otter patch not needed"
  end

  local result = vim.system({ "git", "-C", repo, "apply", patch }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ""
    local stdout = result.stdout or ""
    return false, "otter patch failed\nstderr: " .. stderr .. "\nstdout: " .. stdout
  end

  return true, "otter patch applied"
end

return M
