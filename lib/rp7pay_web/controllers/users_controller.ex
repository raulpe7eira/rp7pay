defmodule Rp7payWeb.UsersController do
  use Rp7payWeb, :controller

  alias Rp7pay.User

  action_fallback Rp7payWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rp7pay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
