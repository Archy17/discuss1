defmodule Discuss.Comment do 
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.Topic.User
    belongs_to :top, Discuss.Topic.Top #, foreign_key: :article_id


    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end