defmodule TTT.Validation do
  alias TTT.Positions
  alias TTT.Players
  alias TTT.Board
  alias TTT.Turns

  def valid_move({position, player} = move) do
    cond do
      MapSet.member?(Positions.all(), position) && MapSet.member?(Players.both(), player) ->
        {:ok, move}

      !MapSet.member?(Positions.all(), position) ->
        {:error, "Invalid position"}

      true ->
        {:error, "Invalid player"}
    end
  end

  def position_open(pid \\ Board, position) do
    cond do
      !Board.occupied?(pid, position) -> {:ok, position}
      true -> {:error, "Position #{Atom.to_string(position)} occupied."}
    end
  end

  def players_turn(pid \\ Turns, player) do
    cond do
      Turns.current(pid) == player -> {:ok, player}
      true -> {:error, "Player #{Atom.to_string(player)} is not the current player."}
    end
  end

  @win_states Enum.map(
                [
                  [:ul, :um, :ur],
                  [:ml, :mm, :mr],
                  [:ll, :lm, :lr],
                  [:ul, :ml, :ll],
                  [:um, :mm, :lm],
                  [:ur, :mr, :lr],
                  [:ul, :mm, :lr],
                  [:ur, :mm, :ll]
                ],
                fn win -> MapSet.new(win) end
              )
              |> MapSet.new()

  def player_won?(pid \\ Board, player) do
    player_positions = Board.get_all_by_player(pid, player) |> MapSet.new()

    Enum.any?(@win_states, fn win_state ->
      MapSet.intersection(win_state, player_positions) |> MapSet.size() == 3
    end)
  end

  def board_full?(pid \\ Board) do
    Board.get_all_occupied(pid)
    |> Enum.count() == 9
  end

  def game_over?(pid \\ Board, player) do
    player_won?(pid, player) || board_full?(pid)
  end
end
