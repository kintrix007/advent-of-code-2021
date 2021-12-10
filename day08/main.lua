#!/usr/bin/lua

function string.split(str, sep)
    sep = sep or "%s"
    local t = {}
    for m in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, m)
    end
    return t
end

function table.show(tab)
    local asStr = ""
    for _, t in pairs(tab) do
        asStr = asStr .. table.showSub(t) .. " "
    end
    return asStr
end

function table.showSub(tab)
    if tab == nil then return "nil" end
    local keys = ""
    for v, _ in pairs(tab) do
        if v ~= "len" then keys = keys .. v end
    end
    return keys .. "(" .. tab.len .. ")"
end

local function processLine(l)
    local _tmpTestsStr, _tmpDigitsStr = table.unpack(string.split(l, "|"))
    local _tmpDigits = string.split(_tmpDigitsStr .. " " .. _tmpTestsStr)
    local digits = {}
    for i, d in ipairs(_tmpDigits) do
        table.insert(digits, i, {})
        d:gsub(".", function(c) digits[i][c] = true end)
        digits[i].len = string.len(d)
    end
    return digits
end

local function filterLen(digits, len)
    local t = {}
    for _, d in ipairs(digits) do
        if d.len == len then table.insert(t, d) end
    end
    return t
end

local function isSame(digit1, digit2)
    if digit1 == nil or digit2 == nil or digit1.len ~= digit2.len then return false end
    for k, _ in pairs(digit1) do
        if digit1[k] ~= digit2[k] then return false end
    end
    for k, _ in pairs(digit2) do
        if digit1[k] ~= digit2[k] then return false end
    end
    return true
end

local function countSharedSides(digit1, digit2)
    if digit1 == nil or digit2 == nil then return 0 end
    local count = 0
    for k, _ in pairs(digit1) do
        if digit1[k] == digit2[k] then
            count = count + 1
        end
    end
    return count
end

local function identify(digit, codes)
    for num, d in pairs(codes) do
        if isSame(d, digit) then
            return num
        end
    end
    return nil
end


local function part1()
    local count = 0
    for l in io.lines("input", "l") do
        local d1, d2, d3, d4 = table.unpack(processLine(l))
        local digits = {d1, d2, d3, d4}
        for _, d in ipairs(digits) do
            if d.len == 2 or d.len == 3 or d.len == 4 or d.len == 7 then
                -- print(table.showSub(d))
                count = count + 1
            end
        end
    end
    print(count)
end

local function part2()
    local sum = 0
    for l in io.lines("input", "l") do
        local digits = processLine(l)
        -- table.show(digits)
        local codes = {}
        codes[1] = table.unpack(filterLen(digits, 2))
        codes[4] = table.unpack(filterLen(digits, 4))
        codes[7] = table.unpack(filterLen(digits, 3))
        codes[8] = table.unpack(filterLen(digits, 7))
        local digits235 = filterLen(digits, 5)
        for _, d in ipairs(digits235) do
            if codes[3] == nil and countSharedSides(d, codes[1]) == 2 then
                codes[3] = d
            end
            if codes[2] == nil and countSharedSides(d, codes[4]) == 2 then
                codes[2] = d
            end
            if codes[5] == nil and countSharedSides(d, codes[1]) ~= 2 and countSharedSides(d, codes[4]) ~= 2 then
                codes[5] = d
            end
        end
        local digits069 = filterLen(digits, 6)
        for _, d in ipairs(digits069) do
            if codes[6] == nil and countSharedSides(d, codes[1]) == 1 then
                codes[6] = d
            end
            if codes[9] == nil and countSharedSides(d, codes[4]) == 4 then
                codes[9] = d
            end
            if codes[0] == nil and countSharedSides(d, codes[1]) ~= 1 and countSharedSides(d, codes[4]) ~= 4 then
                codes[0] = d
            end
        end
        --[[
        print("zero: " .. table.showSub(codes[0]))
        print("one: " .. table.showSub(codes[1]))
        print("two: " .. table.showSub(codes[2]))
        print("three: " .. table.showSub(codes[3]))
        print("four: " .. table.showSub(codes[4]))
        print("five: " .. table.showSub(codes[5]))
        print("six: " .. table.showSub(codes[6]))
        print("seven: " .. table.showSub(codes[7]))
        print("eight: " .. table.showSub(codes[8]))
        print("nine: " .. table.showSub(codes[9]))
        --]]
        local numStr = identify(digits[1], codes) .. identify(digits[2], codes) .. identify(digits[3], codes) .. identify(digits[4], codes)
        local num = tonumber(numStr)
        sum = sum + num
    end
    print(sum)
end

part1()
part2()
