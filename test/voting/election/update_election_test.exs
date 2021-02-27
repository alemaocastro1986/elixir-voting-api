defmodule Voting.UpdateElectionTest do
  @moduledoc """
  Test create election
  """
  use ExUnit.Case
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.{Election, UpdateElection}

  describe "elections run/1" do
    test "return struct updated when the params are valid" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params = %{
        name: "Election updated 2024",
        cover: "url updated",
        notice: "url updated",
        starts_at: ~U[2021-02-21 09:00:00Z],
        ends_at: ~U[2021-02-28 18:30:59Z]
      }

      sut = UpdateElection.run(election, params)

      assert {:ok, %Election{} = election} = sut
      assert election.name == "Election updated 2024"
      assert election.cover == "url updated"
      assert election.notice == "url updated"
      assert election.created_by_id == admin.id
    end

    test "Return error when name is missing" do
      election = insert(:election)

      params = %{
        name: "",
        cover: "url updated",
        notice: "url updated",
        starts_at: ~U[2021-02-28 15:30:59Z],
        ends_at: ~U[2021-02-28 18:30:59Z]
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when starts_at is missing" do
      election = insert(:election)

      params = %{
        starts_at: nil
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      assert %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when ends_at is missing" do
      election = insert(:election)

      params = %{
        ends_at: nil
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      assert %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when 'start_at' is greater than 'ends _at'" do
      election = insert(:election)

      params = %{
        name: "Election updated 2024",
        cover: "url updated",
        notice: "url updated",
        starts_at: ~U[2021-02-28 09:00:00Z],
        ends_at: ~U[2021-02-27 18:30:59Z]
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      assert %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
