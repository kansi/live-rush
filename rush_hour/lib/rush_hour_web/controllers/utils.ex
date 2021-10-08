defmodule RushHourWeb.Utils do
  def parse_params(params) do
    player_filter = params["player_filter"] || ""
    sort_by = params["sort_by"] || ""
    page = parse_page(params)

    {:ok, player_filter, sort_by, page}
  end

  defp parse_page(params) do
    case Integer.parse(params["page"] || "1") do
      :error -> 1
      {page, _} -> page
    end
  end
end
