defmodule TTT.Board do
  use Agent

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    Agent.start_link(&empty_board/0, opts)
  end

  def empty_board() do
    Enum.map(TTT.Positions.all(), fn position -> {position, :empty} end)
    |> Map.new()
  end

  def place(pid \\ __MODULE__, {position, character} = move) do
    Agent.update(pid, &Map.put(&1, position, character))
  end

  def get(pid \\ __MODULE__, position) do
    Agent.get(pid, &Map.get(&1, position, :empty))
  end

  def get_all(pid \\ __MODULE__) do
    Agent.get(pid, & &1)
  end

  def clear(pid \\ __MODULE__) do
    Agent.update(pid, fn _ -> empty_board() end)
  end
end
