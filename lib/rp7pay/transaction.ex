defmodule Rp7pay.Transaction do
  alias Rp7pay.Account

  @enforce_keys [:from_account, :to_account]
  defstruct from_account: %Account{}, to_account: %Account{}
end
