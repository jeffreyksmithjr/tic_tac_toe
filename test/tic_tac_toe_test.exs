defmodule TTTTest do
  use ExUnit.Case
  import TTT, only: [place: 3]
  alias TTT.Board
  alias TTT.Turns

  setup do
    Board.clear()
  end

  test "plays a game to completion" do
    {:ok, board} = Board.start_link(name: :ttt_board)
    {:ok, turns} = Turns.start_link(name: :ttt_turns)
    place(board, turns, :ul)
    place(board, turns, :ur)
    place(board, turns, :ml)
    place(board, turns, :mr)
    place(board, turns, :ll)
    result = Board.get_all_occupied(board)
    assert Enum.count(result) == 0
  end
end
