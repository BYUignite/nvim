-- function written by codex

local M = {}

local function apply_patch_if_needed(repo, patch, target, marker)
  if vim.fn.filereadable(target) == 0 then
    return false, "otter target file not found: " .. target
  end

  if vim.fn.filereadable(patch) == 0 then
    return false, "otter patch file not found: " .. patch
  end

  local lines = vim.fn.readfile(target)
  local needs_patch = false
  for _, line in ipairs(lines) do
    if line:find(marker, 1, true) ~= nil then
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

function M.ensure_otter_patch()
  local repo = vim.fn.expand("~/.local/share/nvim/site/pack/core/opt/otter.nvim")
  local ok, msg = apply_patch_if_needed(
    repo,
    vim.fn.stdpath("config") .. "/lua/plugins/patch/treesitter_iterator.lua.patch",
    repo .. "/lua/otter/tools/treesitter_iterator.lua",
    "_rawquery"
  )
  if not ok then
    return false, msg
  end

  ok, msg = apply_patch_if_needed(
    repo,
    vim.fn.stdpath("config") .. "/lua/plugins/patch/completion_init.lua.patch",
    repo .. "/lua/otter/completion/init.lua",
    "vim.lsp.get_active_clients("
  )
  if not ok then
    return false, msg
  end

  return true, "otter patches ensured"
end

return M
