#include <stdio.h>

const int Width = 100;
const int Height = 100;

inline void printTable(int table[Height][Width]);
inline void printArr(int table[]);
void part1(int table[Height][Width]);
void part2(int table[Height][Width]);

void readInput(char filename[], int arr[Height][Width]) {
    FILE *f = fopen(filename, "r");
    char line[Width+1];
    for (int y = 0; y < Height; y++) {
        fscanf(f, "%s\n", line);
        for (int x = 0; x < Width; x++) {
            int num = line[x] - '0';    // Convert char to int
            arr[y][x] = num;
        }
    }
    fclose(f);
}

int main() {
    int table[Height][Width];
    readInput("input", table);
    part1(table);
    part2(table);
}

void part1(int table[Height][Width]) {
    int sum = 0;
    for (int y = 0; y < Height; y++) {
        for (int x = 0; x < Width; x++) {
            int height = table[y][x], belowCount = 0;
            if (x > 0        && table[y][x-1] <= height) belowCount++;
            if (x < Width-1  && table[y][x+1] <= height) belowCount++;
            if (y > 0        && table[y-1][x] <= height) belowCount++;
            if (y < Height-1 && table[y+1][x] <= height) belowCount++;
            if (belowCount == 0) {
                printf("./input:%d:%d - %d\n", y+1, x+1, height);
                sum += 1 + height;
            }
        }
    }
    printf("%d\n", sum);
}

void part2(int table[Height][Width]) {

}

inline void printTable(int table[Height][Width]) {
    for (int y = 0; y < Height; y++) {
        printArr(table[y]);
    }
}

inline void printArr(int table[]) {
    for (int i = 0; i < Width; i++) {
        printf("%d", table[i]);
    }
    printf("\n");
}
