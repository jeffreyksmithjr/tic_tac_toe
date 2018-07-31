defmodule TTT.Orchestration do
  alias TTT.Board
  alias TTT.Turns
  alias TTT.Validation
  require Logger

  def play_turn(board_pid \\ Board, turns_pid \\ Turns, {position, player} = move) do
    with {:ok, _move} <- Validation.valid_move(move),
         {:ok, _position} <- Validation.position_open(board_pid, position),
         {:ok, _player} <- Validation.players_turn(turns_pid, player) do
      execute(board_pid, turns_pid, move)
    end
  end

  def execute(board_pid \\ Board, turns_pid \\ Turns, {position, player} = move) do
    Board.place(board_pid, move)

    if Validation.game_over?(board_pid, player) do
      cond do
        Validation.player_won?(player) ->
          Logger.info("Player #{Atom.to_string(player)} won.")

        true ->
          Logger.info("Game ends in a tie.")
      end

      Board.clear(board_pid)
      Logger.info("New game begins.")
    end

    Turns.next(turns_pid)
    {:ok, move}
  end
end
