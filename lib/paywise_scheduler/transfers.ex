defmodule PaywiseScheduler.Transfers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scheduled_transfers" do
    field :amount, :decimal
    field :from_user_id, :integer
    field :to_user_id, :integer
    field :group_id, :integer
    field :next_transfer_date, :utc_datetime
    field :status, :string, default: "ACTIVE"
    timestamps()
  end

  @doc false
  def changeset(transfers, attrs) do
    transfers
    |> cast(attrs, [])
    |> validate_required([])
  end
end
