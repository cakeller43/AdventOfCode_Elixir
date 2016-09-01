defmodule AdventOne do
    def findFloor(input), do: findFloor(input, 0)

    defp findFloor("", floor) do
        floor
    end

    defp findFloor("(" <> tail, floor) do
        findFloor(tail, floor + 1)
    end

    defp findFloor(")" <> tail, floor) do
        findFloor(tail, floor - 1)
    end
end