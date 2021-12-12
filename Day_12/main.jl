#### DAY 12 ####

input = readlines("Day_12/input.txt")

# Part 1
function create_roadmap(input)
    roadmap = Dict{String,Vector{String}}()
    for line in input
        tmp = split(line, '-')
        first = String(tmp[1])
        second = String(tmp[2])
        if haskey(roadmap, first)
            value = roadmap[first]
            if sum(second .== value) == 0
                push!(value, second)
                roadmap[first] = value
            end
        else
            roadmap[first] = [second]
        end
        if haskey(roadmap, second)
            value = roadmap[second]
            if sum(first .== value) == 0
                push!(value, first)
                roadmap[second] = value
            end
        else
            roadmap[second] = [first]
        end
    end
    return roadmap
end

function depth_first_search(node, done, roadmap, list, path)
    path = path * "-" * node
    neighbors = roadmap[node]
    counter = 0
    for neighbor in neighbors
        if sum(neighbor .== done) > 0
            counter += 1
        end
    end

    if node == "end"
        push!(list, path)
        return list
    elseif counter == length(neighbors)
        return list
    else
        if lowercase(node) == node
            push!(done, node)
        end
        for neighbor in neighbors
            if sum(neighbor .== done) == 0
                list = depth_first_search(neighbor, copy(done), roadmap, list, path)
            end
        end
    end
    return list
end

function part1(input)

    roadmap = create_roadmap(input)

    node = "start"
    done = Vector{String}()
    path = ""
    list = Vector{String}()
    list = depth_first_search(node, done, roadmap, list, path)

    return list
end

list = part1(input)


# Part 2

function depth_first_search_2(node, done, roadmap, list, path, flag, forbid)
    path = path * "-" * node
    neighbors = roadmap[node]
    counter = 0
    for neighbor in neighbors
        if sum(neighbor .== done) > 0
            counter += 1
        end
    end

    if node == "end"
        push!(list, path)
        return list
    elseif counter == length(neighbors)
        return list
    else
        if lowercase(node) == node
            if flag
                push!(done, node)
            else
                if node != "start"
                    if sum(forbid .== node) == 0
                        push!(forbid, node)
                    else
                        flag = true
                        for cave in forbid
                            push!(done,cave)
                        end
                    end
                else
                    push!(done, node)
                end
            end
        end
        for neighbor in neighbors
            if sum(neighbor .== done) == 0
                list = depth_first_search_2(neighbor, copy(done), roadmap, list, path, flag, copy(forbid))
            end
        end
    end
    return list
end

function part2(input)

    roadmap = create_roadmap(input)
    node = "start"
    done = Vector{String}()
    path = ""
    list = Vector{String}()
    forbid = Vector{String}()
    flag = false
    list = depth_first_search_2(node, done, roadmap, list, path, flag, forbid)

    return list
end

list = part2(input)