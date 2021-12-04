#### DAY 2 ####
using DelimitedFiles
# Part 1

input1 = permutedims(readdlm("Day_2/part1.txt"))

mutable struct Position
    horz
    depth
    aim
end

function move!(pos::Position,command)
    direction = command[1]
    amp = command[2]
    if direction == "forward"
        pos.horz += amp
    elseif direction == "up"
        pos.depth -= amp
    elseif direction == "down"
        pos.depth += amp
    end
    return pos
end

function part1(input)
    pos = Position(0,0,0)
    for current in eachcol(input)
        pos = move!(pos,current)
    end
    println(pos.depth * pos.horz)
end
part1(input1)

# Part 2

input2 = permutedims(readdlm("Day_2/part1.txt"))

function move2!(pos::Position,command)
    direction = command[1]
    amp = command[2]
    if direction == "forward"
        pos.horz += amp
        pos.depth += pos.aim * amp
    elseif direction == "up"
        pos.aim -= amp
    elseif direction == "down"
        pos.aim += amp
    end
    return pos
end

function part2(input)
    pos = Position(0,0,0)
    for current in eachcol(input)
        pos = move2!(pos,current)
    end
    println(pos.depth * pos.horz)
end
part2(input1)