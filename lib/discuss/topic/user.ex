defmodule Discuss.Topic.User do 
  use Ecto.Schema
  import Ecto.Changeset
 #alias
 
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
     |> cast(params, [:email, :provider, :token])
     |> validate_required([:email, :provider, :token])
   # |> cast(params, [:title])
   # |> validate_required([:title])
  end

end