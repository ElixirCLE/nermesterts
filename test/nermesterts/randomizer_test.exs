defmodule GamePicker.RandomizerTest do
  use ExUnit.Case

  alias GamePicker.Randomizer

  test "randomizer chooses something from the list" do
    assert "a" == Randomizer.randomize(["a"])
  end

  test "randomizer chooses the same item for the same day" do
    for _ <- 1..100 do
      assert "a" == Randomizer.randomize(["a", "b", "c"], 2016, 10)
    end
  end

  test "randomizer can choose different items on different days" do
    list = ["a", "b", "c"]
    for _ <- 1..100 do
      assert Randomizer.randomize(list, 2017, 13) != Randomizer.randomize(list, 2017, 14)
    end
  end
end
