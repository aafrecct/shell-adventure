import std/os

var 
  expectedCurrentRoom: string
  knownFilesList: seq[string]
  nextRoomDir: string
  successText: string
  failText: string
  wrongRoomText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  expectedCurrentRoom = "sala_balanza"
  knownFilesList = @["desc", "ladrillo", "balanza", "pasillo_vacio"]
  nextRoomDir = "./pasillo_vacio"
  successText = "Se oye un *click* que viene de la puerta."
  failText = "La balanza se mueve misteriosamente y vuelve a su posición original."
  wrongRoomText = "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "scales_room"
  knownFilesList = @["desc", "brick", "scales", "empty_hallway"]
  nextRoomDir = "./empty_hallway"
  successText = "You hear a click coming from the door in from of you."
  failText = "The scales move slighly on their own then go back to a neutral position."
  wrongRoomText = "The brick is not in this room."

if currentRoom == expectedCurrentRoom:
  var newFile: string
  for file in walkFiles("[a-zA-Z0-9_-]*"):
    if file notin knownFilesList:
      newFile = file
      break

  if len(newFile) != 0 and getFileSize(newFile) > 0:
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
