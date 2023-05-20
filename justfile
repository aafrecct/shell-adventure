delete_dungeon:
  rm -rf ./locked
compile_dungeon_gen:
  nim c -o=./scripts/build_dungeon ./scripts/build_dungeon.nim
dungeon_gen: compile_dungeon_gen delete_dungeon
  ./scripts/build_dungeon
  
