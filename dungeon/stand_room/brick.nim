import std/os

var 
  expectedCurrentRoom: string
  expectedFileName: string
  nextRoomDir: string
  successText: string
  failText: string
  wrongRoomText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

if getEnv("DUNGEON_LANG", "es") == "es":
  expectedCurrentRoom = "sala_atril"
  expectedFileName = "libro"
  nextRoomDir = "../sala_balanza"
  successText = "Se oye un *click* en la habitación de al lado."
  failText = "Una energía azul aparece encima del atril pero desaparece rápido."
  wrongRoomText =  "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "lectern_room"
  expectedFileName = "book"
  nextRoomDir = "../scales_room"
  successText = "You hear a click coming from the other room."
  failText = "A weird blue energy surrounds the top of the lectern then disipates quickly."
  wrongRoomText =   "The brick is not in this room."

if currentRoom == expectedCurrentRoom:
  if fileExists(expectedFileName):
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
