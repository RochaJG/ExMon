defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game stata updated" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns player from game state" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
      assert expected_response.player == Game.player()
    end
  end

  describe "turn/0" do
    test "returns actual turn" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
      assert expected_response.turn == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns player status from actual game state" do
      player = Player.build("Jordan", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :soco, move_rnd: :cura},
          name: "Jordan"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
      assert expected_response.player == Game.fetch_player(:player)
    end
  end
end
