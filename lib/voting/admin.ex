defmodule Voting.Admin do
  @moduledoc """
  Admin schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "administrators" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end
end
