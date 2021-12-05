#### DAY 1 ####
using DelimitedFiles
# Part 1

input = readlines("Day_5/input.txt")

function part1(input)
    data = Dict{Tuple,Int}()
    for line in eachrow(input)
        x1 = parse(Int, line[1][1:findfirst(',', line[1])-1])
        y1 = parse(Int, line[1][findfirst(',', line[1])+1:findfirst(' ', line[1])-1])
        x2 = parse(Int, line[1][findlast(' ', line[1])+1:findlast(',', line[1])-1])
        y2 = parse(Int, line[1][findlast(',', line[1])+1:end])

        if x1 == x2 || y1 == y2
            if x2 < x1
                x1, x2 = x2, x1
            end
            if y2 < y1
                y1, y2 = y2, y1
            end
            for x = x1:x2, y = y1:y2
                if haskey(data, (x, y))
                    data[(x, y)] += 1
                else
                    data[(x, y)] = 1
                end
            end
        end
    end
    total_score = collect(values(data))
    return length(total_score[total_score.>1])
end

println("Part 1 : " * string(part1(input)))

# Part 2

function part2(input)
    data = Dict{Tuple,Int}()
    for line in eachrow(input)
        x1 = parse(Int, line[1][1:findfirst(',', line[1])-1])
        y1 = parse(Int, line[1][findfirst(',', line[1])+1:findfirst(' ', line[1])-1])
        x2 = parse(Int, line[1][findlast(' ', line[1])+1:findlast(',', line[1])-1])
        y2 = parse(Int, line[1][findlast(',', line[1])+1:end])

        if x1 == x2 || y1 == y2
            if x2 < x1
                x1, x2 = x2, x1
            end
            if y2 < y1
                y1, y2 = y2, y1
            end
            for x = x1:x2, y = y1:y2
                if haskey(data, (x, y))
                    data[(x, y)] += 1
                else
                    data[(x, y)] = 1
                end
            end
        else
            x2 < x1 ? stepx = -1 : stepx = 1
            y2 < y1 ? stepy = -1 : stepy = 1
            x = x1
            y = y1
            while x != x2 && y != y2
                if haskey(data, (x, y))
                    data[(x, y)] += 1
                else
                    data[(x, y)] = 1
                end
                x += stepx
                y += stepy
            end
            if haskey(data, (x, y))
                data[(x, y)] += 1
            else
                data[(x, y)] = 1
            end
        end
    end
    total_score = collect(values(data))
    return length(total_score[total_score.>1])
end

println("Part 2 : " * string(part2(input)))
