import math, sequtils, random, strformat
import math, sequtils, random
import os
type
  Cave = ref object
    grid: seq[seq[int]]
    shape: tuple[x, y: int]
  WallOrFloor = enum
    WALL = 0
    FLOOR = 1

proc createCave(shape: tuple[x, y: int]): Cave =
  new(result)
  result.grid = newSeqWith(shape.x, newSeq[int](shape.y))
  result.shape = shape

proc display_cave(cave: Cave) =
  for row in cave.grid:
    for cell in row:
      if cell == int(WallOrFloor.WALL): stdout.write( ".") 
      else: stdout.write( "#")
    echo()

proc randomFill(cave: Cave, fillProb: float) =
  for i in 0..<cave.shape.x:
    for j in 0..<cave.shape.y:
      cave.grid[i][j] = if rand(0.0 .. 1.0) < fillProb: int(WallOrFloor.WALL) else: int(WallOrFloor.FLOOR)

proc countWalls(cave: Cave, x, y, dist: int): int =
  result = 0
  for i in max(0, x-dist) .. min(x+dist+1, cave.shape.x-1):
    for j in max(0, y-dist) .. min(y+dist+1, cave.shape.y-1):
      if cave.grid[i][j] == int(WallOrFloor.WALL):
        result += 1
proc generateCave(cave: Cave, generations: int) =
  let shape = cave.shape
  var new_map = cave.grid
  for generation in 0 ..< generations:
    for i in 0 ..< shape.x:
      for j in 0 ..< shape.y:
        let wallcount_1away = countWalls(cave, i, j, 1)
        let wallcount_2away = countWalls(cave, i, j, 2)

        if generation < 5:
          if wallcount_1away >= 5 or wallcount_2away <= 7:
            new_map[i][j] = int(WallOrFloor.WALL)
          else:
            new_map[i][j] = int(WallOrFloor.FLOOR)
          if i == 0 or j == 0 or i == shape.x-1 or j == shape.y-1:
            new_map[i][j] = int(WallOrFloor.WALL)
        else:
          if wallcount_1away >= 5:
            new_map[i][j] = int(WallOrFloor.WALL)
          else:
            new_map[i][j] = int(WallOrFloor.FLOOR)
  cave.grid = new_map


# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import Terraurgepkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

proc getWelcomeMessage*(): string = 
  randomize()
  let cave = createCave((60, 190))
  cave.randomFill(0.4)
  cave.generateCave(200)
  cave.display_cave()
