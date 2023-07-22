# Package

version       = "0.1.0"
author        = "akex"
description   = "A simple terrain generation and cellular automata generator"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["Terraurge"]


# Dependencies
requires "nimPNG"
requires "sdl2"
requires "nim >= 1.6.10"
