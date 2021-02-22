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

  def election_factory do
    %Voting.Election{
      name: "Election 2020",
      cover: "http-to-an-image",
      notice: "http-to-an-pdf",
      starts_at: ~U[2020-02-01 09:00:00Z],
      ends_at: ~U[2020-02-28 18:30:59Z],
      created_by: build(:admin)
    }
  end
end
