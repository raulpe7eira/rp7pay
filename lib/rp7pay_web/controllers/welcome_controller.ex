defmodule Rp7payWeb.WelcomeController do
  use Rp7payWeb, :controller

  alias Rp7pay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to RP7Pay API. Here is your number #{result}"})
  end
  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: reason})
  end
end
