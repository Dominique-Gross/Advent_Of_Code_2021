#### DAY 1 ####
using Statistics
# Part 1

input1 = parse.(Int,collect(readlines("Day_1/part1.txt")))

function part1(input)
    return sum([ x>0 ? 1 : 0 for x in diff(input) ])
end

part1(input1)

# Part 2

input2 = parse.(Int,collect(readlines("Day_1/part1.txt")))

function part2(input)
   part1([mean(input[x:x+2]) for x in 1:length(input)-2])
end

part2(input2)