defmodule KafkaPlayground.Repo do
  use Ecto.Repo,
    otp_app: :kafka_playground,
    adapter: Ecto.Adapters.Postgres
end
