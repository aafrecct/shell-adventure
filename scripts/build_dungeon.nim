import std/os
import std/osproc
import std/tables
import std/strutils
import std/strformat
import std/options
import yaml, yaml/serialization, yaml/data, streams

let vspace = "\n".repeat(60)

type Lang = enum
  es = "es",
  en = "en"

type ItemKind = enum
  copy, make, content

type Item = object
  name                       : Table[Lang, string]
  kind                       : ItemKind
  instr {.defaultVal: "".}   : string
  content {.defaultVal: nil.} : TableRef[Lang, string]
        
type Room = object
  id       : string
  dir_name : Table[Lang, string]
  desc     : string
  hidden   : bool
  locked   : bool
  narrative: Table[Lang, string]
  items    : Table[string, Item]


var 
  dungeonTreeYaml = newFileStream("dungeon/tree.yaml")
  context = newConstructionContext()
  parser = initYamlParser()
  events = parser.parse(dungeonTreeYaml)
  nextEvent = events.peek()
  currentPath: seq[string] = @[]
  lockedRooms: seq[string] = @[]
  depth = 0
  lang = case getEnv("LANG", "en")[0..1]
    of "es": es
    else: en


proc createRoom(path: var seq[string], room_id: string) =
  var 
    room: Room
    roomDescYaml = newFileStream(fmt"dungeon/{room_id}/room.yaml")
    dirName: string

  load(roomDescYaml, room)

  case room.hidden:
    of true:
      dirName = fmt".{room.dir_name[lang]}"
    of false:
      dirName = room.dirName[lang]

  path.add(dirName)
  
  var roomPath = path.join("/")
  createDir(roomPath)

  
  writeFile(fmt("{path.join(\"/\")}/desc"), room.narrative[lang] % ["vspace", vspace])
  copyFile(fmt"dungeon/{room_id}/auto.sh", fmt"scripts/rooms/{dirName}.sh")
      
  for item_id, item in room.items.pairs():
    case item.kind:
      of ItemKind.copy:
        copyFileWithPermissions(fmt"dungeon/{room_id}/{item_id}", fmt"{roomPath}/{item.name[lang]}")
      of ItemKind.make:
        discard execCmdEx(item.instr, workingDir=fmt"dungeon/{room_id}")
        moveFile(fmt"dungeon/{room_id}/{item_id}", fmt"{roomPath}/{item.name[lang]}")
      of ItemKind.content:
        writeFile(fmt"{roomPath}/{item.name[lang]}", item.content[lang])

  if room.locked:
    lockedRooms.add(roomPath)

  echo fmt"Created room {roomPath}"

createDir("scripts/rooms")
createDir("visited")

while nextEvent.kind != yamlEndStream:
  case nextEvent.kind

    of yamlStartMap:
      depth += 1
      discard events.next()
  
    of yamlEndMap:
      depth -= 1
      discard currentPath.pop()
      discard events.next()
    
    of yamlScalar:
      case guessType(nextEvent.scalarContent)
        
        of yTypeUnknown:
          var lastRoom: string
          events.constructChild(context, lastRoom)
          createRoom(currentPath, lastRoom)
          if len(currentPath) > depth:
            discard currentPath.pop()
        else:
          assert false, "Only include room IDs in tree.yaml!"

    else:
      discard events.next()
  nextEvent = events.peek()
dungeonTreeYaml.close()

for r_index in countdown(lockedRooms.high, lockedRooms.low):
  lockedRooms[r_index].setFilePermissions({})

