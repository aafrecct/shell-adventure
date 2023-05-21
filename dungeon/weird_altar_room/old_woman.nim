import std/os

if getEnv("SHELL_ADVENTURE_LANG", "es") == "es":
  for _ in 0..2:
    sleep(500)
    echo "JE "
else:
  for _ in 0..1:
    sleep(500)
    echo "HE "
