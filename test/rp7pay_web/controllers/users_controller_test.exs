defmodule Rp7payWeb.UsersControllerTest do
  use Rp7payWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params are valid, create the user", %{conn: conn} do
      params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 40
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
        "message" => "User created",
        "user" => %{"account" => %{"balance" => "0.00", "id" => _account_id}, "id" => _user_id, "name" => "Raul Pereira", "nickname" => "raulpe7eira"}
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: "Raul Pereira",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 40
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected = %{"errors" => %{"detail" => %{"password" => ["can't be blank"]}}}

      assert response == expected
    end
  end
end
