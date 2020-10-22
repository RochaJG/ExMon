defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message() do
    IO.puts("\n======== The game is started! ========")
    IO.inspect(Game.info())
    IO.puts("---------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n======== Invalide move: #{move}. ========\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n======== Player attacked computer, dealing #{damage} damage. ========\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n======== Computer attacked player, dealing #{damage} damage. ========\n")
  end
end
