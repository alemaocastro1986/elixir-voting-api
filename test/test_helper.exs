{:ok, _} = Application.ensure_all_started(:ex_machina)
Mimic.copy(File)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Voting.Repo, :manual)
