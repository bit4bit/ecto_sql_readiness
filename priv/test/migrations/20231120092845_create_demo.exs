defmodule EctoSqlReadiness.Test.Repo.Migrations.CreateDemo do
  use Ecto.Migration, migration_repo: Store.Repo

  def change do
    create table(:demo) do
      timestamps()
    end
  end
end
