defmodule Rp7pay.Accounts.Deposit do
  alias Rp7pay.Accounts.Operation

  def call(params) do
    Operation.call(:deposit, params)
  end
end
