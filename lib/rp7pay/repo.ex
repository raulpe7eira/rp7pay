defmodule Rp7pay.Repo do
  use Ecto.Repo,
    otp_app: :rp7pay,
    adapter: Ecto.Adapters.Postgres
end
