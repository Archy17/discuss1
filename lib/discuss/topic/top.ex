defmodule Discuss.Topic.Top do
  use Ecto.Schema
  import Ecto.Changeset
  ##alias Snappy.Accounts.{User, Encryption}


  schema "topics" do
    field :title, :string

  end

   ##def changeset(%Struct{} = struct, params) do
   def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
    
   end

end 