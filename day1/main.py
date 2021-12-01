#!/usr/bin/python3

window_size = 3

def main():
    with open("input", "r") as f:
        depths = [int(i) for i in f.read().strip().split()]

    windows = [sum(depths[i:i + window_size]) for i in range(len(depths) - (window_size-1))]

    inc = 0
    last = None
    for dsum in windows:
        if last == None:
            last = dsum
            continue
        if dsum > last: inc += 1
        last = dsum
    print(inc)


if __name__ == "__main__": main()
