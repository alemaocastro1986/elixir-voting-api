defmodule VotingWeb.Admin.UploadControllerTest do
  @moduledoc """
  Upload files test
  """
  use ExUnit.Case
  use VotingWeb.ConnCase, async: true

  import Mimic
  import Voting.AuthCase

  @upload_route "/api/v1/uploads"

  describe "create/2" do
    setup %{conn: conn} do
      conn = set_auth(conn)
      %{conn: conn}
    end

    test "return 200 when upload is sucesss", %{conn: conn} do
      expect(File, :cp, fn _from, _to -> :ok end)

      params = %{
        "file" => %Plug.Upload{
          content_type: "application/pdf",
          filename: "Aula08_Engenharia_Requisitos.pdf",
          path: "/tmp/plug-1614/multipart-1614279855-571672836547955-3"
        }
      }

      conn = post(conn, @upload_route, params)

      assert %{"status" => "ok", "data" => %{"url" => _}} = json_response(conn, 200)
    end

    test "return 400 when upload is invalid", %{conn: conn} do
      expect(File, :cp, fn _from, _to -> {:error, "_"} end)

      params = %{
        "file" => %Plug.Upload{
          content_type: "application/pdf",
          filename: "Aula08_Engenharia_Requisitos.pdf",
          path: "/tmp/plug-1614/multipart-1614279855-571672836547955-3"
        }
      }

      conn = post(conn, @upload_route, params)
      assert %{"error" => %{"message" => "upload_error"}} = json_response(conn, 400)
    end

    test "return 400 when upload large file", %{conn: conn} do
      reject(&File.cp/2)

      params = %{
        "file" => %Plug.Upload{
          content_type: "application/pdf",
          filename: "Aula08_Engenharia_Requisitos.pdf",
          path: "/user/local/images/large_logo.jpeg"
        }
      }

      conn = post(conn, @upload_route, params)
      assert %{"error" => %{"message" => "file_too_large"}} = json_response(conn, 400)
    end
  end
end
