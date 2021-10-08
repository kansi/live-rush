defmodule RushHourWeb.ExportController do
  use RushHourWeb, :controller

  def index(conn, params) do
    {:ok, player_filter, sort_by, _page} = RushHourWeb.Utils.parse_params(params)

    stats_csv = RushHour.PlayerStats.get_all(player_filter, sort_by) |> to_csv

    send_download(
      conn,
      {:binary, stats_csv},
      content_type: "application/csv",
      filename: "player_stats.csv"
    )
  end

  defp to_csv(stats) do
    header = [
      "Name",
      "Pos",
      "Team",
      "Att",
      "Att_g",
      "Avg",
      "First",
      "First_pct",
      "Forty_plus",
      "Fum",
      "Lng",
      "Td",
      "Twenty_plus",
      "Yds",
      "Yds_g"
    ]

    data =
      Enum.map(stats, fn stat ->
        [
          stat.name,
          stat.pos,
          stat.team,
          stat.att,
          stat.att_g,
          stat.avg,
          stat.first,
          stat.first_pct,
          stat.forty_plus,
          stat.fum,
          stat.lng,
          stat.td,
          stat.twenty_plus,
          stat.yds,
          stat.yds_g
        ]
      end)

    CSV.encode([header | data])
    |> Enum.to_list()
  end
end
