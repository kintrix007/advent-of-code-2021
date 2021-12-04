import strutils, sequtils, sugar

type
  Elem = tuple[num: int, isCrossed: bool]
  Table = array[25, Elem]

func parseTable(str: string): Table =
  let as2dSeq = str.split("\n").mapIt(it.split(" ").filterIt(it != "").mapIt((it.parseInt, false)))
  for i in 0 ..< 25:
    result[i] = as2dSeq[i div 5][i mod 5]

func getElem(tab: Table, x, y: range[0..4]): Elem = tab[x + y * 5]

proc crossElem(tab: var Table, value: int): void =
  for i in 0 ..< tab.len:
    if tab[i].num == value:
      tab[i].isCrossed = true
      break

func isDone(tab: Table): bool =
  for y in 0 ..< 5:
    var crossed = 0
    for x in 0 ..< 5:
      if tab.getElem(x, y).isCrossed: inc crossed
    if crossed == 5: return true
  
  for x in 0 ..< 5:
    var crossed = 0
    for y in 0 ..< 5:
      if tab.getElem(x, y).isCrossed: inc crossed
    if crossed == 5: return true
  
  return false


proc main() =
  let f = open("input")
  defer: f.close()
  let values = f.readLine().split(",").map(parseInt)
  discard f.readLine()

  var tables = f.readAll().split("\n\n").map parseTable
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
  
  echo sum * winningNum
    

main()
