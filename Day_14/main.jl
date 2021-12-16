#### DAY 14 ####

input = readlines("Day_14/input.txt")

# Part 1

function part1(input, steps)
    chain = collect(input[1])
    input = input[3:end, :]
    base = Dict{String,String}()
    for line in eachrow(input)
        tmp = split(line[1], " -> ")
        base[string(tmp[1])] = string(tmp[2])
    end

    new = Vector{String}()
    pos = Vector{Int}()
    for step = 1:steps
        for index = 1:length(chain)-1
            tmp = join(chain[index:index+1])
            push!(new, base[tmp])
            push!(pos, index + 1)
        end

        for index = 1:length(new)
            loc = pos[index]
            chain_first = chain[1:loc-1]
            chain_last = chain[loc:end]
            chain = join(chain_first) * new[index] * join(chain_last)
            pos .+= 1
        end
        new = Vector{String}()
        pos = Vector{Int}()
    end

    chain = collect(chain)
    decompte = Vector{Int}()
    for elt in unique(chain)
        push!(decompte, length(chain[chain.==elt]))
    end
    return decompte, chain
end

# decompte, chain = part1(input, 10)


# Part 2

function split_poly(pair, cara)
    output = Vector{String}(undef, 2)

    output[1] = string(pair[1]) * cara
    output[2] = cara * string(pair[2])

    return output
end

function part2(input, steps)
    chain = collect(input[1])
    input = input[3:end, :]
    base = Dict{String,String}()
    for line in eachrow(input)
        tmp = split(line[1], " -> ")
        base[string(tmp[1])] = string(tmp[2])
    end

    counter = Dict{String,Int}()
    for index = 1:length(chain)-1
        cara = join(chain[index:index+1])
        if haskey(counter, cara)
            counter[cara] += 1
        else
            counter[cara] = 1
        end
    end


    for index = 1:length(chain)-1
        tmp = join(chain[index:index+1])
        counter[tmp] -= 1
        output = split_poly(tmp, base[tmp])
        for cara in output
            if haskey(counter, cara)
                counter[cara] += 1
            else
                counter[cara] = 1
            end
        end
    end

    for step = 1:steps-1
        tmp_dico = Dict{String,Int}()
        for key in keys(counter)
            if counter[key] != 0
                scale = counter[key]
                output = split_poly(key, base[key])
                if haskey(tmp_dico, key)
                    tmp_dico[key] -= scale
                else
                    tmp_dico[key] = -scale
                end
                for cara in output
                    if haskey(tmp_dico, cara)
                        tmp_dico[cara] += scale
                    else
                        tmp_dico[cara] = scale
                    end
                end
            end
        end

        for key in keys(tmp_dico)
            if haskey(counter, key)
                counter[key] += tmp_dico[key]
            else
                counter[key] = tmp_dico[key]
            end
        end
    end

    final_counter = Dict{Char,Real}()

    for key in keys(counter)
        tmp = collect(key)
        for chara in tmp
            if haskey(final_counter,chara)
                final_counter[chara] += counter[key]
            else
                final_counter[chara] = counter[key]
            end
        end
    end

    final_counter[chain[1]] += 1
    final_counter[chain[end]] += 1
    for key in keys(final_counter)
        final_counter[key] = round(final_counter[key]/2)
    end

    mini = Inf
    maxi = -Inf
    for key in keys(final_counter)
        value = final_counter[key]
        if value > maxi
            maxi = value
        end
        if value < mini
            mini = value
        end
    end

    return final_counter, maxi, mini
end

final_counter, maxi, mini = part2(input, 40)

