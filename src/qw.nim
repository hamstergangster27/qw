#qw
import os
import strformat
import strutils

type Result = tuple[kind: PathComponent, path: string]

#colors
proc red(s: string): string = return "\e[1;91m" & s & "\e[0m"
proc green(s: string): string = return "\e[1;92m" & s & "\e[0m"
proc blue(s: string): string = return "\e[1;94m" & s & "\e[0m"

proc detail(res: seq[Result]): string =
  for x in res:
    let info = getFileInfo(x.path)
    result = result & fmt"{x.path.splitPath.tail}  {x.kind}  {info.size}   {info.permissions}  {info.lastWriteTime}" & $'\n'
  result.delete(result.len - 1..result.len - 1)

func filterOutHidden(res: seq[Result]): seq[Result] =
  for x in res:
    if isHidden(x.path):
      continue
    else:
      result.add(x)

func filterOutDirs(res: seq[Result]): seq[Result] =
  for x in res:
    if x.kind != pcDir:
      result.add(x)

func filterOutFiles(res: seq[Result]): seq[Result] =
  for x in res:
    if x.kind != pcFile:
      result.add(x)

func filterOutSymlinks(res: seq[Result]): seq[Result] =
  for x in res:
    if x.kind != pcLinkToFile or x.kind != pcLinkToDir:
      result.add(x)

proc symlinks(res: seq[Result]): seq[Result] {.inline.} =
  return res.filterOutFiles().filterOutDirs()

proc dirs(res: seq[Result]): seq[Result] {.inline.} =
  return res.filterOutFiles().filterOutSymlinks()

proc files(res: seq[Result]): seq[Result] {.inline.} =
  return res.filterOutSymlinks().filterOutDirs()

proc color(res: seq[Result]): seq[Result] = 
  for x in res:
    if x.kind == pcDir:
      result.add((kind: x.kind, path: x.path.splitPath.tail.blue()))
    elif x.kind == pcFile:
      result.add((kind: x.kind, path: x.path.splitPath.tail.green()))
    else:
      result.add((kind: x.kind, path: x.path.splitPath.tail.red()))

proc get(): seq[Result] =
  for kind, path in walkDir(getCurrentDir()):
    result.add((kind, path))

proc printAll(res: seq[Result], stacked: bool) =
  if stacked == true:
    for x in res:
      echo x.path
  else:
    for x in res:
      stdout.write(x.path & "  ")
    stdout.write($'\n')

proc sortAlphabetically(res: seq[Result]): seq[Result] =
  result = res
  for i in 0..<result.len:
    for j in i+1..<result.len:
      if cmp(result[i].path, result[j].path) > 0:
        swap(result[i], result[j])

proc route() =
  var res = get()
  var hidden: bool
  var detailed: bool
  var stacked: bool
  for i in 1..paramCount():
    if paramStr(i) == "hidden":
      hidden = true
      continue
    elif paramStr(i) == "detail":
      detailed = true
      continue
    else:
      case paramStr(i)
      of "symlinks":
        res = symlinks(res)
      of "dirs":
        res = dirs(res)
      of "files":
        res = files(res)
      of "stacked":
        stacked = true
      else:
        echo "Not enough arguments".red()
        quit 1
    
  if hidden == false: res = filterOutHidden(res)
  if detailed: 
    detail(res).echo
    return
  res = color(res)
  res = sortAlphabetically(res)
  printAll(res, stacked)

route()
