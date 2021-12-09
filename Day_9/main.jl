#### DAY 9 ####

# Part 1

function differantiate(A::Matrix)
    forward = zeros(size(A))
    backward = zeros(size(A))
    result = Matrix{Bool}(undef, size(A))
    forward[:, 1:end-1] = A[:, 2:end] - A[:, 1:end-1]
    forward[:, end] .= 1

    backward[:, 2:end] = A[:, 2:end] - A[:, 1:end-1]
    backward[:, 1] .= -1

    for (index_l, _) in enumerate(eachrow(forward)), (index_c, _) in enumerate(eachcol(backward))
        if forward[index_l, index_c] > 0 && backward[index_l, index_c] < 0
            result[index_l, index_c] = true
        else
            result[index_l, index_c] = false
        end
    end

    return result

end


function part1()
    tmp = collect.(readlines("Day_9/input.txt"))
    input = Matrix{Int}(undef, length(tmp), length(tmp[1]))
    for (index, line) in enumerate(eachline("Day_9/input.txt"))
        temp = Vector{Int}(undef, 0)
        for value in line
            push!(temp, parse(Int, value))
        end
        input[index, :] = temp
    end

    result = differantiate(input) .* permutedims(differantiate(permutedims(input)))

    return sum(input[result]) + length(input[result]), result

end

result_part1, input_part2 = part1()
println("Part 1: $result_part1")

# Part 2

function enumerate_basin(loc::Tuple, counter::Dict, input)
    x = loc[1]
    y = loc[2]

    size_input = size(input)

    m = size_input[1]
    n = size_input[2]

    negx = 1
    posx = 1
    negy = 1
    posy = 1

    (x == 1) && (negx = 0)
    (x == m) && (posx = 0)
    (y == 1) && (negy = 0)
    (y == n) && (posy = 0)

    
    test=input[x-negx:x+posx, y-negy:y+posy]
    test[test.==9] .= 0

    for (indexx,x_pos) in enumerate(x-negx:x+posx), (indexy,y_pos) in enumerate(y-negy:y+posy)
        if x_pos != x && y_pos != y
            test[indexx,indexy] = 0
        end
    end
    
    diff = test .- input[x, y]

    coords = findall(x -> x > 0, diff)

    if !haskey(counter,(x,y))
        counter[(x, y)] = input[x, y]
    end

    if isempty(coords)
            return counter
    else
        for new_coord in coords
            counter = enumerate_basin((getindex(new_coord, 1)+x-negx-1, getindex(new_coord, 2)+y-negy-1), counter, input)
        end
        return counter
    end
end


function part2(input_part2)
    loc_basins = findall(x -> x == true, input_part2)

    tmp = collect.(readlines("Day_9/input.txt"))
    input = Matrix{Int}(undef, length(tmp), length(tmp[1]))
    for (index, line) in enumerate(eachline("Day_9/input.txt"))
        temp = Vector{Int}(undef, 0)
        for value in line
            push!(temp, parse(Int, value))
        end
        input[index, :] = temp
    end

    basins_size = Vector{Int}(undef, length(loc_basins))

    for (index,basin) in enumerate(loc_basins)
        counter = Dict{Tuple,Int}()
        counter = enumerate_basin((getindex(basin,1),getindex(basin,2)),counter,input)
        basins_size[index]=length(counter)
    end

    return sort(basins_size)
end

basins_size = part2(input_part2)