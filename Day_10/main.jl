#### DAY 10 ####

input = collect.(readlines("Day_10/input.txt"))

# Part 1

function part1(input)

    dico = Dict('(' => ')', '{' => '}', '[' => ']', '<' => '>')
    score = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)

    total = zeros(Int, length(input))

    for (index, line) in enumerate(input)
        storage = Vector{Char}(undef, 0)
        for elt in line
            if length(storage) == 0
                push!(storage, line[1])
                if !haskey(dico, line[1])
                    total[index] = score[line[1]]
                    continue
                end
            else
                if haskey(dico, elt)
                    push!(storage, elt)
                else
                    if dico[storage[end]] == elt
                        pop!(storage)
                    else
                        total[index] = score[elt]
                        break
                    end
                end
            end
        end
    end
    return total
end

total = part1(input)
sum(total)

# Part 2

input_2 = input[total.==0]

function part2(input)

    dico = Dict('(' => ')', '{' => '}', '[' => ']', '<' => '>')
    score = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)
    total = zeros(Int, length(input))

    for (index, line) in enumerate(input)
        storage = Vector{Char}(undef, 0)
        for elt in line
            if length(storage) == 0
                push!(storage, line[1])
            else
                if haskey(dico, elt)
                    push!(storage, elt)
                else
                    if dico[storage[end]] == elt
                        pop!(storage)
                    end
                end
            end
        end
        storage = storage[end:-1:1]
        for elt in storage
           total[index] *= 5
           total[index] += score[dico[elt]]
        end
    end
    total = sort(total)
    return total[convert(Int,round(length(total)/2))]
end


score = part2(input_2)