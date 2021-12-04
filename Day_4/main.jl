#### DAY 4 ####

# Part 1

input = readlines("Day_4/input.txt")

mutable struct Bingo
    layout::Array{Int}
    score::Int
end


function part1(input)
    flag = true
    tirages = parse.(Int, split(input[1], ","))

    boards = Array{Bingo}(undef, 0)
    flag = false
    ref = 0
    current_board = Bingo(zeros(5, 5), 0)
    for (index, line) in enumerate(input[2:end])
        if index > 1
            flag = true
        end
        if isempty(line)
            if flag
                current_board.score = sum(current_board.layout)
                boards = push!(boards, current_board)
            end
            ref = index
            current_board = Bingo(zeros(5, 5), 0)
        else
            current_board.layout[index-ref, :] = parse.(Int, split(line))
        end
    end

    current_board.score = sum(current_board.layout)
    boards = push!(boards, current_board)

    for tirage in tirages
        for board in boards
            if !isempty(board.layout[board.layout.==tirage])
                board.layout[board.layout.==tirage] .= -1
                board.score -= tirage
            end

            result_lignes = sum(board.layout, dims = 1)
            result_colons = sum(board.layout, dims = 2)

            if !isempty(result_lignes[result_lignes.==-5]) | !isempty(result_colons[result_colons.==-5])
                return tirage * board.score
            end
        end
    end
end

println("Part 1: " * string(part1(input)))
# Part 2

function part2(input)
    flag = true
    tirages = parse.(Int, split(input[1], ","))
    
    boards = Array{Bingo}(undef, 0)
    flag = false
    ref = 0
    current_board = Bingo(zeros(5, 5), 0)
    for (index, line) in enumerate(input[2:end])
        if index > 1
            flag = true
        end
        if isempty(line)
            if flag
                current_board.score = sum(current_board.layout)
                boards = push!(boards, current_board)
            end
            ref = index
            current_board = Bingo(zeros(5, 5), 0)
        else
            current_board.layout[index-ref, :] = parse.(Int, split(line))
        end
    end

    current_board.score = sum(current_board.layout)
    boards = push!(boards, current_board)
    boards_count = length(boards)
    for tirage in tirages
        for board in boards
            if !isempty(board.layout[board.layout.==tirage])
                board.layout[board.layout.==tirage] .= -1
                board.score -= tirage
            end

            result_lignes = sum(board.layout, dims = 1)
            result_colons = sum(board.layout, dims = 2)

            if !isempty(result_lignes[result_lignes.==-5]) | !isempty(result_colons[result_colons.==-5])
                boards_count -= 1
                board.layout=1000*ones(5,5) # Put stupid numbers here to not select the same board twice
                if boards_count == 0
                    return tirage * board.score
                end
            end
        end
    end
end

println("Part 2: " * string(part2(input)))
