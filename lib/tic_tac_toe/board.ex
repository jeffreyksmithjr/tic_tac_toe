defmodule TTT.Board do
  use Agent
  require Logger

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    Agent.start_link(&empty_board/0, opts)
  end

  def empty_board() do
    Enum.map(TTT.Positions.all(), fn position -> {position, :empty} end)
    |> Map.new()
  end

  def place(pid \\ __MODULE__, {position, player} = _move) do
    Agent.update(pid, &Map.put(&1, position, player))
  end

  def get(pid \\ __MODULE__, position) do
    Agent.get(pid, &Map.get(&1, position, :empty))
  end

  def get_all(pid \\ __MODULE__) do
    Agent.get(pid, & &1)
  end

  def get_all_by_player(pid \\ __MODULE__, player) do
    get_all(pid)
    |> Enum.filter(fn {_position, pos_player} -> player == pos_player end)
    |> Enum.map(fn {position, _pos_player} -> position end)
  end

  def get_all_occupied(pid \\ __MODULE__) do
    get_all(pid)
    |> Enum.filter(fn {_position, pos_player} -> :empty != pos_player end)
    |> Enum.map(fn {position, _pos_player} -> position end)
  end

  def occupied?(pid \\ __MODULE__, position) do
    get(pid, position) != :empty
  end

  def clear(pid \\ __MODULE__) do
    Logger.info("Clearing the board")
    Agent.update(pid, fn _ -> empty_board() end)
  end
end
