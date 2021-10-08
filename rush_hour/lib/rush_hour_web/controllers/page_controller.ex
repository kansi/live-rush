defmodule RushHourWeb.PageController do
  use RushHourWeb, :controller

  def index(conn, params) do
    {:ok, player_filter, sort_by, page} = RushHourWeb.Utils.parse_params(params)

    args = [
      query: %{player_filter: player_filter, sort_by: sort_by},
      player_stats: RushHour.PlayerStats.get_page(player_filter, sort_by, page)
    ]

    render(conn, "index.html", args)
  end
end
