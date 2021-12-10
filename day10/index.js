"use strict";

import fs from "fs";

const BracketMap = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
};

const BracketScore = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
};

function main() {
    const allLines = fs.readFileSync("input").toString().trim().split("\n");
    const sum = allLines.reduce((acc, line) => {
        const stack = [];
        var incorrect = null;
        for (var i = 0; i < line.length; i++) {
            const ch = line[i];
            if ([ '(', '[', '{', '<' ].includes(ch)) {
                stack.push(ch);
            } else {
                const expected = BracketMap[stack.pop()];
                if (ch != expected) {
                    incorrect = ch;
                    break;
                }
            }
        }
        // console.log({incorrect});
        if (incorrect != null) return acc + BracketScore[incorrect];
        return acc;
    }, 0);
    console.log(sum);
}

main();
