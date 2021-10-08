defmodule RushHourWeb.ExportControllerTest do
  use RushHourWeb.ConnCase
  import RushHour.Factory

  describe "GET /export" do
    test "returns csv with all stats", %{conn: conn} do
      insert_list(3, :stat)

      conn = get(conn, "/export")
      assert response_content_type(conn, :csv) =~ "application/csv"
      csv = csv_response(conn)
      csv_data = parse_csv_response(csv)

      assert length(csv_data) == 4
    end

    test "returns csv with filtered stats by player name", %{conn: conn} do
      insert_list(3, :stat)
      insert(:stat, name: "special player")

      conn = get(conn, "/export", %{player_filter: "special"})
      csv = csv_response(conn)
      assert csv =~ "special player"
      assert length(parse_csv_response(csv)) == 2
    end

    test "returns csv with sorted stats by td,yds,lng", %{conn: conn} do
      insert_list(3, :stat)
      insert(:stat, name: "special player", td: 1000, yds: 1000, lng: 1000)

      Enum.map(["td", "yds", "lng"], fn sort_by ->
        conn = get(conn, "/export", %{sort_by: sort_by})
        csv = csv_response(conn)
        [_header, row1 | _] = csv_data = parse_csv_response(csv)
        assert length(csv_data) == 5
        assert {:ok, ["special player" | _]} = row1
      end)
    end
  end

  defp csv_response(conn) do
    assert response_content_type(conn, :csv) =~ "application/csv"
    response(conn, 200)
  end

  defp parse_csv_response(csv) do
    {:ok, csv_stream} = StringIO.open(csv)
    csv_stream |> IO.binstream(:line) |> CSV.decode() |> Enum.to_list()
  end
end
