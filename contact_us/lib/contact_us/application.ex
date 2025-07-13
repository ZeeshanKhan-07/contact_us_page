defmodule ContactUs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ContactUsWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:contact_us, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ContactUs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ContactUs.Finch},
      # Start a worker by calling: ContactUs.Worker.start_link(arg)
      # {ContactUs.Worker, arg},
      # Start to serve requests, typically the last entry
      ContactUsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ContactUs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ContactUsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
