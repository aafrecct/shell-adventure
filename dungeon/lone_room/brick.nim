import std/os

let currentRoom = splitPath(getCurrentDir()).tail

if currentRoom == "lone_room":
  let standRoomDir = "../stand_room"
  let openPermissions = {
    FilePermission.fpUserExec,
    FilePermission.fpUserWrite,
    FilePermission.fpUserRead,
    FilePermission.fpGroupExec,
    FilePermission.fpGroupRead,
    FilePermission.fpOthersExec,
    FilePermission.fpOthersRead
  }

  setFilePermissions(standRoomDir, openPermissions)
  
  if getEnv("DUNGEON_LANG", "ES") == "ES":
    echo "Se oye un *click* en la habitación de al lado."
  else:
    echo "You hear a click coming from the other room."

else:
  if getEnv("DUNGEON_LANG", "ES") == "ES":
    echo "El ladrillo no está en esta habitación."
  else:
    echo "The brick is not in this room."
