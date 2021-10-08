defmodule RushHour.Repo.Migrations.AddPlayerStatTable do
  use Ecto.Migration

  def change do
    create table("player_stats") do
      add :name, :string
      add :team, :string
      add :pos, :string
      add :att, :integer
      add :att_g, :float
      add :yds, :integer
      add :avg, :float
      add :yds_g, :float
      add :td, :integer
      add :lng, :integer
      add :first, :integer
      add :first_pct, :float
      add :twenty_plus, :integer
      add :forty_plus, :integer
      add :fum, :integer
    end
  end
end
