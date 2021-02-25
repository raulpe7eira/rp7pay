defmodule Rp7pay.Accounts.Deposit do
  alias Rp7pay.{Accounts.Operation, Repo}

  def call(params) do
    :deposit
    |> Operation.call(params)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: deposit_account}} -> {:ok, deposit_account}
    end
  end
end
