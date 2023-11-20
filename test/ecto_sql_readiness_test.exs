defmodule EctoSqlReadinessTest do
  use ExUnit.Case

  defmodule TestRepo do
    use Ecto.Repo, otp_app: :ecto_sql_readiness, adapter: Ecto.Adapters.SQLite3

    def init(_type, config) do
      config =
        config
        |> Keyword.put(:database, ":memory:")
        |> Keyword.put(:pool_size, 1)
        |> Keyword.put(:priv, "priv/test")

      {:ok, config}
    end
  end

  describe "migrations" do
    setup do
      start_supervised!(TestRepo)
      :ok
    end

    test ":ok when there are no pending migrations" do
      {:ok, _, _} = Ecto.Migrator.with_repo(TestRepo, &Ecto.Migrator.run(&1, :up, all: true))

      assert :ok = EctoSqlReadiness.probes([TestRepo])
    end

    test ":pending when there are pending migrations" do
      assert :pending_migrations = EctoSqlReadiness.probes([TestRepo])
    end

    test "query pending migrations" do
      pending = EctoSqlReadiness.pending_migrations([TestRepo])
      assert [{TestRepo, 20_231_120_092_845, "create_demo"}] = pending
    end
  end

  test "fail_connection" do
    assert :fail_connection = EctoSqlReadiness.probes([TestRepo])
  end
end
