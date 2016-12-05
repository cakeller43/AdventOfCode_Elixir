defmodule Day1Test do
  use ExUnit.Case
  use ExCheck
  import Day1

  @directions [:north,:south,:east,:west]

  property :move_y_positively_equal_to_distance_north do
    for_all [distance,x,y] in [int,int,int] do
      {_, [_,resY]} = Day1.move(:north,distance,[x,y])
      resY == distance + y
    end
  end

  property :move_y_negatively_equal_to_distance_south do
    for_all [distance,x,y] in such_that([distance,x,y] in [int,int,int] when distance >= 0) do
      {_, [_,resY]} = Day1.move(:south,distance,[x,y])
      resY == y - distance
    end
  end

  property :navigate_returns_a_direction do
    for_all turn in unicode_string do
    	implies turn == "R" or turn == "L" do
    		result = Day1.navigate(:south,turn)
      	Enum.member?(@directions, result)
    	end      
    end
  end

end
