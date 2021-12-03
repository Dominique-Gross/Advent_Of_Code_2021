#### DAY 1 ####
using Statistics
# Part 1

input1 = collect.(readlines("Day_3/part1.txt"))

function part1(input1)
    data = Array{Int}(undef, length(input1[1]), length(input1))
    for x = 1:length(input1[1]), y = 1:length(input1)
        data[x, y] = parse(Int, input1[y][x])
    end
    γ = [convert(Int, x) for x in round.(mean(data, dims = 2))]
    ϵ = [ x == 1 ? 0 : 1 for x in γ]
    return parse(Int,String(map(x->x+'0', vec(γ))),base=2) * parse(Int,String(map(x->x+'0', vec(ϵ))),base=2)
end
println(part1(input1))

# Part 2

input2 = collect.(readlines("Day_3/part1.txt"))

function part2(input2)
    data = Array{Int}(undef, length(input1[1]), length(input1))
    for x = 1:length(input1[1]), y = 1:length(input1)
        data[x, y] = parse(Int, input1[y][x])
    end
    data_ox = permutedims(data)
    for (index,col) in enumerate(eachcol(data_ox))
        value = mean(data_ox[:,index])
        if value < 0.5
            data_ox=data_ox[data_ox[:,index].==0,:]
        else
            data_ox=data_ox[data_ox[:,index].==1,:]
        end
        m,n = size(data_ox)
        if m==1
            break
        end
    end
    oxygen = data_ox

    data_co2 = permutedims(data)
    for (index,col) in enumerate(eachcol(data_co2))
        value = mean(data_co2[:,index])
        if value < 0.5
            data_co2=data_co2[data_co2[:,index].==1,:]
        else
            data_co2=data_co2[data_co2[:,index].==0,:]
        end
        m,n = size(data_co2)
        if m==1
            break
        end
    end
    co2 = data_co2
    return parse(Int,String(map(x->x+'0', vec(oxygen))),base=2) * parse(Int,String(map(x->x+'0', vec(co2))),base=2)
end   
