import fs from "fs";

function main() {
    const cont = fs.readFileSync("input").toString().trim().split("\n").map(x => x.split("").map(Number));
    
    console.log(part1(cont));
    console.log(part2(cont));
}

function part1(cont: number[][]) {
    const tmpCommonBits = cont.map(x => x.map( x => x * 2 - 1 ))
                              .reduce((acc, x) => acc.map( (_, i) => acc[i]! + x[i]! ))
                              .map(x => +(x >= 0))
                              .join("");
    const commonBits = parseInt(tmpCommonBits, 2);

    const len = cont[0]!.length;
    const max = (1 << len) - 1;
    return commonBits * (max - commonBits);
}

function part2(cont: number[][]) {
    const getDiff = (arr: number[][], at: number): number => arr.reduce((acc, x) => x[at] == 1 ? acc+1 : acc-1, 0);
    const getMostCommon = (arr: number[][], at: number): number => +(getDiff(arr, at) >= 0);
    
    const get = (cont: number[][], at: number, shouldKeep: (a: number, b: number) => boolean): number => {
        if (cont.length === 1) return parseInt(cont[0]!.join(""), 2);
        const mostCommon = getMostCommon(cont, at);
        const rest = cont.filter(x => shouldKeep(x[at]!, mostCommon));
        return get(rest, at+1, shouldKeep);
    }

    const a = get(cont, 0, (a, b) => a === b);
    const b = get(cont, 0, (a, b) => a !== b);
    return a * b;
}

main();
