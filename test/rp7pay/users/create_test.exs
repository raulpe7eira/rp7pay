defmodule Rp7pay.Users.CreateTest do
  use Rp7pay.DataCase, async: true

  alias Rp7pay.{User, Users.Create}

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Raul Pereira",
        password: "123456",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 40
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Raul Pereira", age: 40, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Raul Pereira",
        nickname: "raulpe7eira",
        email: "raul@mail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected
    end
  end
end
