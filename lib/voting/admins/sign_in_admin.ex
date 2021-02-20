defmodule Voting.SignInAdmin do
  @moduledoc """
  SignIn is as admin
  """
  import Bcrypt
  alias Voting.{Admin, Repo}

  def run(%{email: email, password: password}) do
    case Repo.get_by(Admin, email: email) do
      %Admin{} = admin ->
        if(verify_pass(password, admin.password_hash),
          do: {:ok, admin},
          else: {:error, :email_or_password_invalid}
        )

      nil ->
        {:error, :email_or_password_invalid}
    end
  end
end
