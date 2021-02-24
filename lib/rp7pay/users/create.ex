defmodule Rp7pay.Users.Create do
  alias Ecto.Multi
  alias Rp7pay.{Account, Repo, User}

  def call(params) do
    Multi.new
    |> Multi.insert(:create_user, changeset_user(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction
  end

  defp changeset_user(params), do: User.changeset(params)

  defp insert_account(repo, user) do
    user.id
    |> changeset_account
    |> repo.insert
  end

  defp changeset_account(user_id), do: Account.changeset(%{user_id: user_id, balance: "0.00"})

  defp preload_data(repo, user), do: {:ok, repo.preload(user, :account)}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
