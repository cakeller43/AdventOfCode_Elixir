defmodule Day9.Server do
	use GenServer

	#Client
	def start_link(default) do
		GenServer.start_link(__MODULE__, default)
	end

	def prepend_string(pid, string) do
		GenServer.call(pid, {:prepend_string, string})
	end

	def take_next(pid) do
		GenServer.call(pid, :take_next)
	end

	def take_n(pid, numChars) do
		GenServer.call(pid, {:take_n, numChars})
	end

	def get_count(pid) do
		GenServer.call(pid, :get_count)
	end

	def increment_count(pid) do
		GenServer.call(pid, :increment_count)
	end

	def increment_count_n(pid, n) do
		GenServer.call(pid, {:increment_count_n, n})
	end
	#Server

	def handle_call(:take_next, _from, {count, stream}) do
		char = Enum.take(stream, 1)
		stream = Enum.drop(stream, 1)
    {:reply, char, {count, stream}}
  end

	def handle_call({:take_n, numChars}, _from, {count, stream}) do
		res = Enum.take(stream, numChars)
		stream = Enum.drop(stream, numChars)
    {:reply, res, {count, stream}}
  end

  def handle_call(:increment_count, _from, {count, stream}) do
    {:reply, :ok, {count + 1, stream}}
  end

  def handle_call({:increment_count_n, n}, _from, {count, stream}) do
    {:reply, :ok, {count + n, stream}}
  end

  def handle_call(:get_count, _from, {count, stream}) do
    {:reply, count, {count, stream}}
  end

  def handle_call({:prepend_string, string}, _from, {count, stream}) do
    {:reply, :ok, {count, string ++ stream}}
  end
end


defmodule Day9 do
	import Day9.Server
	alias Day9.Server

	@input 'input.txt'

 	def run do
    readFile
    |> parseStart
  end

  defp readFile do
  	File.read!(@input)
    |> String.graphemes
  end

  def parseStart(stream) do
  	{:ok, pid} = start_link({0, stream})
  	parse(pid, Server.take_next(pid))
  end

  # parse
  def parse(pid, []) do
  	Server.get_count(pid)
  end

	def parse(pid, ["("]) do
  	{numChars, repeat} = parseMarker(pid)
  	string = Server.take_n(pid, numChars)
  	prepend(pid, string, repeat)
  	Server.take_n(pid, numChars * repeat)							
  	Server.increment_count_n(pid, numChars * repeat)		
  	parse(pid, Server.take_next(pid))
  end

  def parse(pid, char) do
  	Server.increment_count(pid)
  	parse(pid, Server.take_next(pid))
  end

  # parseMarker
  def parseMarker(pid) do
  	parseMarker(pid, Server.take_next(pid), "")
  end

	def parseMarker(pid, [")"], marker) do
  	[numChars, repeat] = String.split(marker, "x")
  												|> Enum.map(&String.to_integer/1)
  	{numChars, repeat}
  end

  def parseMarker(pid, next, marker) do
  	parseMarker(pid, Server.take_next(pid), marker <> Enum.at(next,0))
  end

  # prepend
  def prepend(pid, string, 0) do
  	{:ok}
  end

  def prepend(pid, string, repeat) do
  	Server.prepend_string(pid, string)
  	prepend(pid,string, repeat - 1)
  end
end



