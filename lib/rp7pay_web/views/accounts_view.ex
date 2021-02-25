defmodule Rp7payWeb.AccountsView do
  alias Rp7pay.Account

  def render("update.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: balance
      }
    }
  end
end
