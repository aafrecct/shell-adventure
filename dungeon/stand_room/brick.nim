import std/os

let currentRoom = splitPath(getCurrentDir()).tail

if currentRoom == "stand_room":
  if fileExists("libro") or fileExists("book"):
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
      echo "Se oye un *click* en la habitación de al lado."
    else:
      echo "You hear a click coming from the other room."
  else:
    if getEnv("DUNGEON_LANG", "ES") == "ES":
      echo "Una energía azul aparece encima del atril pero desaparece rápido."
    else:
      echo "A weird blue energy surrounds the top of the lectern then disipates quickly."
else:
  if getEnv("DUNGEON_LANG", "ES") == "ES":
    echo "El ladrillo no está en esta habitación."
  else:
    echo "The brick is not in this room."
