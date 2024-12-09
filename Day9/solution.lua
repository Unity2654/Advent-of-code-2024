-- Reading the input file
f = io.open("smallPuzzle.txt")
line = f:read("*line")
input = {}
for w in line:gmatch(".") do
    table.insert(input,tonumber(w))
end


--
-- Part 1
--

function parse(cmps)
    isFile = true
    out = {}
    id = 0
    for _,i in ipairs(cmps) do
        if i~=0 then
            for a=1,i do
                if isFile then
                    table.insert(out,id)
                else
                    table.insert(out,".")
                end
            end
        end
        if isFile then
            id = id+1
        end
        isFile = not isFile
    end
    return out
end

function decalage(full)
    first= 1
    last = #full
    while last > first and full[first] and full[last] do
        while full[first] and full[first] ~= "." do
            first = first+1
        end
        while full[last] and full[last] =="." do
            last = last-1
        end
        if last > first then
            full[first],full[last] = full[last],full[first]
        end
    end
    return full
end

function checksum(table)
    sum = 0
    for i,e in ipairs(table) do
        if e~="." then
            sum = sum + e*(i-1)
        end
    end
    return sum
end

print(checksum(decalage(parse(input))))

--
-- Part 2
--

function findEmptySpace(n,table)
    for i,e in ipairs(table) do
        if e == "." then
            size = 0
            diff = 0
            while table[diff+i] == "." do
                size = size+1
                if size == n then
                    return i
                end
                diff = diff+1
            end
        end
    end
    return nil
end

function fullBlock(table,i,j)
    offset = 0
    id = table[i]
    while table[i+offset] and table[i+offset] == id do
        table[i+offset],table[j+offset] = table[j+offset],table[i+offset]
        offset = offset +1
    end
    return table
end

function decalagev2(full)
    last = #full
    size = 0
    while last > 1 do
        for _,e in pairs(full) do
            io.write(e.." ")
        end
        print()
        if full[last] ~= "." then
            curr = full[last]
            size = 0
            while full[last] == curr do
                last = last-1
                size = size+1
            end
        end
        emptySpace = findEmptySpace(size-1,full)
        if emptySpace then fullBlock(full,emptySpace,last+1) end
        last = last-1
    end
    return full
end
decalagev2(parse(input))
