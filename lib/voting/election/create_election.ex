defmodule Voting.CreateElection do
  @moduledoc """
  Create election
  """
  import Ecto.Changeset

  alias Voting.{Election, Repo}
  alias Voting.Utils.ValidateDates

  def run(params) do
    %Election{}
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at, :created_by_id])
    |> validate_required([:name, :starts_at, :ends_at, :created_by_id])
    |> foreign_key_constraint(:created_by_id)
    |> ValidateDates.is_before(:starts_at, :ends_at)
    |> Repo.insert()
  end
end
