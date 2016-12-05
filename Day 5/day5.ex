defmodule Day5 do

	@input 'input.txt'
	@bad_strings ["ab", "cd", "pq", "xy"]

	def run1 do
    readFile
    |> Enum.map(&Task.async(fn -> judge(&1) end))
    |> Enum.map(&Task.await(&1))
  end

  defp readFile do
    File.read!(@input)
    |> String.split("\n")
    |> Enum.map(fn x -> String.trim(x) end)
  end

  def judge(s) do
  	line = {s,true} # {string, isNice}
  	line
  	|> three_vowels()
  	|> twice_in_a_row()
  	|> no_bad_strings()
  	|> isNice()
  end

  def isNice({s,isNice}) do
  	cond do
  		isNice == false -> 0
  		isNice == true -> 1
  	end
  end

  def _ ({s,false}) do
  	{s,false}
  end

  def three_vowels({s, true}) do
  	numVowels = s
					  	|> String.graphemes
					  	|> Enum.map(&isVowel(&1))
					  	|> Enum.sum
		cond do
			numVowels >= 3 -> {s, true}
			true -> {s, false}
		end
  end

  defp isVowel(c) do
  	cond do
  		c == "a" -> 1
  		c == "e" -> 1
  		c == "i" -> 1
  		c == "o" -> 1
  		c == "u" -> 1
  		true -> 0
  	end
  end

  def twice_in_a_row({s,false}), do: {s,false}
  def twice_in_a_row({s, true}) do
  	res = s
  	|> String.graphemes
  	|> parse_twice_in_a_row(false,"")
  	{s,res}
  end

  defp parse_twice_in_a_row([], false, _), do: false
	defp parse_twice_in_a_row(_, true, _), do: true

  defp parse_twice_in_a_row([head | tail], containsDup, prevChar) do
  	match = head == prevChar
  	parse_twice_in_a_row(tail, match, head)
  end

	def no_bad_strings({s,false}), do: {s,false}
  def no_bad_strings({s, true}) do
  	res = @bad_strings
  				|> Enum.map(&contains_bad_string?(&1,s))
    case Enum.member?(res,true) do
    	false -> {s,false}
    	true -> {s,true}
    end
  end

  def contains_bad_string?(x, s), do: String.contains?(s,x)

end