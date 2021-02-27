defmodule Rp7payWeb.UsersViewTest do
  use Rp7payWeb.ConnCase, async: true

  import Phoenix.View

  alias Rp7pay.{Account, User}
  alias Rp7payWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Raul Pereira",
      password: "123456",
      nickname: "raulpe7eira",
      email: "raul@mail.com",
      age: 40
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rp7pay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Raul Pereira",
        nickname: "raulpe7eira"
      }
    }

    assert response == expected
  end
end
