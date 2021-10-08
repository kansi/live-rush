defmodule RushHourWeb.PageView do
  use RushHourWeb, :view
  @route "/"

  def encode_query(query, :sort_by_yds) do
    encode_query(%{query | sort_by: "yds"})
  end

  def encode_query(query, :sort_by_td) do
    encode_query(%{query | sort_by: "td"})
  end

  def encode_query(query, :sort_by_lng) do
    encode_query(%{query | sort_by: "lng"})
  end

  def encode_query(query) do
    # Remove empty filters
    query = Enum.filter(query, fn {_key, val} -> val != "" end) |> Enum.into(%{})
    encoded_query = URI.encode_query(query)

    if encoded_query != "" do
      @route <> "?#{encoded_query}"
    else
      @route
    end
  end

  def previous_page(query, current_page) when current_page > 1 do
    encode_query(Map.put(query, :page, current_page - 1))
  end

  def previous_page(query, current_page),
    do: Map.put(query, :page, current_page) |> encode_query()

  def next_page(query, current_page) do
    encode_query(Map.put(query, :page, current_page + 1))
  end

  def encode_query_wo_sort_by(query), do: encode_query(%{query | sort_by: ""})

  def is_sorted_by(sort_by, :yds), do: sort_by == "yds"
  def is_sorted_by(sort_by, :td), do: sort_by == "td"
  def is_sorted_by(sort_by, :lng), do: sort_by == "lng"

  def is_filtered?(%{player_filter: "", sort_by: ""}), do: false
  def is_filtered?(_), do: true
end
