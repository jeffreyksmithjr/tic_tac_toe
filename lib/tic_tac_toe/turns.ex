defmodule TTT.Turns do
  use Agent
  alias TTT.Players
  require Logger

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    first_player = Enum.random(Players.both())
    Logger.info("Player #{Atom.to_string(first_player)} begins.")
    Agent.start_link(fn -> first_player end, opts)
  end

  def next(pid \\ __MODULE__) do
    switch = fn current ->
      [next | _] = MapSet.difference(Players.both(), MapSet.new([current]))
      |> MapSet.to_list()
      Logger.info "Player #{Atom.to_string(next)}'s turn."
      next
    end

    Agent.update(pid, switch)
  end

  def current(pid \\ __MODULE__) do
    Agent.get(pid, & &1)
  end
end
