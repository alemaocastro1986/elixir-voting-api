defmodule VotingWeb.Admin.ElectionViewTest do
  @moduledoc """
  Election view test
  """
  use ExUnit.Case, async: true
  import Voting.Factory

  alias VotingWeb.Admin.ElectionView

  describe "Admin list elections" do
    test "render/2" do
      elections = [build(:election, id: 1), build(:election, id: 2)]

      assert %{status: "ok", data: list_elections} =
               ElectionView.render("index.json", %{elections: elections})

      assert is_list(list_elections)
      assert length(list_elections) == 2

      assert [
               %{
                 id: 1,
                 name: "Election 2020",
                 cover: "http-to-an-image",
                 notice: "http-to-an-pdf",
                 starts_at: ~U[2020-02-01 09:00:00Z],
                 ends_at: ~U[2020-02-28 18:30:59Z]
               },
               %{
                 id: 2,
                 name: "Election 2020",
                 cover: "http-to-an-image",
                 notice: "http-to-an-pdf",
                 starts_at: ~U[2020-02-01 09:00:00Z],
                 ends_at: ~U[2020-02-28 18:30:59Z]
               }
             ] = elections
    end
  end

  describe "Admin election_view" do
    test "render/2" do
      election = build(:election)

      assert %{
               status: "ok",
               data: %{
                 id: nil,
                 name: "Election 2020",
                 cover: _,
                 notice: _,
                 starts_at: _,
                 ends_at: _
               }
             } = ElectionView.render("election.json", %{election: election})
    end
  end
end
