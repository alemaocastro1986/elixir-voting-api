defmodule VotingWeb.Admin.SessionControllerTest do
  use ExUnit.Case
  use VotingWeb.ConnCase, async: true

  import Voting.Factory

  alias VotingWeb.Admin

  @singn_in_route "/api/v1/admin/signin"
  @admin_valid %{"email" => "jane@voting.com", "password" => "123456"}
  @admin_email_invalid %{"email" => "not_mail@voting.com", "password" => "123456"}
  @admin_password_invalid %{"email" => "jane@voting.com", "password" => "not_pass"}

  describe "create/2" do
    setup %{conn: conn} do
      insert(:admin)
      %{conn: conn}
    end

    test "Return status 200 when admin credentials are valid", %{conn: conn} do
      conn = post(conn, @singn_in_route, @admin_valid)

      assert %{"status" => "ok", "data" => %{"name" => "Jane Doe"}} = json_response(conn, 200)
    end

    test "Return status 401 when admin email invalid", %{conn: conn} do
      conn = post(conn, @singn_in_route, @admin_email_invalid)

      assert %{"status" => "Unauthenticated"} = json_response(conn, 401)
    end

    test "Return status 401 when password email invalid", %{conn: conn} do
      conn = post(conn, @singn_in_route, @admin_password_invalid)

      assert %{"status" => "Unauthenticated"} = json_response(conn, 401)
    end
  end
end
