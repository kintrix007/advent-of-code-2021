import sys.io.File;
using Lambda;
using StringTools;

typedef DumboTable = Array<Array<Dumbo>>;

class Main {
    static var dumboTable:DumboTable;
    public static function main() {
        var input = File.read("input");
        dumboTable = input.readAll().toString().trim().split("\n").map(line -> line.split("").map(char -> new Dumbo(Std.parseInt(char))));

        for (y in 0...dumboTable.length) for (x in 0...dumboTable[0].length) {
            var neighbors: Array<Dumbo> = [];
            for (i in -1...2) {
                var line = dumboTable[y+i];
                if (line == null) continue;
                for (j in -1...2) {
                    var dumbo = line[x+j];
                    if (dumbo == null) continue;
                    neighbors.push(dumbo);
                }
            }
            dumboTable[y][x].neighbors = neighbors;
        }

        var totalFlashes = 0;
        for (i in 0...100) {
            for (row in dumboTable) for (dumbo in row) {
                totalFlashes += dumbo.gainEnergy();
            }
            // for (row in dumboTable) Sys.println(row);
            // Sys.println('--- : $totalFlashes');

            for (row in dumboTable) for (dumbo in row) dumbo.hasFlashed = false;
        }
        Sys.println(totalFlashes);
    }
}

class Dumbo {
    public var energy(default, null):Int;
    public var hasFlashed = false;
    public var neighbors:Array<Dumbo> = [];

    public function new(energy) {
        this.energy = energy;
    }

    public function gainEnergy():Int {
        if (hasFlashed) return 0;
        this.energy++;
        if (energy <= 9) return 0;

        this.hasFlashed = true;
        this.energy = 0;
        var totalFlashes = 1;
        for (dumbo in neighbors) {
            totalFlashes += dumbo.gainEnergy();
        }
        return totalFlashes;
    }

    public function toString() {
        return this.energy == 0 ? "@0@" : '.${this.energy}.';
    }
}
