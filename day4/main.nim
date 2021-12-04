import strutils, sequtils
import table

func part1(inTables: openArray[Table], values: openArray[int]): int
func part2(inTables: openArray[Table], values: openArray[int]): int

proc main() =
  let f = open("input")
  defer: f.close()
  let values = f.readLine().split(",").map(parseInt)
  discard f.readLine()

  var tables = f.readAll().split("\n\n").map parseTable

  echo part1(tables, values)
  echo part2(tables, values)


func part1(inTables: openArray[Table], values: openArray[int]): int =
  var tables = @inTables
  var firstTable: Table
  var winningNum: int

  block check:
    for v in values:
      for i in 0 ..< tables.len:
        tables[i].crossElem(v)
        if tables[i].isDone:
          winningNum = v
          firstTable = tables[i]
          break check
  
  var sum = 0
  for elem in firstTable.filterIt(not it.isCrossed):
    if elem.isCrossed: continue
    sum += elem.num
  
  sum * winningNum

func part2(inTables: openArray[Table], values: openArray[int]): int =
  var tables = @inTables
  var lastTable: Table
  var winningNum: int

  block check:
    for v in values:
      var i = 0
      while i < tables.len:
        tables[i].crossElem(v)
        if tables[i].isDone:
          if tables.len == 1:
            winningNum = v
            lastTable = tables[i]
            break check
          tables.del(i)
          continue
        inc i
  
  var sum = 0
  for elem in lastTable.filterIt(not it.isCrossed):
    if elem.isCrossed: continue
    sum += elem.num
  
  sum * winningNum 


when isMainModule:
  main()
