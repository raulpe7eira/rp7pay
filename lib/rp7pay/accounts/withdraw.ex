defmodule Rp7pay.Accounts.Withdraw do
  alias Ecto.Multi
  alias Rp7pay.{Account, Repo}

  def call(%{"id" => id, "value" => value}) do
    Multi.new
    |> Multi.run(:get_account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{get_account: account} -> update_balance(repo, account, value) end)
    |> run_transaction
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account, not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sub_value(value)
    |> update_account(repo)
  end

  defp sub_value(%Account{balance: balance} = account, value) do
    case Decimal.cast(value) do
      :error -> {:error, "Invalid deposit value!"}
      {:ok, value} -> {:ok, %{account: account, params: %{balance: Decimal.sub(balance, value)}}}
    end
  end

  defp update_account({:error, _reason} = error, _repo), do: error
  defp update_account({:ok, %{account: account, params: params}}, repo) do
    account
    |> IO.inspect
    |> Account.changeset(params)
    |> repo.update
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end
end
