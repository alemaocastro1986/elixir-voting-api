defmodule VotingWeb.Admin.ElectionControllerTest do
  @moduledoc """
  Election Controller test
  """
  use ExUnit.Case
  use VotingWeb.ConnCase, async: true

  import Voting.{AuthCase, Factory}

  @election_route "/api/v1/elections"

  setup %{conn: conn} do
    conn = set_auth(conn)
    %{conn: conn}
  end

  describe "create/2" do
    test "returns 201 status code when election create is sucessfully", %{conn: conn} do
      params = %{
        "name" => "State Elections 2021",
        "cover" => "sample_url",
        "notice" => "sample.pdf",
        "starts_at" => "2021-05-01 08:00:00Z",
        "ends_at" => "2021-05-01 17:00:00Z"
      }

      conn = post(conn, @election_route, params)

      assert %{"status" => "ok", "data" => data} = json_response(conn, 201)
      assert is_number(data["id"])
      assert data["name"] == "State Elections 2021"
    end

    test "returns 422 status code when election create is invalid", %{conn: conn} do
      params = %{
        "name" => "State Elections 2021",
        "cover" => "sample_url",
        "notice" => "sample.pdf",
        "starts_at" => "2021-05-02 08:00:00Z",
        "ends_at" => "2021-05-01 17:00:00Z"
      }

      conn = post(conn, @election_route, params)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end

  describe "update/2" do
    test "returns 200 status code when election create is sucessfully", %{conn: conn} do
      election = insert(:election)

      params = %{
        "name" => "Update name"
      }

      response =
        conn
        |> put("/api/v1/elections/#{election.id}", params)
        |> json_response(:ok)

      assert %{"status" => "ok", "data" => %{"name" => "Update name"}} = response
    end

    test "returns 422 status code when election update is invalid", %{conn: conn} do
      election = insert(:election)

      params = %{
        "name" => "State Elections 2021",
        "cover" => "sample_url",
        "notice" => "sample.pdf",
        "starts_at" => "2021-05-02 08:00:00Z",
        "ends_at" => "2021-05-01 17:00:00Z"
      }

      response =
        conn
        |> put(Routes.election_path(conn, :update, election.id, params))
        |> json_response(422)

      assert %{"status" => "unprocessable entity"} == response
    end
  end
end
