defmodule DiscussWeb.TopicController do 
  use DiscussWeb, :controller 

  alias Discuss.Topic.Top

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    IO.inspect(conn.assigns)

    topics = Discuss.Repo.all(Discuss.Topic.Top)
    render conn, "index.html", topics: topics 
    
  end

  def new(conn, _params) do 
     changeset = Top.changeset(%Top{}, %{})

     render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"top" => top}) do
    changeset = Top.changeset(%Top{}, top)
    
   case Discuss.Repo.insert(changeset) do
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset

    end
  end 

  def edit(conn, %{"id" => topic_id}) do
    topic = Discuss.Repo.get(Top, topic_id)
    changeset = Top.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end
  
  def update(conn, %{"id" => topic_id, "top" => top}) do
    old_topic = Discuss.Repo.get(Top, topic_id)
    changeset = Top.changeset(old_topic, top)

    changeset = Discuss.Repo.get(Top, topic_id) |> Top.changeset(top)

    case Discuss.Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset
    end

  end

  def delete(conn, %{"id" => topic_id}) do 
    Discuss.Repo.get!(Top, topic_id) |> Discuss.Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

end
