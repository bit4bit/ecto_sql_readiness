# Copyright 2023 Jovany Leandro G.C <bit4bit@riseup.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
defmodule EctoSqlReadiness.Probes do
  @moduledoc false

  def probes(repos) when is_list(repos) do
    cond do
      not has_connections?(repos) ->
        :fail_connection

      length(new_migrations(repos)) != 0 ->
        :pending_migrations

      true ->
        :ok
    end
  end

  def pending_migrations(repos) when is_list(repos) do
    new_migrations(repos)
    |> Enum.map(fn
      {repo, _state, id, name} ->
        {repo, id, name}
    end)
  end

  defp has_connections?(repos) do
    open_connections(repos)
    |> Enum.all?(fn
      {_repo, :ok} -> true
      _ -> false
    end)
  end

  defp open_connections(repos) do
    for repo <- repos do
      try do
        case Ecto.Adapters.SQL.query(repo, "SELECT 1") do
          {:ok, _} ->
            {repo, :ok}

          {:error, error} ->
            {repo, {:error, error}}
        end
      rescue
        ex ->
          {repo, {:error, ex}}
      end
    end
  end

  defp new_migrations(repos) do
    migrations(repos)
    |> Enum.filter(fn
      {_repo, :down, _version, _} ->
        true

      _ ->
        false
    end)
    |> Enum.reverse()
  end

  defp migrations(repos) do
    for repo <- repos do
      result =
        Ecto.Migrator.with_repo(repo, fn repo ->
          Ecto.Migrator.migrations(repo)
          |> Enum.reject(fn {_, _id, name} ->
            name == "** FILE NOT FOUND **"
          end)
          |> Enum.map(fn {status, id, name} ->
            {repo, status, id, name}
          end)
        end)

      {:ok, return, _} = result
      return
    end
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end
end
