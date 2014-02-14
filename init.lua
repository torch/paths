require 'libpaths'

local assert = assert
local debug = debug
local pcall = pcall
local type = type
local ipairs = ipairs
local os = os
local g = _G

module('paths')

function is_win()
   return uname():match('Windows')
end

function is_mac()
   return uname():match('Darwin')
end

if is_win() then
   home = os.getenv('HOMEDRIVE') or 'C:'
   home = home .. ( os.getenv('HOMEPATH') or '\\' )
else
   home = os.getenv('HOME') or '.'
end

function files(s)
   local d = dir(s)
   local n = 0
   return function()
             n = n + 1
             if (d and n <= #d) then
                return d[n]
             else
                return nil
             end
          end
end

function thisfile(arg, depth)
   local s = debug.getinfo(depth or 2).source
   if type(s) ~= "string" then
      s = nil
   elseif s:match("^@") then     -- when called from a file
      s = concat(s:sub(2))
   elseif s:match("^qt[.]") then -- when called from a qtide editor
      local function z(s) return g.qt[s].fileName:tostring() end 
      local b, f = pcall(z, s:sub(4));
      if b and f and f ~= "" then s = f else s = nil end
   end
   if type(arg) == "string" then
      if s then s = concat(dirname(s), arg) else s = arg end
   end 
   return s
end

function dofile(f, depth)
   local s = thisfile(nil, 1 + (depth or 2))
   if s and s ~= "" then
      f = concat(dirname(s),f)
   end
   return g.dofile(f)
end

function rmall(d, more)
   if more ~= 'yes' then
      return nil, "missing second argument ('yes')"
   elseif filep(d) then
      return os.remove(d)
   elseif dirp(d) then
      for f in files(d) do
         if f ~= '.' and f ~= '..' then
            local ff = concat(d, f)
            local r0,r1,r2 = rmall(ff, more)
            if not r0 then
               return r0,r1,ff
            end
        end
     end
     return rmdir(d)
   else
     return nil, "not a file or directory", d
   end
end

function findprogram(...)
   for _,exe in ipairs{...} do
      if is_win() then
         if not exe:match('[.]exe$') then
            exe = exe .. '.exe'
         end
         local path, k, x = os.getenv("PATH") or "."
         for dir in path:gmatch('[^;]+') do
            x = concat(dir, exe)
            if filep(x) then return x end
         end
         local function clean(s)
            if s:match('^"') then return s:match('[^"]+') else return s end 
         end
         k = 'SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\' .. exe
         x = getregistryvalue('HKEY_CURRENT_USER', k, '')
         if type(x) == 'string' then return clean(x) end
         x = getregistryvalue('HKEY_LOCAL_MACHINE', k, '')
         if type(x) == 'string' then return clean(x) end
         k = 'Applications\\' .. exe .. '\\shell\\open\\command'
         x = getregistryvalue('HKEY_CLASSES_ROOT', k, '')
         if type(x) == 'string' then return clean(x) end
      else
         local path = os.getenv("PATH") or "."
         for dir in path:gmatch('[^:]+') do
            local x = concat(dir, exe)
            if filep(x) then return x end
         end
      end
   end
   return nil
end
