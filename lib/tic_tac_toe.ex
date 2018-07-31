defmodule TTT do
  alias TTT.Board
  alias TTT.Turns
  alias TTT.Orchestration

  def place(board_pid \\ Board, turns_pid \\ Turns, position) do
    current_player = Turns.current(turns_pid)
    move = {position, current_player}
    Orchestration.play_turn(board_pid, turns_pid, move)
  end
end
