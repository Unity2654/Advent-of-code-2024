-- Reading the input file
machines = {}
f = io.open("smallPuzzle.txt")
line = true
while line do
    machine = {}
    for _=1,3 do
        line = f:read("*line")
        vector = {}
        for w in line:gmatch("%d+") do
            table.insert(vector,tonumber(w))
        end
        table.insert(machine,vector)
    end
    table.insert(machines,machine)
    line = f:read("*line")
end

for _,m in ipairs(machines) do
    for _,e in ipairs(m) do
        io.write(e[1].." "..e[2].."\t")
    end
    print()
end

