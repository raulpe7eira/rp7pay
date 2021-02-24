defmodule Rp7payWeb.AccountsController do
  use Rp7payWeb, :controller

  alias Rp7pay.Account

  action_fallback Rp7payWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rp7pay.deposit_account(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rp7pay.withdraw_account(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end
end
