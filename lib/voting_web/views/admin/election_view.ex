defmodule VotingWeb.Admin.ElectionView do
  use VotingWeb, :view

  def render("index.json", %{elections: elections}) do
    %{
      status: "ok",
      data: Enum.map(elections, fn e -> election_json(e) end)
    }
  end

  def render("election.json", %{election: election}) do
    %{
      status: "ok",
      data: election_json(election)
    }
  end

  def election_json(election) do
    %{
      id: election.id,
      name: election.name,
      cover: election.cover,
      notice: election.notice,
      starts_at: election.starts_at,
      ends_at: election.ends_at
    }
  end
end
