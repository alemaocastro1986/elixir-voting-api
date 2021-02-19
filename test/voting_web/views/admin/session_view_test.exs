defmodule VotingWeb.Admin.SessionViewTest do
  use ExUnit.Case, async: true
  import Voting.Factory

  alias VotingWeb.Admin.SessionView

  describe "admin session_view " do
    test "render/2" do
      admin = params_for(:admin)

      assert %{status: "ok", data: %{name: "Jane Doe", token: "foo"}} =
               SessionView.render("session.json", %{admin: admin, token: "foo"})
    end
  end
end
