defmodule Rp7payWeb.WelcomeControllerTest do
  use Rp7payWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, sum numbers", %{conn: conn} do
      response =
        conn
        |> get(Routes.welcome_path(conn, :index, "numbers"))
        |> json_response(:ok)

      expected = %{"message" => "Welcome to RP7Pay API. Here is your number 37"}

      assert response == expected
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.welcome_path(conn, :index, "no_files"))
        |> json_response(:bad_request)

      expected = %{"message" => "Invalid file!"}

      assert response == expected
    end
  end
end
