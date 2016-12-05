defmodule Day1 do
    @input 'input.txt'
    
    # ---Part2---
    
    def run2 do
        readFile
        |> parseInstructions({:north,[0,0]}, [0,0])
    end
    
    defp parseInstructions([], {_, [x,y]}, _) do
        abs(x + y)
    end
    
    defp parseInstructions([hd|tail], {currentDirection, destination}, visitedLocs) do
        {dir, dest, locs, done} = String.split_at(hd,1)                  # Split turn and distance
                |> step({currentDirection,destination}, visitedLocs)     # Update dest with new destination after the instruction
                
        if done do
            tail = []   # Seems like a bad way to exit recursion
        end
        
        parseInstructions(tail, {dir, dest}, locs)
    end
    
    defp step({turn,distance}, {currentDirection, destination}, visitedLocs) do
        dist = String.to_integer(distance)
        navigate(currentDirection, turn)
        |> move(dist, destination, visitedLocs)
    end
    
    # ---Helpers---
    
    defp readFile do
        File.read!(@input)
        |> String.split(",")
        |> Enum.map(&String.trim/1)
    end
    
    # Navigate
    def navigate(:north, turn) do
        case turn do
            "R" -> :east
            "L" -> :west
        end
    end
    
    def navigate(:south, turn) do
        case turn do
            "R" -> :west
            "L" -> :east
        end
    end
    
    def navigate(:east, turn) do
        case turn do
            "R" -> :south
            "L" -> :north
        end
    end
    
    def navigate(:west, turn) do
        case turn do
            "R" -> :north
            "L" -> :south
        end
    end
    
    # Move
    def move(direction, 0, dest, visitedLocs), do: {direction,dest,visitedLocs,false}
    def move(direction, -1, dest, visitedLocs), do: {direction,dest,visitedLocs,true}
    
    def move(:north, distance, [x,y], visitedLocs) do
        dest = [x, y + 1]
        if Enum.member?(visitedLocs, dest), do: distance = 0    # Seems like a bad way to exit recursion
        move(:north, distance - 1, dest, [dest | visitedLocs])
    end
    
    def move(:south, distance, [x,y], visitedLocs) do
        dest = [x, y - 1]
        if Enum.member?(visitedLocs, dest), do: distance = 0    # Seems like a bad way to exit recursion
        move(:south, distance - 1, dest, [dest | visitedLocs])
    end
    
    def move(:east, distance, [x,y], visitedLocs) do
        dest = [x + 1, y]
        if Enum.member?(visitedLocs, dest), do: distance = 0    # Seems like a bad way to exit recursion
        move(:east, distance - 1, dest, [dest | visitedLocs])
    end
    
    def move(:west, distance, [x,y], visitedLocs) do
        dest = [x - 1, y]
        if Enum.member?(visitedLocs, dest), do: distance = 0    # Seems like a bad way to exit recursion
        move(:west, distance - 1, dest, [dest | visitedLocs])
    end
    
end