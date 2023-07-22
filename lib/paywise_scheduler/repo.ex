defmodule PaywiseScheduler.Repo do
  use Ecto.Repo,
    otp_app: :paywise_scheduler,
    adapter: Ecto.Adapters.Postgres
end
