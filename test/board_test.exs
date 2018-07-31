defmodule TTT.BoardTest do
  use ExUnit.Case
  alias TTT.Board

  setup_all do
    Board.clear()
  end

  test "can retrieve placed moves" do
    position = :ul
    player = :x
    move = {position, player}
    Board.place(move)
    result = Board.get(position)
    assert result == player
  end

  test "can start a new game" do
    position = :mm
    player = :o
    move = {position, player}
    Board.place(move)
    Board.clear()
    result = Board.get(position)
    assert result == :empty
  end
end
