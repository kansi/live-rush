defmodule RushHour.Repo do
  use Ecto.Repo,
    otp_app: :rush_hour,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 100
end
