#include <stdio.h>

const char Input[] = "input";
const int Width = 100;
const int Height = 100;

inline void printTable(const int table[Height][Width]);
inline void printArr(const int table[]);
void part1(const int table[Height][Width]);
void part2(int table[Height][Width]);
int getBasinSize(int table[Height][Width], int x, int y);

void readInput(const char filename[], int arr[Height][Width]) {
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
    readInput(Input, table);
    part1(table);
    part2(table);
}

void part1(const int table[Height][Width]) {
    int sum = 0;
    for (int y = 0; y < Height; y++) {
        for (int x = 0; x < Width; x++) {
            int depth = table[y][x], belowCount = 0;
            if (x > 0        && table[y][x-1] <= depth) belowCount++;
            if (x < Width-1  && table[y][x+1] <= depth) belowCount++;
            if (y > 0        && table[y-1][x] <= depth) belowCount++;
            if (y < Height-1 && table[y+1][x] <= depth) belowCount++;
            if (belowCount == 0) {
                // printf("./%s:%d:%d - %d\n", Input, y+1, x+1, height);
                sum += 1 + depth;
            }
        }
    }
    printf("%d\n", sum);
}

void part2(int table[Height][Width]) {
    int biggest[3] = {0, 0, 0};
    for (int y = 0; y < Height; y++) {
        for (int x = 0; x < Width; x++) {
            int depth = table[y][x], belowCount = 0;
            if (x > 0        && table[y][x-1] <= depth) belowCount++;
            if (x < Width-1  && table[y][x+1] <= depth) belowCount++;
            if (y > 0        && table[y-1][x] <= depth) belowCount++;
            if (y < Height-1 && table[y+1][x] <= depth) belowCount++;
            if (belowCount == 0) {
                int basinDepth = getBasinSize(table, x, y);
                if (basinDepth > biggest[0]) biggest[0] = basinDepth;
                else if (basinDepth > biggest[1]) biggest[1] = basinDepth;
                else if (basinDepth > biggest[2]) biggest[2] = basinDepth;
                // printf("./%s:%d:%d - %d\n", Input, y+1, x+1, basinDepth);
            }
        }
    }
    printf("%d\n", biggest[0] * biggest[1] * biggest[2]);
}


int getBasinSize(int table[Height][Width], int x, int y) {
    static int a;
    int depth = table[y][x];
    if (depth == 9) return 0;
    table[y][x] = 9;
    int size = 1;
    if (x > 0        && table[y][x-1] > depth) size += getBasinSize(table, x-1, y);
    if (x < Width-1  && table[y][x+1] > depth) size += getBasinSize(table, x+1, y);
    if (y > 0        && table[y-1][x] > depth) size += getBasinSize(table, x, y-1);
    if (y < Height-1 && table[y+1][x] > depth) size += getBasinSize(table, x, y+1);
    // printf("%d,%d-%d ", x+1, y+1, size);
    return size;
}

inline void printTable(const int table[Height][Width]) {
    for (int y = 0; y < Height; y++) {
        printArr(table[y]);
    }
}

inline void printArr(const int table[]) {
    for (int i = 0; i < Width; i++) {
        printf("%d", table[i]);
    }
    printf("\n");
}
