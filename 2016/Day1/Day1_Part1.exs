defmodule Day1 do
    @input 'input.txt'
    
    # ---Part1---
    
    def run do
        readFile
        |> parseInstructions({:north,[0,0]})
    end
    
    defp parseInstructions([],{_, [x,y]}) do
        abs(x + y)
    end
    
    defp parseInstructions([hd|tail], {currentDirection, destination}) do
        dest = String.split_at(hd,1)                        # Split turn and distance
                |> step({currentDirection,destination})     # Update dest with new destination after the instruction
        parseInstructions(tail,dest)
    end
    
    defp step({turn,distance}, {currentDirection, destination}) do
        dist = String.to_integer(distance)
        navigate(currentDirection, turn)
        |> move(dist, destination)
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
    def move(:north, distance, [x,y]) do
        dest = [x, y + distance]
        
        {:north, dest}
    end
    
    def move(:south, distance, [x,y]) do
        dest = [x, y - distance]   
        {:south, dest}
    end
    
    def move(:east, distance, [x,y]) do
        dest = [x + distance, y]   
        {:east, dest}
    end
    
    def move(:west, distance, [x,y]) do
        dest = [x - distance, y]   
        {:west, dest}
    end
end