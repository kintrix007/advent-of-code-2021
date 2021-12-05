package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Point struct {
	x, y int
}

type Line struct {
	from, to Point
}

type Table [][]int

func ReadData() []Line {
	fileCont, _ := os.ReadFile("input")
	dataTmp := strings.Split(strings.Trim(string(fileCont), "\n"), "\n")

	data := make([]Line, len(dataTmp))
	for i, val := range dataTmp {
		points    := strings.Split(val, " -> ")
		point1Str := strings.Split(points[0], ",")
		p1x, _    := strconv.Atoi(point1Str[0])
		p1y, _    := strconv.Atoi(point1Str[1])
		point2Str := strings.Split(points[1], ",")
		p2x, _    := strconv.Atoi(point2Str[0])
		p2y, _    := strconv.Atoi(point2Str[1])
		data[i] = Line{Point{p1x, p1y}, Point{p2x, p2y}}
	}
	return data
}

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

func (t Table) StikeLine(l Line) {
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
	}
		
}

func main() {
	data := ReadData()
	xMax, yMax := GetMaxSize(data)

	table := make(Table, yMax)
	for i := range table {
		table[i] = make([]int, xMax)
	}
	
	for _, l := range data {
		table.StikeLine(l)
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
