defmodule TTT.Positions do
  @all MapSet.new([:ul, :um, :ur, :ml, :mm, :mr, :ll, :lm, :lr])
  def all, do: @all
end
