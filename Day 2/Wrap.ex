defmodule Wrap do
    @input 'input.txt'

    defp splitDim dim do
        String.strip(dim)
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)
    end

    #part1
    def calc() do
        partOneCalc(File.stream!(@input))
    end

    def partOneCalc input do
        input
        |> Enum.map(&splitDim/1)
        |> work 0
    end

    defp work([], total) do
        total
    end

    defp work([head | tail], total) do
        work(tail, total + calcSA(head))
    end

    defp calcSA(dim) do
        lw = Enum.at(dim, 0) * Enum.at(dim, 1)
        lh = Enum.at(dim, 0) * Enum.at(dim, 2)
        hw = Enum.at(dim, 1) * Enum.at(dim, 2)
        res = (2*lw) + (2*lh) + (2*hw)
        cond do
            lw <= lh and lw <= hw -> res + lw
            lh <= lw and lh <= hw -> res + lh
            hw <= lh and hw <= lw -> res + hw
        end
    end

    #part2
    def calc2() do
        partTwoCalc(File.stream!(@input))
    end

    defp partTwoCalc input do
        input
        |> Enum.map(&splitDim/1)
        |> work2 0
    end

    defp work2([], total) do
        total
    end

    defp work2([head | tail], total) do
        work2(tail, total + calcRibbon(head))
    end

    defp calcRibbon(dim) do
        l = Enum.at(dim, 0)
        w = Enum.at(dim, 1)
        h = Enum.at(dim, 2)
        cond do
            l >= h and l >= w -> (2*h) + (2*w) + (l*w*h)
            h >= l and h >= w -> (2*l) + (2*w) + (l*w*h)
            w >= l and w >= h -> (2*h) + (2*l) + (l*w*h)
        end
    end
end