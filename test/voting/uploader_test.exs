defmodule Voting.UploaderTest do
  @moduledoc """
  Upload files test
  """
  use ExUnit.Case, async: true
  use Mimic

  alias Voting.Uploader

  describe "execute/1" do
    test "return ok when file size is valid and upload is success" do
      expect(File, :cp, fn _from, _to -> :ok end)
      upload = %{filename: "file.jpeg", content_type: "image/jpeg", path: "/path-to-file"}

      assert {:ok, url} = Uploader.execute(upload)
      assert String.starts_with?(url, "http://localhost:4000/uploads")
      assert String.ends_with?(url, ".jpeg")
    end

    test "return error when file size is invalid" do
      reject(&File.cp/2)

      upload = %{
        filename: "file.jpeg",
        content_type: "image/jpeg",
        path: "/user/local/images/large_logo.jpeg"
      }

      assert {:error, :file_too_large} = Uploader.execute(upload)
    end

    test "return error when file upload as failed" do
      expect(File, :cp, fn _from, _to -> {:error, "_"} end)
      upload = %{filename: "file.jpeg", content_type: "image/jpeg", path: "/path-to-file"}

      assert {:error, :upload_error} = Uploader.execute(upload)
    end
  end
end
