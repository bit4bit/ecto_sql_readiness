# EctoSqlReadiness

How can we ensure that there are no pending migration during deployment?
How can we ensure that Ecto is ready?

This library has been used with AWS Codedeploy, so we don't send
any traffic to the containers unless we ensure that Ecto is ready to work.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_sql_readiness` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_sql_readiness, "~> 0.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ecto_sql_readiness>.

## Contributing

1. `code`
2. `MIX_ENV=test mix check`
