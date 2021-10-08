defmodule RushHour.PlayerStats.PlayerStat do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "player_stats" do
    field :name, :string
    field :team, :string
    field :pos, :string
    field :att, :integer
    field :att_g, :float
    field :yds, :integer
    field :avg, :float
    field :yds_g, :float
    field :td, :integer
    field :lng, :string
    field :first, :integer
    field :first_pct, :float
    field :twenty_plus, :integer
    field :forty_plus, :integer
    field :fum, :integer
  end

  def changeset(%{
        "1st" => first,
        "1st%" => first_pct,
        "20+" => twenty_plus,
        "40+" => forty_plus,
        "Att" => att,
        "Att/G" => att_g,
        "Avg" => avg,
        "FUM" => fum,
        "Lng" => lng,
        "Player" => name,
        "Pos" => pos,
        "TD" => td,
        "Team" => team,
        "Yds" => yds,
        "Yds/G" => yds_g
      }) do
    %__MODULE__{}
    |> Changeset.change()
    |> Changeset.put_change(:name, name)
    |> Changeset.put_change(:team, team)
    |> Changeset.put_change(:pos, pos)
    |> Changeset.put_change(:att, att)
    |> Changeset.put_change(:att_g, att_g * 1.0)
    |> Changeset.put_change(:yds, yds)
    |> Changeset.put_change(:avg, avg * 1.0)
    |> Changeset.put_change(:yds_g, yds_g * 1.0)
    |> Changeset.put_change(:td, td)
    |> Changeset.put_change(:lng, lng)
    |> Changeset.put_change(:first, first)
    |> Changeset.put_change(:first_pct, first_pct * 1.0)
    |> Changeset.put_change(:twenty_plus, twenty_plus)
    |> Changeset.put_change(:forty_plus, forty_plus)
    |> Changeset.put_change(:fum, fum)
  end
end
