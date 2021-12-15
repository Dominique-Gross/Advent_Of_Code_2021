#### DAY 15 ####

input = readlines("Day_15/input.txt")

mutable struct Node
    x::Int
    y::Int
    g::Int # Cost : distance from the start accounting for the risk
    h::Int # Manhattan distance to the end
    ComesFrom::Vector{Tuple} # Which node this one is coming from
end

function isequal(first::Node, nodes::Vector{Node})
    for second in nodes
        #if (first.x == second.x) && (first.y == second.y) && (first.g == second.g) && (first.h == second.h) && (first.ComesFrom == second.ComesFrom)
        if (first.x == second.x) && (first.y == second.y)
            return true
        end
    end
    return false
end

function count(final::Node, map::Matrix)
    list = final.ComesFrom
    counter = 0
    for node = 3:length(list)
        counter += map[list[node][2], list[node][1]]
    end
    counter += map[end,end]
    return counter, final
end
# Part 1

function GetNeighbors(input::Node, map::Matrix, exit::Tuple)
    x = input.x
    y = input.y
    loc = copy(input.ComesFrom)
    loc = push!(loc, (x, y))
    m, n = size(map)

    if (x != 1) && (y != 1) && (x != n) && (y != m)
        Neighbors = Vector{Node}(undef, 4)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[3] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
        Neighbors[4] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (x == 1) && (y == 1)
        Neighbors = Vector{Node}(undef, 2)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (x == n) && (y == m)
        Neighbors = Vector{Node}(undef, 2)
        Neighbors[1] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
    elseif (x == 1) && (y == m)
        Neighbors = Vector{Node}(undef, 2)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
    elseif (x == n) && (y == 1)
        Neighbors = Vector{Node}(undef, 2)
        Neighbors[1] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (x == 1)
        Neighbors = Vector{Node}(undef, 3)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
        Neighbors[3] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (y == 1)
        Neighbors = Vector{Node}(undef, 3)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[3] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (x == n)
        Neighbors = Vector{Node}(undef, 3)
        Neighbors[1] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
        Neighbors[3] = Node(x, y + 1, input.g + map[y+1, x], abs(x - exit[1]) + abs(y + 1 - exit[2]), loc)
    elseif (y == m)
        Neighbors = Vector{Node}(undef, 3)
        Neighbors[1] = Node(x + 1, y, input.g + map[y, x+1], abs(x + 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[2] = Node(x - 1, y, input.g + map[y, x-1], abs(x - 1 - exit[1]) + abs(y - exit[2]), loc)
        Neighbors[3] = Node(x, y - 1, input.g + map[y-1, x], abs(x - exit[1]) + abs(y - 1 - exit[2]), loc)
    else
        println("Error : this case is not possible")
    end
    return Neighbors
end

function part1(input)
    map = Matrix{Int}(undef, length(input), length(collect(input)))
    for (index, line) in enumerate(input)
        map[index, :] = permutedims([parse(Int, x) for x in line])
    end
    return A_star(map)
end
    
function A_star(map)
    m, n = size(map)

    # Start and stop nodes
    start_path = Vector{Tuple}()
    push!(start_path, (0, 0))
    start_node = Node(1, 1, 0, 0, start_path)

    # Queue with all the nodes to be checked
    ToCheck = Vector{Node}(undef, 1)
    ToCheck[1] = start_node

    # List of nodes having been checked
    Closed = Vector{Node}()
    # A* algorithm
    while !isempty(ToCheck)
        (_, pos) = findmin((p -> p.h).(ToCheck) .+ (p -> p.g).(ToCheck))
        current_node = ToCheck[pos]
        if (current_node.x == n) && (current_node.y == m)
            ToCheck = []
            return count(current_node, map)
        else
            filter!(x -> x != current_node, ToCheck)
            Neighbors = GetNeighbors(current_node, map, (n, m))

            for Neighbor in Neighbors
                score = Neighbor.h + Neighbor.g
                if isequal(Neighbor, Closed)
                    continue
                else
                    flag = true
                    for nodetocheck in ToCheck
                        if (nodetocheck.x == Neighbor.x) && (nodetocheck.y == Neighbor.y)
                            if (score > nodetocheck.h + nodetocheck.g)
                                flag = false
                                break
                            else
                                filter!(x -> x != nodetocheck, ToCheck)
                            end
                        end
                    end
                    if flag
                        push!(ToCheck, Neighbor)
                    end
                end
            end
            push!(Closed, current_node)
        end
    end
end

counter, final = part1(input)


# Part 2

function part2(input)
    map = Matrix{Int}(undef, length(input), length(collect(input)))
    for (index, line) in enumerate(input)
        map[index, :] = permutedims([parse(Int, x) for x in line])
    end

    new_map = map
    for _ in 1:4
        new_map = new_map .+ 1
        new_map[new_map .>9] .= 1
        map = [map new_map]
    end

    new_map = map
    for _ in 1:4
        new_map = new_map .+ 1
        new_map[new_map .>9] .= 1
        map = [map ; new_map]
    end

    return A_star(map)
end

counter, final = part2(input)