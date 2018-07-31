defmodule TTT.ValidationTest do
  use ExUnit.Case
  alias TTT.Validation
  alias TTT.Board
  alias TTT.Turns
  alias TTT.Positions

  setup do
    Board.clear()
  end

  test "validates moves" do
    position = :mm
    player = :x
    move = {position, player}
    result = Validation.valid_move(move)
    assert result == {:ok, move}
  end

  test "rejects invalid positions" do
    position = :nonsense
    player = :x
    move = {position, player}
    {result_status, _} = Validation.valid_move(move)
    assert result_status == :error
  end

  test "rejects invalid players" do
    position = :mm
    player = :nonsense
    move = {position, player}
    {result_status, _} = Validation.valid_move(move)
    assert result_status == :error
  end

  test "validates open positions" do
    position = :lr
    result = Validation.position_open(position)
    assert result == {:ok, position}
  end

  test "rejects occupied positions" do
    position = :lr
    player = :o
    move = {position, player}
    Board.place(move)
    {result_status, _} = Validation.position_open(position)
    assert result_status == :error
  end

  test "validates player's turn" do
    current_player = Turns.current()
    result = Validation.players_turn(current_player)
    assert result == {:ok, current_player}
  end

  test "rejects player's out of turn" do
    first_player = Turns.current()
    Turns.next()
    {result_status, _} = Validation.players_turn(first_player)
    assert result_status == :error
  end

  test "validates game has not been won" do
    player = :x
    result = Validation.player_won?(player)
    assert !result
  end

  test "determines that game has been won" do
    player = :x
    Board.place({:ur, player})
    Board.place({:mr, player})
    Board.place({:lr, player})
    result = Validation.player_won?(player)
    assert result
  end

  test "validates that the board is not yet full" do
    result = Validation.board_full?()
    assert !result
  end

  test "determines that the board is full" do
    all_positions = Positions.all()
    player = :o

    Enum.each(all_positions, fn position ->
      Board.place({position, player})
    end)

    result = Validation.board_full?()
    assert result
  end

  test "validates that the game is not yet over" do
    player = :x
    result = Validation.game_over?(player)
    assert !result
  end

  test "determines that the game is over" do
    player = :x
    Board.place({:ur, player})
    Board.place({:mr, player})
    Board.place({:lr, player})
    result = Validation.game_over?(player)
    assert result
  end
end
