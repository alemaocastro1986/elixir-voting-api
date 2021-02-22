defmodule VotingWeb.Admin.ElectionControllerTest do
  use ExUnit.Case
  use VotingWeb.ConnCase, async: true

  import Voting.AuthCase

  @election_route "/api/v1/elections"

  describe "create/2" do
    setup %{conn: conn} do
      conn = set_auth(conn)
      %{conn: conn}
    end

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
end
