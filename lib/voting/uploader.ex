defmodule Voting.Uploader do
  @moduledoc """
  Upload files
  """

  @file_size_limit 5_000_000

  alias Ecto.UUID

  def execute(%{content_type: _, filename: name, path: path}) do
    with :ok <- check_file_size(path), {:ok, filename} <- generate_filename(name) do
      local_storage(filename, path)
    end
  end

  defp check_file_size(path) do
    file_module = Application.get_env(:voting, :file_module)
    {:ok, %{size: size}} = file_module.stat(path)

    if size <= @file_size_limit do
      :ok
    else
      {:error, :file_too_large}
    end
  end

  defp generate_filename(filename) do
    filename =
      filename
      |> get_file_extension()
      |> unique_filename()

    {:ok, filename}
  end

  defp get_file_extension(filename) do
    filename
    |> String.split(".", trim: true)
    |> List.last()
  end

  defp unique_filename(extension) do
    UUID.generate() <> ".#{extension}"
  end

  defp local_storage(filename, path) do
    case File.cp(path, "./uploads/#{filename}") do
      :ok -> {:ok, "http://localhost:4000/uploads/#{filename}"}
      {:error, _} -> {:error, :upload_error}
    end
  end
end
