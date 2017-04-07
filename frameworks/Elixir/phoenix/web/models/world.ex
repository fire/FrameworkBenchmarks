defmodule Hello.World do
  use Ecto.Schema

  import Ecto.Changeset

  schema "world" do
    field :randomnumber, :integer
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:randomnumber])
    |> validate_required([:randomnumber])
  end
end
