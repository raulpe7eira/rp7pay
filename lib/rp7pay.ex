defmodule Rp7pay do
  alias Rp7pay.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
