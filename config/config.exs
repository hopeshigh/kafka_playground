# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# KafkaEx configuration
config :kafka_ex,
  # A list of brokers to connect to. This can be in either of the following formats
  brokers: [
    {"localhost", 9094},
    {"localhost", 9095},
    {"localhost", 9096},
  ],
  consumer_group: "kafka_playground",
  disable_default_worker: false,
  # Timeout value, in msec, for synchronous operations (e.g., network calls).
  # If this value is greater than GenServer's default timeout of 5000, it will also
  # be used as the timeout for work dispatched via KafkaEx.Server.call (e.g., KafkaEx.metadata).
  # In those cases, it should be considered a 'total timeout', encompassing both network calls and
  # wait time for the genservers.
  sync_timeout: 5000,
  # Supervision max_restarts - the maximum amount of restarts allowed in a time frame
  max_restarts: 10,
  # Supervision max_seconds -  the time frame in which :max_restarts applies
  max_seconds: 60,
  # Interval in milliseconds that GenConsumer waits to commit offsets.
  commit_interval: 5_000,
  # Threshold number of messages consumed for GenConsumer to commit offsets
  # to the broker.
  commit_threshold: 100,
  # Interval in milliseconds to wait before reconnect to kafka
  sleep_for_reconnect: 400,
  # set this to the version of the kafka broker that you are using
  # include only major.minor.patch versions.  must be at least 0.8.0
  # use "kayrock" for the new client
  kafka_version: "0.10.1"

config :kafka_playground,
  ecto_repos: [KafkaPlayground.Repo]

# Configures the endpoint
config :kafka_playground, KafkaPlaygroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mnpDHsLstHBFTVS74q53T41sGiTDgOaYi+X8wML5Inb4Afj+EkY9wHU1yGC8KSpS",
  render_errors: [view: KafkaPlaygroundWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KafkaPlayground.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
