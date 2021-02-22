defmodule VotingWeb.Admin.ElectionViewTest do
  use ExUnit.Case
  import Voting.Factory

  alias VotingWeb.Admin.ElectionView

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
