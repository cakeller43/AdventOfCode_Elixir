defmodule Day4 do
	@inputstring "abcdef"

	def run do
		findSeed(0)
	end

	defp findSeed(seed) do
		makeKey(@inputstring,seed)
		|> convert
		|> check(seed)
	end

	defp makeKey(input, seed) do
		input <> to_string(seed)
	end

	defp convert(key) do
		Base.encode16(key)
	end

	defp check(hash, seed) do
		case String.starts_with?(hash,"00000") do
			true -> seed
			false -> findSeed(seed+1)
		end
	end
end