defmodule Rp7pay.Accounts.Operation do
  alias Ecto.Multi
  alias Rp7pay.{Account, Repo}

  def call(operation, %{"id" => id, "value" => value}) do
    Multi.new
    |> Multi.run(:get_account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{get_account: account} -> update_balance(repo, operation, account, value) end)
    |> run_transaction
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, operation, account, value) do
    account
    |> do_operation(operation, value)
    |> update_account(repo)
  end

  defp do_operation(%Account{balance: balance} = account, operation, value) do
    case Decimal.cast(value) do
      :error -> {:error, "Invalid #{if operation == :deposit, do: 'deposit', else: 'withdraw'} value!"}
      {:ok, value} when operation == :deposit-> {:ok, %{account: account, params: %{balance: Decimal.add(balance, value)}}}
      {:ok, value} when operation == :withdraw -> {:ok, %{account: account, params: %{balance: Decimal.sub(balance, value)}}}
    end
  end

  defp update_account({:error, _reason} = error, _repo), do: error
  defp update_account({:ok, %{account: account, params: params}}, repo) do
    account
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
