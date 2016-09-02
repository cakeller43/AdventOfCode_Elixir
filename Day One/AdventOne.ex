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

defmodule AdventOnePartTwo do
    def findFloor(input), do: findFloor(input, 0, 0)

    defp findFloor("", floor, position) do
         position
    end

    defp findFloor(_, floor, position) when floor == -1 do
         position
    end

    defp findFloor("(" <> tail, floor, position) do
        findFloor(tail, floor + 1, position + 1)
    end

    defp findFloor(")" <> tail, floor, position) do
        findFloor(tail, floor - 1, position + 1)
    end
end