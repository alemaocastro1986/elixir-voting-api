defmodule Voting.AuthCase do
  @moduledoc """
   Auth Case to set header authorization in conn
  """
  import Voting.Factory
  import Plug.Conn

  alias VotingWeb.Guardian

  def set_auth(conn, admin \\ insert(:admin)) do
    {:ok, token, _} = Guardian.encode_and_sign(admin)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
