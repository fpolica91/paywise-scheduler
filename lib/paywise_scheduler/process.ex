defmodule PaywiseScheduler.Process do
  alias PaywiseScheduler.Repo
  import Ecto.Query

  def get_scheduled_transfers() do
    IO.puts("Hello world!")
    query = from "User", select: [:email, :name, :username]
    Repo.all(query)
    |>inspect_user()
    |> Task.async_stream(fn x -> x.email end)
  end

  def inspect_user(user) do
    IO.inspect(user)
    user
  end 
end
