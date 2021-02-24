defmodule Rp7payWeb.UsersController do
  use Rp7payWeb, :controller

  alias Rp7pay.User
  alias Ecto.Changeset

  def create(conn, params) do
    params
    |> Rp7pay.create_user
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end
  defp handle_response({:error, %Changeset{} = changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(Rp7payWeb.ErrorView)
    |> render("400.json", changeset: changeset)
  end
end
