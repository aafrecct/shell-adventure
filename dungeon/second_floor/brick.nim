import std/os
import std/osproc
import std/strformat

var 
  expectedCurrentRoom: string
  expectedFileName: string
  expectedExecName: string
  knownFilesList: seq[string]
  nextRoomDir: string
  successText: string
  failText: string
  wrongRoomText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  expectedCurrentRoom = "segundo_piso"
  expectedFileName = "cuenco_de_piedra"
  expectedExecName = "./tortuga_marina"
  nextRoomDir = "./sala_con_mecanismo_1"
  successText = "La estatua acerca el cuenco de piedra a su cara, se oye un *click* que viene de la puerta."
  failText = """La estatua acerca el cuenco de piedra a su cara, tras un rato, lo retira.
Puedes usar `>` despues de un comando para redirigir su salida a un archivo."""
  wrongRoomText = "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "second_floor"
  expectedFileName = "stone_bowl"
  expectedExecName = "./sea_turtle"
  nextRoomDir = "./room_with_mechanism_1"
  successText = "The statue brings the bowl to it's face, you hear a click coming from the door."
  failText = """ The statue brings the bowl to it's face and after a while returns 
to it's original position.
You can use `>` to redirect a commands output to a file."""
  wrongRoomText = "The brick is not in this room."

if currentRoom == expectedCurrentRoom:

  if execCmd(fmt"{expectedExecName} | cmp --silent {expectedFileName}") == 0:
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
