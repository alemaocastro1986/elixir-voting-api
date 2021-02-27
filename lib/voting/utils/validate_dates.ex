defmodule Voting.Utils.ValidateDates do
  @moduledoc """
    Validate dates
  """
  import Ecto.Changeset, only: [get_field: 2, add_error: 3]

  def is_before(
        %Ecto.Changeset{valid?: true} = changeset,
        date,
        compare
      ) do
    first_date = get_field(changeset, date)
    second_date = get_field(changeset, compare)

    case DateTime.compare(first_date, second_date) do
      :gt -> add_error(changeset, date, "should be before #{compare}")
      _ -> changeset
    end
  end

  def is_before(%Ecto.Changeset{} = changeset, _, _), do: changeset
end
