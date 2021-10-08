defmodule RushHour.Factory do
  use ExMachina.Ecto, repo: RushHour.Repo
  alias RushHour.PlayerStats.PlayerStat

  def stat_factory do
    %PlayerStat{
      name: sequence(:name, &"player name #{&1}"),
      team: sequence(:team, &"TD#{&1}"),
      pos: sequence(:pos, ["RB", "CB", "AT"]),
      att: random_int(),
      att_g: random_float(),
      yds: random_int(),
      avg: random_float(),
      yds_g: random_float(),
      td: random_int(),
      lng: sequence(:team, &"#{&1}"),
      first: random_int(),
      first_pct: random_float(),
      twenty_plus: random_int(),
      forty_plus: random_int(),
      fum: random_int()
    }
  end

  defp random_int(), do: :rand.uniform(100)

  defp random_float(), do: :rand.uniform() * 10
end
