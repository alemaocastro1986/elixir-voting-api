defmodule VotingWeb.Admin.SessionViewTest do
  use ExUnit.Case, async: true
  import Voting.Factory

  alias VotingWeb.Admin.SessionView

  describe "admin session_view " do
    test "render/2" do
      admin = params_for(:admin)

      assert %{status: "ok", data: %{name: "Jane Doe"}} =
               SessionView.render("session.json", %{admin: admin})
    end
  end
end
