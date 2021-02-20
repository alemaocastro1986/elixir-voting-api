defmodule Voting.CreateAdminTest do
  use ExUnit.Case
  use Voting.DataCase, async: true

  alias Voting.{Admin, CreateAdmin}

  describe "run/1" do
    test "Return struct when the params are valid" do
      params = %{name: "John Doe", email: "john@teste.com", password: "12356"}

      sut = CreateAdmin.run(params)

      assert {:ok, %Admin{} = admin} = sut
      assert admin.name == "John Doe"
      assert admin.email == "john@teste.com"
      refute admin.password_hash == "123456"
    end

    test "Return error when name is missing" do
      params = %{email: "john@teste.com", password: "12356"}

      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when email is missing" do
      params = %{name: "John doe", password: "12356"}

      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      assert %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "Return error when password is missing" do
      params = %{name: "John doe", email: "john@teste.com"}

      assert {:error, %Ecto.Changeset{} = changeset} = CreateAdmin.run(params)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
