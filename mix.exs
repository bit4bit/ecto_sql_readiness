defmodule EctoSqlReadiness.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_sql_readiness,
      version: "0.2.0",
      elixir: "~> 1.11",
      description: "Is Ecto ready?",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_check, "~> 0.14.0", only: [:test], runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/bit4bit/ecto_sql_readiness"},
      files: ~w(lib mix.exs README.md LICENSE)
    ]
  end
end
