defmodule PaywiseScheduler.Process do
  alias PaywiseScheduler.Repo
  import Ecto.Query

  def get_scheduled_transfers() do
    from(
      from t in "ScheduledTransfer",
      left_join: recipient in "User", on: recipient.id == t.toUserId,
      left_join: sender in "User", on: sender.id == t.fromUserId,
      select: [t.fromUserId, t.toUserId, t.amount, t.nextTransferDate, recipient.email, recipient.name, recipient.dwollaCustomerId, sender.email, sender.name, sender.dwollaCustomerId ]
    )
    |> Repo.all()
    |> format_user()
    # |> inspect_user()
    # |> Task.async_stream(fn x -> inspect_user(x) end)
    # IO.puts("Hello world!")
    # query = from "User", select: [:email, :name, :username]
    # Repo.all(query)
    # |>inspect_user()
    # |> Task.async_stream(fn x -> x.email end)
  end

  defp format_user(user) do
   Enum.map(user, fn [from_user_id, to_user_id, amount, next_transfer_date, recipient_email, recipient_name, recipient_dwolla_id, sender_email, sender_name, sender_dwolla_id] ->
      %{
        from_user_id: from_user_id,
        to_user_id: to_user_id,
        amount: amount,
        recipient: %{
          email: recipient_email,
          name: recipient_name,
          dwolla_id: recipient_dwolla_id
        },
        sender: %{
          email: sender_email,
          name: sender_name,
          dwolla_id: sender_dwolla_id
        },
        next_transfer_date: next_transfer_date
      }
    end)
  end

  def inspect_user(user) do
    IO.inspect(user)
    user
  end 
end
