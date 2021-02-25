defmodule Rp7payWeb.AccountsView do
  alias Rp7pay.{Account, Transaction}

  def render("update.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Balance changed successful",
      account: %{
        id: id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{transaction: %Transaction{from_account: from_account, to_account: to_account}}) do
    %{
      message: "Transaction was successful",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to_account: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
