"use strict";

import fs from "fs";

const BracketMap = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
};

const CorrBracketScore = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
};

const CompBracketScore = {
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4,
};

function main() {
    const allLines = fs.readFileSync("input").toString().trim().split("\n");
    const { corrupted: sum, incomplete } = allLines.reduce((acc, line) => {
        const stack = [];
        let incorrect = null;
        for (let i = 0; i < line.length; i++) {
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

        if (incorrect != null) {
            acc.corrupted += CorrBracketScore[incorrect];
            return acc;
        } else {
            // incomplete
            let score = 0;
            while (stack.length != 0) {
                score = score * 5 + CompBracketScore[BracketMap[stack.pop()]];
            }
            acc.incomplete.push(score);
            return acc;
        }
    }, { corrupted: 0, incomplete: [] });
    console.log(sum);
    console.log(incomplete.sort((a, b) => a - b)[Math.floor(incomplete.length/2)]);
}

main();
