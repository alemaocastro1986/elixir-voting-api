defmodule Voting.Utils.ValidateDates do
  @moduledoc """
    Validate dates
  """
  import Ecto.Changeset

  def is_before(%Ecto.Changeset{valid?: true} = changeset, date, compare_date) do
    first_date = get_change(changeset, date)
    compare_date = get_change(changeset, compare_date)

    case DateTime.compare(first_date, compare_date) do
      :gt -> add_error(changeset, date, "start date cannot be less than end date")
      _ -> changeset
    end
  end

  def is_before(%Ecto.Changeset{} = changeset, _date, _compare_date), do: changeset
end
