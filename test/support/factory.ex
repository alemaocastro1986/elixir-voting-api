defmodule Voting.Factory do
  @moduledoc """
  Mock Repository
  """
  # with Ecto
  use ExMachina.Ecto, repo: Voting.Repo

  def admin_factory do
    %Voting.Admin{
      name: "Jane Doe",
      email: "jane@voting.com",
      password_hash: Bcrypt.hash_pwd_salt("123456")
    }
  end
end
