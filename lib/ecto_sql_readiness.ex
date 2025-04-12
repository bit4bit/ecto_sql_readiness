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
defmodule EctoSqlReadiness do
  @moduledoc """
  How can we ensure that there are no pending migration during deployment?
  How can we ensure that Ecto is ready?

  This library has been used with AWS CodeDeploy, so we don't send
  any traffic to the containers unless we ensure that Ecto is ready to work.
  """

  alias EctoSqlReadiness.Probes
  @type repo :: module()

  @doc """
  Uses to known when the Ecto Repo is ready.

  ## Examples

      iex> EctoSqlReadiness.probes([Store.Repo])
      :ok
  """
  @spec probes([repo()]) :: :ok | :fail_connection | :pending_migrations
  def probes(repos) when is_list(repos) do
    Probes.probes(repos)
  end

  @doc """
  Get information about the pending migrations.

  ## Examples

  iex> EctoSqlReadiness.probes([Store.Repo])
  [{MyProject.Repo, 20231120092845, "create_demo"}]
  """
  @spec pending_migrations([repo()]) :: [{repo(), id :: term(), name :: String.t()}] | []
  def pending_migrations(repos) when is_list(repos) do
    Probes.pending_migrations(repos)
  end
end
