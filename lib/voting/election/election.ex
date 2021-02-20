defmodule Election do
  @moduledoc """
  Election schema
  """

  use Ecto.Schema

  alias Voting.Admin

  schema "elections" do
    field :name, :string
    field :cover, :string
    field :notice, :string
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime
    belongs_to :created_by, Admin

    timestamps()
  end
end
