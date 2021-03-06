defmodule VotingWeb.Plugs.AuthAccessPipeline do
  @moduledoc """
  Authenticate Plug pipeline
  """
  use Guardian.Plug.Pipeline, otp_app: :voting

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
