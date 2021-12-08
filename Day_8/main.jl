#### DAY 8 ####

# Part 1

function part1()
    counter = 0
    for line in eachline("Day_8/input.txt")
        output = split(line[62:end], ' ')
        number_of_digits = length.(output)
        counter += sum([sum(number_of_digits .== x) for x in [2, 3, 4, 7]])
    end
    return counter
end

part1()

# Part 2

function part2()
    test=Vector{Vector{Char}}(undef,0)
    total = 0
    for line in eachline("Day_8/input.txt")
        output_tmp = split(line[62:end], ' ')
        loc = findfirst("|",line)
        test_tmp = split(line[1:loc[1]-2],' ')

        test=Vector{Vector{Char}}(undef,length(test_tmp))
        output=Vector{Vector{Char}}(undef,4)
        for (index,entry) in enumerate(test_tmp)
            test[index] = collect(entry)
        end
        for (index,entry) in enumerate(output_tmp)
            output[index] = collect(entry)
        end

        values = Dict{Int,Vector}()
        values[1] = test[length.(test).==2][1]
        values[4] = test[length.(test).==4][1]
        values[7] = test[length.(test).==3][1]
        values[8] = test[length.(test).==7][1]

        # On cherche le 9

        union_9 = unique([values[4] ; values[7]])
        pool = test[length.(test).==6]
        for possibility in pool
            if issubset(union_9,possibility)
                values[9]=possibility
                filter!( x -> x != possibility,pool)
            end
        end

        # On cherche le 0 et le 6

        for possibility in pool
            if issubset(values[1],possibility)
                values[0] = possibility
            else
                values[6] = possibility
            end
        end

        # On cherche le 3

        pool = test[length.(test).==5]

        for possibility in pool
            if issubset(values[1],possibility)
                values[3] = possibility
                filter!( x -> x != possibility,pool)
            end
        end

        # On cherche le 5 et le 2

        for possibility in pool
            if issubset(possibility,values[9])
                values[5] = possibility
            else
                values[2] = possibility
            end
        end
        count = 0
        for (index,entry) in enumerate(output)
            for ii in 0:9
                if issubset(entry,values[ii]) && issubset(values[ii],entry)
                    count += ii * 10^(4-index)
                end
            end
        end
        total += count
    end
    return total
end

println(part2())