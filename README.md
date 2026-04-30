# qw

An alternative to the standard ls command in Linux (or any other OS) written in Nim. 

# Installation 

To install qw, you can either compile it yourself with the ![Nim compiler](https://nim-lang.org) or downloading the package here on GitHub.

# Usage

There are 4 flags in total:
- hidden
- detail
- dirs
- files

`hidden` shows the hidden dirs and files.
`detail` shows the details about a file/folder (name, type, size in bytes, permissions, last write time).
`dirs` shows the directories only.
`files` shows the files only.

You can stack them too.
`qw hidden detail` shows hidden files and folders and also shows details for them and for regular files and folders.
`qw hidden files` shows hidden files (note: `files` shows only files, even with `hidden`).

# License
This program is licensed under the GPL-3.0 license.
