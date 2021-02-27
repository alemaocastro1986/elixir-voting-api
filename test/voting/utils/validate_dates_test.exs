defmodule Voting.Utils.ValidateDatesTest do
  @moduledoc """
    Validate dates test
  """
  use ExUnit.Case

  import Ecto.Changeset
  import Voting.Factory

  alias Voting.Utils.ValidateDates

  describe "is_before/3" do
    test "return a valid changeset" do
      changeset =
        :election
        |> build()
        |> Ecto.Changeset.change(%{
          starts_at: ~U[2020-02-26 22:13:00Z],
          ends_at: ~U[2020-02-26 23:59:59Z]
        })

      assert %Ecto.Changeset{valid?: true, errors: errors} =
               ValidateDates.is_before(changeset, :starts_at, :ends_at)

      assert Enum.empty?(errors)
    end

    test "returns error when the compared date is not before" do
      changeset =
        changeset =
        :election
        |> build()
        |> Ecto.Changeset.change(%{
          starts_at: ~U[2020-02-27 22:13:00Z],
          ends_at: ~U[2020-02-26 23:59:59Z]
        })

      assert %Ecto.Changeset{valid?: false, errors: errors} =
               ValidateDates.is_before(changeset, :starts_at, :ends_at)

      assert !Enum.empty?(errors)
      assert [starts_at: {"should be before ends_at", _}] = errors
    end
  end
end
