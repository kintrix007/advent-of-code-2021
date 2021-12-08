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
    for l in io.lines("input", "l") do
        local digits = processLine(l)
        -- table.show(digits)
    end
end

part1()
part2()
