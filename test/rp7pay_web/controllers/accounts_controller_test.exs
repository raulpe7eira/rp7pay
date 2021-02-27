defmodule Rp7payWeb.AccountsControllerTest do
  use Rp7payWeb.ConnCase, async: true

  alias Rp7pay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 40
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rp7pay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOjEyMzQ=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => _id},
               "message" => "Balance changed successful"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected = %{"errors" => %{"detail" => %{"message" => "Invalid deposit value!"}}}

      assert response == expected
    end
  end
end
