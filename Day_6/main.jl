#### DAY 6 ####

# Part 1

text = readlines("Day_6/input.txt")
text2=text[1]
input = parse.(Int,split(text2,","))
duration = 80

function part1(input,duration)
   
    score = zeros(Int,7)
    temp_8 = 0
    temp_7 = 0
    temp_6 = 0
    
    for (index,value) in enumerate(0:6)
        score[index]=length(input[input.==value])
    end

    for time in 1:duration
        
        temp_6 = temp_7
        temp_7 = temp_8
        temp_8 = 0

        if score[1]>0
            temp_8 = score[1]
        end
        
        score=circshift(score,-1)
        score[end] += temp_6
    end
    return sum(score)+temp_7+temp_8
end

part1(input,256)

# Part 2


# part2(input2)