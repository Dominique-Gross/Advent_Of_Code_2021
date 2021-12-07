#### DAY 1 ####
using Statistics
# Part 1

data = readlines("Day_7/input.txt")
input = parse.(Int, split(data[1], ','))

function part1(input)
    return sum(abs.(input .- median(input)))
end

part1(input)

# Part 2

function part2(input)
    md = 0:maximum(input)
    cons = zeros(size(md))
    for (index,center) in enumerate(md)
        for point in input
            dis=abs.(point - center) + sum(0:abs(point-center)-1)
            cons[index] += dis
        end
    end

    return minimum(cons)
end

part2(input)