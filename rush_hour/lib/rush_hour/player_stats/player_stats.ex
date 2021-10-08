defmodule RushHour.PlayerStats do
  alias __MODULE__.PlayerStat
  require Ecto.Query
  require Ecto.Query.API
  import Ecto.Query

  def new_changeset(args), do: PlayerStat.changeset(args)

  def get_all(player_filter, sort_by) do
    from(s in PlayerStat)
    |> filter_by(player_filter)
    |> sort_by(sort_by)
    |> RushHour.Repo.all()
  end

  def get_page(player_filter, sort_by, page) do
    from(s in PlayerStat)
    |> filter_by(player_filter)
    |> sort_by(sort_by)
    |> RushHour.Repo.paginate(page: page, page_size: 50)
  end

  defp filter_by(query, player_name) when is_binary(player_name) and player_name != "" do
    match_by = "%#{player_name}%"
    where(query, [s], ilike(s.name, ^match_by))
  end

  defp filter_by(query, _), do: query

  defp sort_by(query, "yds"), do: Ecto.Query.order_by(query, desc: :yds)
  defp sort_by(query, "td"), do: Ecto.Query.order_by(query, desc: :td)
  defp sort_by(query, "lng"), do: Ecto.Query.order_by(query, desc: :lng)
  defp sort_by(query, _), do: query
end
