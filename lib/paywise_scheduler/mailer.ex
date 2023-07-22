defmodule PaywiseScheduler.Mailer do
  use Swoosh.Mailer, otp_app: :paywise_scheduler

  def welcome_email() do
    IO.puts("Hello world!")
    Enum.map(1..10, fn x -> x end)
  end
end
