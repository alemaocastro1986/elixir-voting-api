defmodule VotingWeb.Admin.ElectionController do
  use VotingWeb, :controller

  alias Voting.CreateElection
  alias Voting.ElectionRepo
  alias Voting.UpdateElection
  alias VotingWeb.Guardian

  def create(conn, params) do
    admin = Guardian.Plug.current_resource(conn)
    params = Map.put(params, "created_by_id", admin.id)

    case CreateElection.run(params) do
      {:ok, election} ->
        conn
        |> put_status(201)
        |> render("election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end

  def update(conn, %{"id" => election_id} = params) do
    election = ElectionRepo.get_election!(election_id)

    case UpdateElection.run(election, params) do
      {:ok, election} ->
        conn
        |> put_status(200)
        |> render("election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
