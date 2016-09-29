defmodule Day4 do
	@inputstring "bgvyzdsv"
	@prefix "000000"

	def run do
		findNum(0)
	end

	defp findNum(seed) do
		makeKey(@inputstring,seed)
		|> convert
		|> check(seed)
	end

	defp makeKey(input, seed) do
		input <> to_string(seed)
	end

	defp convert(key) do
		:crypto.hash(:md5, key)
		|> Base.encode16
	end

	defp check(hash, seed) do
		case String.starts_with?(hash,@prefix) do
			true -> seed
			false -> findNum(seed+1)
		end
	end
end