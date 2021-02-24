defmodule Rp7payWeb.UsersView do
  alias Rp7pay.User

  def render("create.json", %{user: %User{id: id, name: name, nickname: nickname, account: account}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account.id,
          balance: account.balance
        }
      }
    }
  end
end
