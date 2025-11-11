-- ~/.config/yazi/plugins/lastpos.yazi/init.lua

local store_path = os.getenv("HOME") .. "/.local/share/yazi/lastdir.txt"

local M = {}

-- Save current directory to file
function M.save_last()
	local cwd = ya.cur_dir()
	local f = io.open(store_path, "w")
	if f then
		f:write(cwd .. "\n")
		f:close()
	end
end

-- Jump to last saved directory
function M.go_last()
	local f = io.open(store_path, "r")
	if not f then
		ya.err("No last directory file found")
		return
	end
	local path = f:read("*l")
	f:close()
	if path and #path > 0 then
		ya.cd(path)
	else
		ya.err("No last directory recorded")
	end
end

return M

