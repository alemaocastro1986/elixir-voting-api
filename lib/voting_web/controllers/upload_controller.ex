defmodule VotingWeb.Admin.UploadController do
  use VotingWeb, :controller

  alias Voting.Uploader

  def create(conn, %{"file" => %Plug.Upload{} = upload}) do
    upload
    |> Uploader.execute()
    |> handle_response(conn)
  end

  defp handle_response({:ok, url}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{
      status: "ok",
      data: %{url: url}
    })
  end

  defp handle_response({:error, err}, conn) do
    conn
    |> put_status(400)
    |> json(%{
      error: %{
        message: err
      }
    })
  end
end
