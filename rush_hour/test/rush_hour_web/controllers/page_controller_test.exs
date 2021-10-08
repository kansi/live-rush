defmodule RushHourWeb.PageControllerTest do
  use RushHourWeb.ConnCase
  import RushHour.Factory

  describe "GET /" do
    test "returns stats", %{conn: conn} do
      insert_list(3, :stat)

      conn = get(conn, "/")
      {:ok, page} = page_response(conn, 200)

      rows = get_element(page, "tbody[data-id='stats-data'] tr")
      assert length(rows) == 3
    end

    test "Shows 'Next Page' button when more than 50 entried exist", %{conn: conn} do
      insert_list(51, :stat)

      conn = get(conn, "/", %{sort_by: "yds", player_filter: "player"})
      {:ok, page} = page_response(conn, 200)

      assert ["/?page=2&player_filter=player&sort_by=yds"] ==
               get_element_attribute(page, "a[data-id='next-page']", "href")
    end

    test "Shows 'Previous Page' button when more than 50 entries exist", %{conn: conn} do
      insert_list(51, :stat)

      conn = get(conn, "/", %{page: 2})
      {:ok, page} = page_response(conn, 200)

      assert ["/?page=1"] == get_element_attribute(page, "a[data-id='previous-page']", "href")
    end

    test "Return data filtered by player name", %{conn: conn} do
      insert_list(10, :stat)
      insert(:stat, name: "special player")

      conn = get(conn, "/", %{player_filter: "special player"})
      {:ok, page} = page_response(conn, 200)

      rows = get_element(page, "tbody[data-id='stats-data'] tr")
      assert length(rows) == 1

      assert "special player" ==
               get_element_text(rows, "div[data-class='player-name']") |> String.trim()
    end

    test "Return data sorted by yds", %{conn: conn} do
      insert_list(10, :stat)
      insert(:stat, name: "special player", yds: 10000)

      conn = get(conn, "/", %{sort_by: "yds"})
      {:ok, page} = page_response(conn, 200)

      rows = get_element(page, "tbody[data-id='stats-data'] tr")
      assert length(rows) == 11

      # First row should have the player with highest yds
      assert "special player" ==
               get_element_text(hd(rows), "div[data-class='player-name']") |> String.trim()
    end

    test "Return data sorted by td", %{conn: conn} do
      insert_list(10, :stat)
      insert(:stat, name: "special player", td: 10000)

      conn = get(conn, "/", %{sort_by: "td"})
      {:ok, page} = page_response(conn, 200)

      rows = get_element(page, "tbody[data-id='stats-data'] tr")
      assert length(rows) == 11

      # First row should have the player with highest td
      assert "special player" ==
               get_element_text(hd(rows), "div[data-class='player-name']") |> String.trim()
    end

    test "Return data sorted by lng", %{conn: conn} do
      insert_list(10, :stat)
      insert(:stat, name: "special player", lng: 1000)

      conn = get(conn, "/", %{sort_by: "lng"})
      {:ok, page} = page_response(conn, 200)

      rows = get_element(page, "tbody[data-id='stats-data'] tr")
      assert length(rows) == 11

      # First row should have the player with highest lng
      assert "special player" ==
               get_element_text(hd(rows), "div[data-class='player-name']") |> String.trim()
    end

    test "Ensure 'Clear filter', 'Export CSV' and clear sort button exist", %{conn: conn} do
      insert_list(200, :stat)

      conn = get(conn, "/", %{sort_by: "lng", player_filter: "player", page: 2})
      {:ok, page} = page_response(conn, 200)

      assert ["/"] == get_element_attribute(page, "a[data-id='clear-filters']", "href")

      assert ["/export?player_filter=player&sort_by=lng"] ==
               get_element_attribute(page, "a[data-id='export-to-csv']", "href")

      assert ["/?player_filter=player"] ==
               get_element_attribute(page, "a[data-id='clear-lng-sort']", "href")
    end
  end

  defp get_element_text(page, selector) do
    Floki.text(get_element(page, selector))
  end

  defp get_element_attribute(page, selector, attribute) do
    Floki.attribute(page, selector, attribute)
  end

  defp get_element(page, selector) do
    Floki.find(page, selector)
  end

  defp page_response(conn, status) do
    page = html_response(conn, status)
    Floki.parse_document(page)
  end
end
