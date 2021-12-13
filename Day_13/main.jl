#### DAY 13 ####

input = readlines("Day_13/input.txt")

# Part 1

function folding!(coords,fold)
    if fold[1] == 'x'
        for coord in keys(coords)
            if coord[1]>fold[2]
            delete!(coords,coord) 
            coords[(fold[2]-(coord[1]-fold[2]), coord[2])]='#'
            end
        end
    elseif fold[1] == 'y'
        for coord in keys(coords)
            if coord[2]>fold[2]
                delete!(coords,coord)
            coords[(coord[1], fold[2]-(coord[2]-fold[2]))]='#'
            end
        end
    end
    return coords
end

function part1(input)
    flag = false
    coords = Dict{Tuple,Char}()
    folds = Array{Any}(undef,0,2)
    for line in input
        if line == ""
            flag = true
        else
            if !flag
                tmp = split(line, ',')
                coords[(parse(Int, tmp[1]),parse(Int, tmp[2]))]='#'
            else
                tmp = split(line, '=')
                folds = [folds ; [tmp[1][end] parse(Int, tmp[2])]]
            end
        end
    end
    coords = folding!(coords,folds[1,:])
    return coords
end

coords = part1(input)

# Part 2
using Plots
Plots.GRBackend()

function display_code(coords)
    plot()
    for key in keys(coords)
        display(plot!([key[1]],[-key[2]],markershape=:diamond,xlim=(-50,50),ylim=(-30,30),legend = false,markercolor=:black))
    end
end


function part2(input)
    flag = false
    coords = Dict{Tuple,Char}()
    folds = Array{Any}(undef,0,2)
    for line in input
        if line == ""
            flag = true
        else
            if !flag
                tmp = split(line, ',')
                coords[(parse(Int, tmp[1]),parse(Int, tmp[2]))]='#'
            else
                tmp = split(line, '=')
                folds = [folds ; [tmp[1][end] parse(Int, tmp[2])]]
            end
        end
    end
    for fold in eachrow(folds)
        coords = folding!(coords,fold)
    end
    display_code(coords)
end

part2(input)