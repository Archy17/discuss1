defmodule Discuss.Repo.Migrations.AddComments2 do
  use Ecto.Migration

  def change do
     alter table(:comments) do
       add :top_id, references(:topics)

     end
  end
end
