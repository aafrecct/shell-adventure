Shell Adventure
===============

Shell Adventure is a small and very campy text game, played from the terminal
through the use of basic UNIX and shell (bash) commands. It's a linear
adventure through a dungeon where the main objective is to teach the player
the basics of using the terminal.

``shell_adventure.pdf`` contains the objectives and layout of the dungeon
poorly drawn by me.

It's unfinished for now.

## Description

The dungeon asks for root permissions while being built for some of the 
challenges to work as intended. The tree of the dungeon is:

```
dungeon
╰→ entrance
  ╰→ first_room
  ╰→ large_room 
    ╰→ lone_room
    ╰→ stand_room
    ╰→ weight_room
        ╰→ empty_hallway
          ╰→ a_dead_end
╰→ second_floor
  ╰→ lock_room_1
    ╰→ anteroom
      ╰→ lock_room_2
      ╰→ weird_altar_room
        ╰→ portal_room
╰→ a_dark_room
  ╰→ the_sword_room
    ╰→ boss_room
```

All of the rooms are folders inside `/dungeon/`. Each folder can contain as
many files as necessary but only two are automatically checked at creation 
time: `room.yaml` and `auto.sh`.

### `room.yaml`

This is the main file describing a room, it should always contain the following
keys:

key         | description
------------|-------------------------------------------------
`id`        | the name of the folder / room
`dir_name`  | the name of the folder when build in spanish and english
`desc`      | a description of the room explaining its purpose
`hidden`    | if `true` a dot will be appended to the folder name
`locked`    | if `true` 000 permisions will be applied to the folder
`narrative` | this will be the main file placed in the room for the player to "see" it.

In addition it can contain these keys:

key         | description
------------|-------------------------------------------------
`items`     | the items to be placed in this room with their name in both languajes and one of 3 instructions: `copy` means to copy the file into its final directory, `content` means to create a text file with the content given, `make` needs a comand to execute before copying the file to the destination.

## `auto.sh`
This file isn't copied to the final dungeon, but gets sourced the first time
the player `cd`s into a room.
