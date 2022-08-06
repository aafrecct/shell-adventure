import std/os

let currentRoom = splitPath(getCurrentDir()).tail

if currentRoom == "weight_room":
  var newFile: string
  for file in walkFiles("[a-zA-Z0-9_-]*"):
    if file notin ["brick", "ladrillo", "scales", "balanza", "empty_hallway", "pasillo_vacio"]:
      newFile = file
      break
  if len(newFile) != 0 and getFileSize(newFile) > 0:
    let weightRoomDir = "../weight_room"
    let openPermissions = {
      FilePermission.fpUserExec,
      FilePermission.fpUserWrite,
      FilePermission.fpUserRead,
      FilePermission.fpGroupExec,
      FilePermission.fpGroupRead,
      FilePermission.fpOthersExec,
      FilePermission.fpOthersRead
    }

    setFilePermissions(weightRoomDir, openPermissions)
    
    if getEnv("DUNGEON_LANG", "ES") == "ES":
      echo "La puerta de en frente hace *click*."
    else:
      echo "The door in front of you clicks."
  else:
    if getEnv("DUNGEON_LANG", "ES") == "ES":
      echo "La balanza se mueve misteriosamente y vuelve a su posición original."
    else:
      echo "The scales swing magically and return to their initial position."
else:
  if getEnv("DUNGEON_LANG", "ES") == "ES":
    echo "El ladrillo no está en esta habitación."
  else:
    echo "The brick is not in this room."
