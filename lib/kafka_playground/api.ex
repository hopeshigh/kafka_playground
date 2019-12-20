defmodule KafkaPlayground.API do
  @topic "example_topic"
  @partition 0

  @doc """
  Fetches the latest set of messages and updates the 
  offset.
  """
  def fetch(offset \\ 0) do
    case KafkaEx.fetch(@topic, @partition, offset: offset) do
      :topic_not_found -> 
        {:error, :topic_is_empty_or_not_found}
      content ->
        {:ok, content}
    end
  end

  @doc """
  Produces a message to the Kafka stream
  """
  def produce(message) do
    request =
      message
      |> compose_message()
      |> compose_request()

    KafkaEx.produce(request)
  end

  @doc """
  Streams the kafka topic.
  Kills the stream when all topics have been consumed
  """
  def stream(offset \\ 0) do
    stream = KafkaEx.stream(@topic, @partition, no_wait_at_logend: true, offset: offset)
    Enum.map(stream, fn m -> m.value end)
  end

  defp compose_message(message) do
    %KafkaEx.Protocol.Produce.Message{value: message}
  end

  defp compose_request(message) do
    %KafkaEx.Protocol.Produce.Request{
      topic: @topic,
      partition: @partition,
      required_acks: 1,
      messages: [message]
    }
  end
end
