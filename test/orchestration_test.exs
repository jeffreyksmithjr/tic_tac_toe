defmodule TTT.OrchestrationTest do
  use ExUnit.Case
  alias TTT.Board
  import TTT.Orchestration, only: [play_turn: 1]
  alias TTT.Turns

  setup do
    Board.clear()

    if Turns.current() != :x do
      Turns.next()
    end
  end

  test "plays valid moves without error" do
    {first_result, _} = play_turn({:ul, :x})
    {second_result, _} = play_turn({:um, :o})
    {third_result, _} = play_turn({:ur, :x})
    results = [first_result, second_result, third_result]
    assert Enum.all?(results, &(&1 == :ok))
  end
end
