defmodule Rp7payWeb.FallbackController do
  use Rp7payWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(Rp7payWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
