# Tic Tac Toe

The game can be played in an `iex` session:

```
iex -S mix
```

Moves are played using the `TTT.place/1` function:
```
19:03:01.180 [info]  Player o begins.
Interactive Elixir (1.6.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> import TTT
TTT
iex(2)> place(:mm)

19:03:09.113 [info]  The current state of the board is: %{ll: :empty, lm: :empty, lr: :empty, ml: :empty, mm: :o, mr: :empty, ul: :empty, um: :empty, ur: :empty}

19:03:09.113 [info]  Player x's turn.
{:ok, {:mm, :o}}
```
Valid positions are defined according to the first letter of upper, middle, and lower followed by the first letter of left, middle and right as atoms.

```
[:ul, :um, :ur, 
:ml, :mm, :mr, 
:ll, :lm, :lr]
```
