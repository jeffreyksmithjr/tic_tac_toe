defmodule TTT.Positions do
  def all() do
    MapSet.new([:ul, :um, :ur, :ml, :mm, :mr, :ll, :lm, :lr])
  end
end
