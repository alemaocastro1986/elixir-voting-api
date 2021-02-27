defmodule Voting.UpdateElection do
  @moduledoc """
  Updated election
  """
  import Ecto.Changeset

  alias Voting.{Election, Repo}
  alias Voting.Utils.ValidateDates

  def run(%Election{} = election, params) do
    election
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at])
    |> validate_required([:name, :starts_at, :ends_at])
    |> ValidateDates.is_before(:starts_at, :ends_at)
    |> Repo.update()
  end
end
