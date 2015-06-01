<a name="paths.dok"/>
# Filename Manipulation Package #

This package provides portable functions to manipulate filenames.

When this package is loaded, it also computes a number of useful 
variables indicating where the various Torch components are installed.  
Do not change their values.


<a name="paths.filenames.dok"/>
## Manipulating file names ##

The following functions can be used
to manipulate filenames in a portable way
over multiple platforms.


<a name="paths.filep"/>
### paths.filep(path) ###

Return a boolean indicating whether `path` 
refers to an existing file.

<a name="paths.dirp"/>
### paths.dirp(path) ###

Return a boolean indicating whether `path` 
refers to an existing directory.

<a name="paths.basename"/>
### paths.basename(path,[suffix]) ###

Return the last path component of `path`
and optionally strip the suffix `suffix`.
This is similar to the well know shell command `"basename"`.

<a name="paths.dirname"/>
### paths.dirname(path) ###

Return the name of directory containing file `path`.
This is similar to the well known shell command `"dirname"`.

<a name="paths.extname"/>
### paths.extname(path) ###

Return the extension of the `path` or nil if none is found.

<a name="paths.concat"/>
### paths.concat([path1,....,pathn]) ###

Concatenates relative filenames.

First this function computes the full filename
of `path1` relative to the current directory.
Then it successively computes the full filenames
of arguments `path2` to `pathn` relative to
the filename returned for the previous argument.
Finally the last result is returned.

Calling this function without argument returns the
full name of the current directory.


<a name="paths.cwd"/>
### paths.cwd() ###

Return the full path of the current directory.


<a name="paths.execdir"/>
### paths.execdir() ###

Return the name of the directory containing the
current Lua executable.
When the module `paths` is first loaded,
this information is used to relocate
the variables indicating 
the location of the various Torch components.


<a name="paths.tmpname"/>
### paths.tmpname() ###

Return the name of a temporary file.
All the temporaty files whose name was obtained in this way
are removed when Lua exits.

This function should be preferred over `os.tmpname()`
because it makes sure that the files are removed on exit.
In addition, `os.tmpname()` under windows often returns filenames
for which the user has no permission to write.

<a name="paths.dirs.dok"/>
## Directory functions ##

The following functions can be used
to examine directory contents or manipulate directories.

<a name="paths.dir"/>
### paths.dir(dname) ###

Return a table containing the files and directories in directory `dname`.
This function return `nil` if the specified directory does not exists. 
For linux, this includes the `.` and `..` directories.

<a name="paths.files"/>
### paths.files(dname [, include]) ###

Returns an iterator over the files and directories located in directory `dname`.
For linux, this includes the `.` and `..` directories. 
This can be used in *__for__* expression as shown below:

```lua
for f in paths.files(".") do
   print(f)
end
```

Optional argument `include` is either a function or a string used to 
determine which files are to be included. The function takes the filename 
as argument and should return true if the file is to be included. 
When a string is provided, the following function is used :

```lua
function(file) 
   return file:find(f) 
end
```

Files and directories of sub-folders aren't included.

<a name="paths.iterdirs"/>
### paths.iterdirs(dname) ###

Returns an iterator over the directories located in directory `dname`.
This can be used in *__for__* expression as shown below:

```lua
for dir in paths.iterdirs(".") do
   print(dir)
end
```

Directories of sub-folders, and the `.` and `..` folders aren't included.

<a name="paths.iterdirs"/>
### paths.iterfiles(dname) ###

Returns an iterator over the files (non-directories) located in directory `dname`.
This can be used in *__for__* expression as shown below:

```lua
for file in paths.iterfiles(".") do
   print(file)
end
```

Files of sub-folders, and the `.` and `..` folders aren't included.

<a name="paths.mkdir"/>
### paths.mkdir(s) ###

Create a directory.
Returns `true` on success.

<a name="paths.rmdir"/>
### paths.rmdir(s) ###

Delete an empty directory.
Returns `true` on success.

<a name="paths.rmall"/>
### paths.rmall(s, y) ###

Recursively delete file or directory `s` and its contents.
Argument `y` must be string `"yes"`
Returns `true` on success.


<a name="paths.findingfiles.dok"/>
## Finding files relative to a Lua script ##

<a name="paths.thisfile"/>
### paths.thisfile([arg]) ###

Calling `paths.thisfile()` without argument 
inside a lua file returns returns the full 
pathname of the file from which it is called. 
This function always returns `nil` when called
interactively.

Calling `paths.thisfile(arg)` with a string argument `arg`
returns the full pathname of the file `arg` relative 
to the directory containing the file from which 
function `paths.thisfile` is invoked. This is useful, 
for instance, to locate files located in the same 
directory as a lua script.


<a name="paths.dofile"/>
### paths.dofile(filename) ###

This function is similar to the standard Lua function `dofile`
but interprets `filename` relative to the directory containing 
the file that contains the call to `paths.dofile`,
or to the current directory when `paths.dofile` is 
called interactively.

<a name="paths.wellknowndirs.dok"/>
## Well known directories ##

These variables indicate where the various Torch components are installed.  
It is not advisable to change their values!


<a name="paths.install_prefix"/>
### paths.install_prefix ###

The base directory of the Torch installation.

<a name="paths.install_bin"/>
### paths.install_bin ###

The name of the directory containing the executable programs.
Under Windows, this directory also contains 
the dynamically loadable libraries (`.dll`).

<a name="paths.install_man"/>
### paths.install_man ###

The name of the directory containing the unix style manual pages.

<a name="paths.install_lib"/>
### paths.install_lib ###

The name of the directory containing the object code libraries.
Under Unix, this directory also contains the dynamically
loadable libraries (`.so` or `.dylib`).

<a name="paths.install_share"/>
### paths.install_share ###

The name of the directory containing processor independent data files,
such as lua code and other text files.

<a name="paths.install_include"/>
### paths.install_include ###

The name of the directory containing the include files
for the various Torch libraries.

<a name="paths.install_hlp"/>
### paths.install_hlp ###

The name of the directory containing the Torch help files.

<a name="paths.install_html"/>
### paths.install_html ###

The name of the directory containing the HTML version
of the Torch help files.  These files are generated
when you enable the CMake option `HTML_DOC`.

<a name="paths.install_cmake"/>
### paths.install_cmake ###

The name of the directory containing the CMake files
used by external Torch modules.

<a name="paths.install_lua_path"/>
### paths.install_lua_path ###

The name of the directory containing the Lua packages.
This directory is used to build variable `package.path`.

<a name="paths.install_lua_cpath"/>
### paths.install_lua_cpath ###

The name of the directory containing the Lua loadable binary modules.
This directory is used to build variable `package.cpath`.

<a name="paths.home"/>
### paths.home ###

The home directory of the current user.


<a name="paths.misc.dok"/>
## Miscellaneous ##


<a name="paths.uname"/>
### paths.uname() ###

Returns up to three strings describing the operating system.
The first string is a system name, e.g., "Windows", "Linux", "Darwin", "FreeBSD", etc.
The second string is the network name of this computer.
The third string indicates the processor type.

<a name="paths.is_win"/>
### paths.is_win() ###

Returns true if the operating system is Microsoft Windows.

<a name="paths.is_mac"/>
### paths.is_mac() ###

Returns true if the operating system is Mac OS X.

### paths.getregistryvalue(key,subkey,value) ###

Query a value in the Windows registry value. 
Causes an error on other systems.

### paths.findprogram(progname,...) ###

Finds an executable program named "progname" and returns its full path.
If none is found, continue searching programs named after the following arguments
and return the full path of the first match.
All the directories specified by the PATH variable are searched.
Under windows, this also searches the "App Path" registry entries.

