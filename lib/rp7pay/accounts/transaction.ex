defmodule Rp7pay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rp7pay.{Accounts.Operation, Repo, Transaction}

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    Multi.new
    |> Multi.merge(fn _changes -> Operation.call(:withdraw, build_params(from_id, value)) end)
    |> Multi.merge(fn _changes -> Operation.call(:deposit, build_params(to_id, value)) end)
    |> run_transaction
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: from_account, deposit: to_account}} -> {:ok, %Transaction{from_account: from_account, to_account: to_account}}
    end
  end
end
