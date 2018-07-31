defmodule TTT.TurnsTest do
  use ExUnit.Case
  alias TTT.Turns

  test "can change turns" do
    first = Turns.current()
    Turns.next()
    second = Turns.current()
    assert first != second
  end
end
