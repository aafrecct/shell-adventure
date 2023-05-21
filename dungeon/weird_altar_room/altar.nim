import std/os
import std/strformat
import std/random
randomize()

var 
  expectedCurrentRoom: string
  nextRoomDir: string
  keywordsList: seq[string]
  keywordsResponse: seq[string]
  personFileName: string
  personStillInRoomText: string
  noArgsText: string
  failText: string
  successText: string
  wrongRoomText: string
  currentRoom: string = splitPath(getCurrentDir()).tail

let letters = "abcdefghijklmnopqrstuvwxyz"

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  expectedCurrentRoom = "sala_del_altar"
  nextRoomDir = "./portal_room"
  keywordsList = @["primero", "patito", "bronce", "muerte", "uve", "shell"]
  personFileName = "vieja"
  personStillInRoomText = """Este altar puede ayudarte a abrir la puerta, pero solo funciona si 
solo hay una persona en la sala.
  """
  noArgsText = """Este altar no responde ante cualquiera, su magia es aleatoria
y para usarlo necesitaras filtrarla. El altar solo responde ante ciertas palabras
puede que puedas encontrarlas en un trozo de magia aleatoria.
Para pasar el output de un comando como input al siguiente, conectalos con `|`.
Puedes filtrar texto con el comando `grep`. Para interpretar la magia puedes
usar `expr`.
  """
  keywordsResponse = @[
    "s",
    "h",
    "e",
    "l",
    "l"
  ]
  failText = "Eso no es una palabra mágica"
  successText = "Se oye un *click* que viene de la puerta."
  wrongRoomText = "El ladrillo no está en esta habitación."
else:
  expectedCurrentRoom = "weird_altar_room"
  nextRoomDir = "./portal_room"
  keywordsList = @["first", "duck", "bronze", "death", "vee", "shell"]
  personFileName = "old_woman"
  personStillInRoomText = """This altar might be able to open the doot, but it only works
when there is only one person in the room.
  """
  noArgsText = """This altar doesn't just work, it's magic is wild and random so you
might need to filter it first. The altar answers only to a certain set of words
you might be able to get what they are from a piece of random magic.
You can pipe the output of one command to another by joining them with `|`.
You can filter text with `grep`. You can use `expr` to interpret the magic.
  """
  keywordsResponse = @[
    "s",
    "h",
    "e",
    "l",
    "l"
  ]
  successText = "You hear a click coming from the door in from of you."
  failText = "That is not a valid magic keyword"
  wrongRoomText = "The brick is not in this room."

if currentRoom != expectedCurrentRoom:
  echo wrongRoomText
elif fileExists(personFileName):
  echo personStillInRoomText
elif paramCount() == 0:
  echo noArgsText
  sleep(1000)
  for i in 0..4:
    for j in 1..rand(20..80):
      echo fmt"{sample(letters)}{sample(letters)}{sample(letters)}{sample(letters)}{sample(letters)}{sample(letters)}"
    echo fmt"kw {keywordsList[i]}"
else:
  if paramStr(1) == keywordsList[5]:
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
  elif paramStr(1) in keywordsList:
    echo keywordsResponse[keywordsList.find(paramStr(1))]
  else:
    echo failText
    

