#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream f("input");

    std::string op;
    int amount;
    int depth = 0, pos = 0;
    while (f >> op >> amount) {
        if      (op[0] == 'f') pos += amount;
        else if (op[0] == 'd') depth += amount;
        else if (op[0] == 'u') depth -= amount;
    }
    std::cout << "d: " << depth << ", pos: " << pos << " multiplied = " << depth * pos << std::endl;
    
    return 0;
}
