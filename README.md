# qw

An alternative to the standard ls command in Linux (or any other OS) written in Nim. 
**Note: this project was moved to [Codeberg](https://codeberg.org/hamstergangster27/qw)**

# Installation 

To install qw, you can either compile it yourself with the [Nim compiler](https://nim-lang.org) or download the package here on GitHub.

# Usage

There are 5 flags in total:
- hidden
- detail
- dirs
- files
- symlinks (Linux)

`hidden` shows the hidden dirs and files.
`detail` shows the details about a file/folder (name, type, size in bytes, permissions, last write time).
`dirs` shows the directories only.
`files` shows the files only.
`symlink` shows symlinks only (Linux only).

You can stack them too.
`qw hidden detail` shows hidden files and folders and also shows details for them and for regular files and folders.
`qw hidden files` shows hidden files (note: `files` shows only files, even with `hidden` It will show regular files and hidden files.).

Red means symlink, blue means directory and green means file.

# License
This program is licensed under the GPL-3.0 license.
