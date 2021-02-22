defmodule Voting.CreateElectionTest do
  @moduledoc """
  Test create election
  """
  use ExUnit.Case
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.{CreateElection, Election}

  setup do
    admin = insert(:admin)
    :ok
  end

  describe "elections run/1" do
    test "return struct when the params are valid" do
      admin = insert(:admin)

      params = %{
        name: "Election 2021",
        cover: "url",
        notice: "url",
        starts_at: ~U[2021-02-21 09:00:00Z],
        ends_at: ~U[2021-02-28 18:30:59Z],
        created_by_id: admin.id
      }

      sut = CreateElection.run(params)

      assert {:ok, %Election{} = election} = sut
      assert election.name == "Election 2021"
      assert election.cover == "url"
      assert election.notice == "url"
      assert election.starts_at == ~U[2021-02-21 09:00:00Z]
      assert election.ends_at == ~U[2021-02-28 18:30:59Z]
    end

    test "Return error when name is missing" do
      admin = insert(:admin)

      params = %{
        cover: "url",
        notice: "url",
        starts_at: ~U[2021-02-21 09:00:00Z],
        ends_at: ~U[2021-02-28 18:30:59Z],
        created_by: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when starts_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "Elections 2021",
        cover: "url",
        notice: "url",
        ends_at: ~U[2021-02-28 18:30:59Z],
        created_by: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      assert %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when ends_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "Elections 2021",
        cover: "url",
        notice: "url",
        starts_at: ~U[2021-02-28 18:30:59Z],
        created_by: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      assert %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when created_by_id not found" do
      params = %{
        name: "Elections 2021",
        cover: "url",
        notice: "url",
        starts_at: ~U[2021-02-21 09:00:00Z],
        ends_at: ~U[2021-02-25 19:00:00Z],
        created_by_id: 99
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      assert %{created_by_id: ["does not exist"]} = errors_on(changeset)
    end

    test "Return error when 'start_at' is greater than ends 'at'" do
      admin = insert(:admin)

      params = %{
        name: "Election 2021",
        cover: "url",
        notice: "url",
        starts_at: ~U[2021-02-21 09:00:00Z],
        ends_at: ~U[2021-02-21 08:30:59Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      assert %{starts_at: ["start date cannot be less than end date"]} = errors_on(changeset)
    end
  end
end
