package main

import (
	"os"
	"strconv"
	"strings"
)

func ReadData(filename string) []Line {
	fileCont, _ := os.ReadFile(filename)
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
