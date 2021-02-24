defmodule Rp7pay.Users.Create do
  alias Rp7pay.{Repo, User}

  def call(params) do
    params
    |> User.changeset
    |> Repo.insert
  end
end
