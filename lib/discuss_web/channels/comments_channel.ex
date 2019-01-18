defmodule DiscussWeb.CommentsChannel do 
  use DiscussWeb, :channel 
  alias Discuss.Repo
  alias Discuss.Topic.Top
  alias Discuss.Comment

  def join("comments:" <> top_id, _params, socket) do
    # IO.puts("++++++++++")  
    top_id = String.to_integer(top_id)
    topic = Top
      |> Repo.get(top_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
  #  IO.puts("++++")
  #  IO.puts(name)
  #  IO.inspect(message)
    topic = socket.assigns.topic
   # user_id = socket.assigns.user_id

    changeset = topic
      |> Ecto.build_assoc(:comments, user_id: socket.assigns.user_id)
      |> Comment.changeset(%{content: content})


      case Repo.insert(changeset) do 
         {:ok, comment} ->
           broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", 
              %{comment: comment}
            )
          {:reply, :ok, socket}
         {:error, _reason} ->
          {:reply, {:error, %{errors: changeset}}, socket}
      
      end
   end
end

