defmodule Rp7payWeb.AccountsController do
  use Rp7payWeb, :controller

  alias Rp7pay.{Account, Transaction}

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

  def transaction(conn, params) do
    task = Task.async(fn -> Rp7pay.transaction_account(params) end)
    with {:ok, %Transaction{} = transaction} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
