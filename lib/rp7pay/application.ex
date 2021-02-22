defmodule Rp7pay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Rp7pay.Repo,
      # Start the Telemetry supervisor
      Rp7payWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Rp7pay.PubSub},
      # Start the Endpoint (http/https)
      Rp7payWeb.Endpoint
      # Start a worker by calling: Rp7pay.Worker.start_link(arg)
      # {Rp7pay.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rp7pay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Rp7payWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
