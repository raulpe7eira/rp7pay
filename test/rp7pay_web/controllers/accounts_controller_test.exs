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

  describe "withdraw/2" do
    setup %{conn: conn} do
      params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 40
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rp7pay.create_user(params)

      Rp7pay.deposit_account(%{"id" => account_id, "value" => "100.00"})

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOjEyMzQ=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the withdraw", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
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
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:bad_request)

      expected = %{"errors" => %{"detail" => %{"message" => "Invalid withdraw value!"}}}

      assert response == expected
    end
  end

  describe "transaction/2" do
    setup %{conn: conn} do
      from_params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira-from",
        email: "raul-from@mail.com",
        age: 40
      }

      {:ok, %User{account: %Account{id: from_id}}} = Rp7pay.create_user(from_params)

      Rp7pay.deposit_account(%{"id" => from_id, "value" => "100.00"})

      to_params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira-to",
        email: "raul-to@mail.com",
        age: 40
      }

      {:ok, %User{account: %Account{id: to_id}}} = Rp7pay.create_user(to_params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOjEyMzQ=")

      {:ok, conn: conn, from_id: from_id, to_id: to_id}
    end

    test "when all params are valid, make the transaction", %{conn: conn, from_id: from_id, to_id: to_id} do
      params = %{
        "from" => from_id,
        "to" => to_id,
        "value" => "50.00"
      }

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction, params))
        |> json_response(:ok)

      assert %{
        "message" => "Transaction was successful",
        "transaction" => %{
          "from_account" => %{"balance" => "50.00", "id" => from_id},
          "to_account" => %{"balance" => "50.00", "id" => to_id}
        }
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, from_id: from_id, to_id: to_id} do
      params = %{
        "from" => from_id,
        "to" => to_id,
        "value" => "50.00a"
      }

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction, params))
        |> json_response(:bad_request)

      expected = %{"errors" => %{"detail" => %{"message" => "Invalid withdraw value!"}}}

      assert response == expected
    end
  end
end
