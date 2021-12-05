package main

import (
	"fmt"
	"math"
)

type Point struct {
	x, y int
}

type Line struct {
	from, to Point
}

type Table [][]int

func GetMaxSize(lines []Line) (x, y int) {
	defer func() {
		x++
		y++
	}()
	
	for _, l := range lines {
		xMax := int(math.Max(float64(l.from.x), float64(l.to.x)))
		yMax := int(math.Max(float64(l.from.y), float64(l.to.y)))
		if xMax > x {
			x = xMax
		}
		if yMax > y {
			y = yMax
		}
	}
	return
}

func (t Table) StrikeLine(l Line) {
	if l.from.y == l.to.y {
		xMin := int(math.Min(float64(l.from.x), float64(l.to.x)))
		xMax := int(math.Max(float64(l.from.x), float64(l.to.x)))
		for i := xMin; i <= xMax; i++ {
			t[l.from.y][i]++
		}
	} else if l.from.x == l.to.x {
		yMin := int(math.Min(float64(l.from.y), float64(l.to.y)))
		yMax := int(math.Max(float64(l.from.y), float64(l.to.y)))
		for i := yMin; i <= yMax; i++ {
			t[i][l.from.x]++
		}
	} else if steps := l.to.x - l.from.x; steps == l.to.y - l.from.y {
		sign := int(math.Copysign(1, float64(steps)))
		for i := 0; i <= int(math.Abs(float64(steps))); i++ {
			x, y := l.from.x + sign*i, l.from.y + sign*i
			t[y][x]++
		}
	} else if steps := l.to.x - l.from.x; -steps == l.to.y - l.from.y {
		sign := int(math.Copysign(1, float64(steps)))
		for i := 0; i <= int(math.Abs(float64(steps))); i++ {
			x, y := l.from.x + sign*i, l.from.y + -sign*i
			t[y][x]++
		}
	}
}

func main() {
	data := ReadData("input")
	xMax, yMax := GetMaxSize(data)

	table := make(Table, yMax)
	for i := range table {
		table[i] = make([]int, xMax)
	}

	for _, l := range data {
		table.StrikeLine(l)
	}

	var atLeastTwoCount int
	for y := 0; y < yMax; y++ {
		for x := 0; x < xMax; x++ {
			if val := table[y][x]; val >= 2 {
				atLeastTwoCount++
			}
		}
	}

	fmt.Println(atLeastTwoCount)
}
