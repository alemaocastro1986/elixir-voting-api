defmodule Voting.FakeFile do
  @moduledoc """
  Fake a File module
  """
  def stat("/user/local/images/large_logo.jpeg") do
    {:ok, %{size: 6_000_000}}
  end

  def stat(_file_path) do
    {:ok, %{size: 1_000_000}}
  end
end
