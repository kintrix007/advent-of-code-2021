import fs from "fs";

function main() {
    const cont = fs.readFileSync("input").toString().trim().split("\n");
    const len = cont[0]!.length;

    const tmpCommonBits = cont.map(x => x.split("").map( x => +x * 2 - 1 ))
                              .reduce((acc, x) => acc.map( (_, i) => acc[i]! + x[i]! ))
                              .map(x => +(x > 0))
                              .join("");
    const commonBits = parseInt(tmpCommonBits, 2);
    const max = (1 << len) - 1;
    console.log(commonBits * (max - commonBits))
    
}

main();
