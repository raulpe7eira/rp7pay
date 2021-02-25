defmodule Rp7pay.Accounts.Withdraw do
  alias Rp7pay.Accounts.Operation

  def call(params) do
    Operation.call(:withdraw, params)
  end
end
