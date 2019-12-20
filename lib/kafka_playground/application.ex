defmodule KafkaPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    gen_consumer_impl = KafkaPlayground.GenConsumer
    consumer_group_name = "kafka_playground"
    topic_names = ["example_topic"]

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      KafkaPlayground.Repo,
      # Start the endpoint when the application starts
      KafkaPlaygroundWeb.Endpoint,
      # Starts a worker by calling: KafkaPlayground.Worker.start_link(arg)
      # {KafkaPlayground.Worker, arg},
      %{
        id: ConsumerGroup,
        start: {
          KafkaEx.ConsumerGroup, 
          :start_link,
          [
            gen_consumer_impl,
            consumer_group_name,
            topic_names,
            consumer_group_opts
          ]
        },
        type: :supervisor
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KafkaPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KafkaPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
