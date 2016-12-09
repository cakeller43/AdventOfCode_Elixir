defmodule Day3 do
    @input 'input.txt'

    def run do
        readFile
        |> Enum.reduce(0,fn(x, acc) -> sort(acc,x) end)
    end

    defp readFile do
        File.read!(@input)
        |> String.split("\n")
        |> Enum.map(&String.trim/1)
        |> Enum.map(fn(x) -> String.split(x) end)
    end

    def sort(acc, dims) do
        valid = Enum.map(dims, &String.to_integer/1)
                |> Enum.sort
                |> isValid
        cond do
            valid == true -> acc + 1
            valid == false -> acc
        end
    end

    def isValid(dims) do
        Enum.at(dims,0) + Enum.at(dims,1) > Enum.at(dims,2)
    end
end