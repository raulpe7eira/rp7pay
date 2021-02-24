defmodule Rp7pay do
  alias Rp7pay.Users.Create, as: UserCreate

  alias Rp7pay.Accounts.Deposit, as: AccountDeposit
  alias Rp7pay.Accounts.Withdraw, as: AccountWithdraw

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit_account(params), to: AccountDeposit, as: :call
  defdelegate withdraw_account(params), to: AccountWithdraw, as: :call
end
