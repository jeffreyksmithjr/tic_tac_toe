defmodule TTT.OrchestrationTest do
  use ExUnit.Case
  alias TTT.Board
  import TTT.Orchestration, only: [play_turn: 3]
  alias TTT.Turns

  test "plays valid moves without error" do
    {:ok, board} = Board.start_link(name: :orchestration_board)
    {:ok, turns} = Turns.start_link(name: :orchestration_turns)

    if Turns.current(turns) != :x do
      Turns.next(turns)
    end

    {first_result, _} = play_turn(board, turns, {:ul, :x})
    {second_result, _} = play_turn(board, turns, {:um, :o})
    {third_result, _} = play_turn(board, turns, {:ur, :x})
    results = [first_result, second_result, third_result]
    assert Enum.all?(results, &(&1 == :ok))
  end
end
