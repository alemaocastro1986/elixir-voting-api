defmodule VotingWeb.FileController do
  use VotingWeb, :controller

  def not_found(conn, _params) do
    conn
    |> put_status(404)
    |> json(%{
      error: :not_found
    })
  end
end
