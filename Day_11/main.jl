#### DAY 11 ####


# Part 1

function evolution!(input::Matrix, storage::Vector, m::Int, n::Int, counter::Int)
    tmp = input

    for (row, _) in enumerate(eachrow(input)), (col, _) in enumerate(eachcol(input))
        if input[row, col] > 9
            counter += 1
            negx = 1
            posx = 1
            negy = 1
            posy = 1

            (row == 1) && (negx = 0)
            (row == m) && (posx = 0)
            (col == 1) && (negy = 0)
            (col == n) && (posy = 0)

            tmp[row-negx:row+posx, col-negy:col+posy] .+= 1
            push!(storage, (row, col))
        end
    end

    input = tmp

    for loc in storage
        input[loc[1], loc[2]] = 0
    end

    if isempty(input[input.>9])
        return input, counter
    else
        input, counter = evolution!(input, storage, m, n, counter)
    end
end


function part1()
    tmp = collect.(readlines("Day_11/input.txt"))
    input = Matrix{Int}(undef, length(tmp), length(tmp[1]))
    for (index, line) in enumerate(eachline("Day_11/input.txt"))
        temp = Vector{Int}(undef, 0)
        for value in line
            push!(temp, parse(Int, value))
        end
        input[index, :] = temp
    end
    m, n = size(input)
    counter = 0
    for step = 1:100
        input .+= 1
        storage = Vector{Tuple}()
        input, counter = evolution!(input, storage, m, n, counter)
    end
    return counter
end

part1()


# Part 2

function part2()
    tmp = collect.(readlines("Day_11/input.txt"))
    input = Matrix{Int}(undef, length(tmp), length(tmp[1]))
    for (index, line) in enumerate(eachline("Day_11/input.txt"))
        temp = Vector{Int}(undef, 0)
        for value in line
            push!(temp, parse(Int, value))
        end
        input[index, :] = temp
    end
    m, n = size(input)
    counter = 0
    step = 1
    while true
        input .+= 1
        storage = Vector{Tuple}()
        input, counter = evolution!(input, storage, m, n, counter)

        if sum(input) == 0
            return step
        end

        step += 1
    end
end

part2()