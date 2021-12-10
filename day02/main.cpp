#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream f("input");

    std::string op;
    int amount;
    int aim = 0, depth = 0, pos = 0;
    while (f >> op >> amount) {
        if (op[0] == 'f') {
            pos += amount;
            depth += aim * amount;
        }
        else if (op[0] == 'd') aim += amount;
        else if (op[0] == 'u') aim -= amount;
    }
    std::cout << "d: " << depth << ", pos: " << pos << " multiplied = " << depth * pos << std::endl;
    
    return 0;
}
