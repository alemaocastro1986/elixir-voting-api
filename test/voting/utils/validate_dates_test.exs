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
      changeset = build(:changeset)

      assert %Ecto.Changeset{valid?: true, errors: errors} =
               ValidateDates.is_before(changeset, :starts_at, :ends_at)

      assert Enum.empty?(errors)
    end

    test "returns error when the compared date is not before" do
      changeset =
        build(:changeset, %{
          changes: %{
            starts_at: ~U[2020-02-05 09:00:00Z],
            ends_at: ~U[2020-02-04 18:30:59Z]
          }
        })

      assert %Ecto.Changeset{valid?: false, errors: errors} =
               ValidateDates.is_before(changeset, :starts_at, :ends_at)

      assert !Enum.empty?(errors)
      assert [starts_at: {"start date cannot be less than end date", _}] = errors
    end
  end
end
