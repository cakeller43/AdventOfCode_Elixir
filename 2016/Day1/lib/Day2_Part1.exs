defmodule Day2 do
    @input 'input.txt'
    @startingNumber 5

    def run do
        readFile
        |> Enum.reduce({@startingNumber, ""}, &parse/2)
    end

    defp readFile do
        File.read!(@input)
        |> String.split("\n")
        |> Enum.map(&String.trim/1)
    end

    def parse(line, {currentNumber, ans}) do
        currentNumber = String.graphemes(line)
                        |> Enum.reduce(currentNumber, &move/2)
        {currentNumber, ans <> Integer.to_string(currentNumber)}
    end

    # Move
    def move("U", currentNumber) do
        cond do
            currentNumber <= 3 -> currentNumber
            currentNumber > 3 -> currentNumber - 3
        end
    end

    def move("D", currentNumber) do
        cond do
            currentNumber >= 7 -> currentNumber
            currentNumber < 7 -> currentNumber + 3
        end
    end

    def move("L", currentNumber) do
        case currentNumber do
            1 -> currentNumber
            4 -> currentNumber
            7 -> currentNumber
            _ -> currentNumber - 1
        end
    end

    def move("R", currentNumber) do
        case currentNumber do
            3 -> currentNumber
            6 -> currentNumber
            9 -> currentNumber
            _ -> currentNumber + 1
        end
    end
end