defmodule Day3 do
  @input 'input.txt'

  def run1 do
    readFile
    |> parse(%{{0,0} => 0}, {0,0}) #start at 0,0. Using a map becuase multiple of the same key is forbidden.

  end
  def run2 do
    path1 =
    readFile
    |> Enum.take_every(2)
    |> parse(%{{0,0} => 0}, {0,0}) #returns real santa path

    path2 =
    readFile
    |> Enum.drop(1)
    |> Enum.take_every(2)
    |> parse(%{{0,0} => 0}, {0,0}) #returns real robo-santa path

    Map.merge(path1,path2)
    |> Enum.count
  end

  defp readFile do
    File.read!(@input)
    |> String.trim
    |> String.graphemes
  end

  #The Logic
  defp parse([], visitedLocations, _) do
    #part1 answer
    #Enum.count(visitedLocations)

    #part2 answer
    visitedLocations
  end

  defp parse([">" | tail], visLocs, curLoc) do
    newLoc = put_elem(curLoc, 0, elem(curLoc,0) + 1)
    parse(tail, Map.put_new(visLocs, newLoc, 0), newLoc)
  end

  defp parse(["<" | tail], visLocs, curLoc) do
    newLoc = put_elem(curLoc, 0, elem(curLoc,0) - 1)
    parse(tail, Map.put_new(visLocs, newLoc, 0), newLoc)
  end

  defp parse(["^" | tail], visLocs, curLoc) do
    newLoc = put_elem(curLoc, 1, elem(curLoc,1) + 1)
    parse(tail, Map.put_new(visLocs, newLoc, 0), newLoc)
  end

  defp parse(["v" | tail], visLocs, curLoc) do
    newLoc = put_elem(curLoc, 1, elem(curLoc,1) - 1)
    parse(tail, Map.put_new(visLocs, newLoc, 0), newLoc)
  end
end
