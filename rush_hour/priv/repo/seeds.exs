# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RushHour.Repo.insert!(%RushHour.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Sanitise do
  def maybe_int_to_string(v) when is_integer(v), do: Integer.to_string(v)
  def maybe_int_to_string(v), do: v

  def maybe_string_to_int(v) when is_binary(v) do
    {v_int, _} = Integer.parse(v)
    v_int
  end

  def maybe_string_to_int(v), do: v
end

data = File.read!("../rushing.json")
{:ok, player_stats} = Jason.decode(data)

Enum.map(player_stats, fn stat ->
  %{"Lng" => lng, "Yds" => yds} = stat

  stat = %{
    stat
    | "Yds" => Sanitise.maybe_string_to_int(yds),
      "Lng" => Sanitise.maybe_int_to_string(lng)
  }

  RushHour.Repo.insert!(RushHour.PlayerStats.new_changeset(stat))
end)
