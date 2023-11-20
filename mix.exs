defmodule EctoSqlReadiness.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_sql_readiness,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, ">= 0.0.0"},
      {:ecto_sql, ">= 0.0.0"},
      {:ecto_sqlite3, "~> 0.12", only: [:test], runtime: false},
      {:ex_check, "~> 0.14.0", only: [:test], runtime: false}
    ]
  end
end
