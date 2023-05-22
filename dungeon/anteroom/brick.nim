import std/os

var 
  expectedCurrentRoom: string
  expectedLinkName: string 
  expectedFileName: string
  nextRoomDir: string
  successText: string
  failText: string
  wrongRoomText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  expectedCurrentRoom = "antesala"
  expectedLinkName = "./sala_con_mecanismo_2/bebedero"
  expectedFileName = "../bebedero"
  nextRoomDir = "./sala_del_altar"
  successText = "Se oye un *click* que viene de la puerta."
  failText = """Se escuchan sonidos de agua cayendo, tras un momento, cesan.
Para poder abrir la puerta debes vincular las aguas. Todos los cambios
de una han de ser cambios de la otra."""
  wrongRoomText = "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "anteroom"
  expectedLinkName = "./room_with_mechanism_2/stone_sink"
  expectedFileName = "../../stone_sink"
  nextRoomDir = "./weird_altar_room"
  successText = "You hear a click coming from the large door."
  failText = """You hear water falling, then it stops.
To open the room you need to link both waters, so that changes in one are 
changes in the other, forever in sync."""
  wrongRoomText = "The brick is not in this room."

if currentRoom == expectedCurrentRoom:
  let
    isLink = symlinkExists(expectedLinkName)
    linkToRightFile = isLink and absolutePath(expandSymLink(expectedLinkName)) == absolutePath(expectedFileName)
  if isLink and linkToRightFile:
    let openPermissions = {
      FilePermission.fpUserExec,
      FilePermission.fpUserWrite,
      FilePermission.fpUserRead,
      FilePermission.fpGroupExec,
      FilePermission.fpGroupRead,
      FilePermission.fpOthersExec,
      FilePermission.fpOthersRead
    }

    setFilePermissions(nextRoomDir, openPermissions)
    
    echo successText
  else:
    echo failText
else:
  echo wrongRoomText
