defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Jordan"
      }

      assert expected_response == ExMon.create_player("Jordan", :chute, :cura, :soco)
    end
  end

  describe "start_game/1" do
    test "when the game has started, returns a message" do
      player = Player.build("Jordan", :chute, :cura, :soco)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Jordan", :chute, :cura, :soco)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when move is valid, do the move and computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "Player attacked computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end
  end
end
