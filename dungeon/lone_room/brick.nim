import std/os

var 
  expectedCurrentRoom: string
  nextRoomDir: string
  successText: string
  failText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  expectedCurrentRoom = "sala_solitaria"
  nextRoomDir = "../sala_atril"
  successText = "Se oye un *click* en la habitación de al lado."
  failText = "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "lone_room"
  nextRoomDir = "../lectern_room"
  successText = "You hear a click coming from the other room."
  failText = "The brick is not in this room."

if currentRoom == expectedCurrentRoom:
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
