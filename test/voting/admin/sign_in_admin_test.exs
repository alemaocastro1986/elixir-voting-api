defmodule Voting.SignInAdminTest do
  @moduledoc """
  Signin admin tes
  """
  use ExUnit.Case
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.{Admin, SignInAdmin}

  describe "run/2" do
    setup do
      insert(:admin)
      :ok
    end

    test "Returns a user case match password and email" do
      credentials = %{email: "jane@voting.com", password: "123456"}
      assert {:ok, %Admin{}} = SignInAdmin.run(credentials)
    end

    test "Return an error case email not match" do
      credentials = %{email: "non-unused@voting.com", password: "123456"}
      assert {:error, :email_or_password_invalid} = SignInAdmin.run(credentials)
    end

    test "Return an error case password not match" do
      credentials = %{email: "jane@voting.com", password: "incorrect_password"}
      assert {:error, :email_or_password_invalid} = SignInAdmin.run(credentials)
    end
  end
end
