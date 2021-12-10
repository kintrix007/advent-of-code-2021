import strutils, sequtils

type
  Elem* = tuple[num: int, isCrossed: bool]
  Table* = array[25, Elem]

func parseTable*(str: string): Table =
  let as2dSeq = str.split("\n").mapIt(it.split(" ").filterIt(it != "").mapIt((num: it.parseInt, isCrossed: false)))
  for i in 0 ..< 25:
    result[i] = as2dSeq[i div 5][i mod 5]

func getElem*(tab: Table, x, y: range[0..4]): Elem = tab[x + y * 5]

proc crossElem*(tab: var Table, value: int): void =
  for i in 0 ..< tab.len:
    if tab[i].num == value:
      tab[i].isCrossed = true
      break

func isDone*(tab: Table): bool =
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