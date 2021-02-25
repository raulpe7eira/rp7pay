defmodule Rp7pay.Accounts.Withdraw do
  alias Rp7pay.{Accounts.Operation, Repo}

  def call(params) do
    :withdraw
    |> Operation.call(params)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: withdraw_account}} -> {:ok, withdraw_account}
    end
  end
end
