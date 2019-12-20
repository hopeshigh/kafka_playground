# KafkaPlayground

Test app getting kafka and Elixir to play nice

Uses [kafka_ex](https://github.com/kafkaex/kafka_ex)

## How to run

`docker-compose up` 

This will create 3 `kafka` broker instances managed by `zookeeper`.
They are exposed on incrementing ports found at `9094, 9095, 9096`

To run the application perform the following steps:

`mix deps.get && mix deps.compile`
`iex -S mix phx.server`

The Phoenix app is currently overkill as it is command line based at the moment.

## API usage

To produce a message:

```
message = <MESSAGE>
KafkaPlayground.API.produce(message)
```

To read all messages:

```
KafkaPlayground.API.fetch()
```

To read messages from a particular offset:

```
offset = <NUMBER>
KafkaPlayground.API.fetch(offset)
```

To stream all messages:

```
KafkaPlayground.API.stream()
```

To stream all messages from a particular offset:

```
offset = <NUMBER>
KafkaPlayground.API.stream(offset)
```
