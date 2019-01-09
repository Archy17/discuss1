defmodule DiscussWeb.CommentsChannel do 
  use DiscussWeb, :channel 
  alias Discuss.Repo
  alias Discuss.Topic.Top
  alias Discuss.Comment

  def join("comments:" <> topic_id, _params, socket) do
    #IO.puts(name)  
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Top, topic_id)

    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
  #  IO.puts("++++")
  #  IO.puts(name)
  #  IO.inspect(message)
    topic = socket.assign.topic.top

    changeset = topic
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{content: content})


      case Repo.insert(changeset) do 
         {:ok, comment} ->
          {:reply, :ok, socket}
         {:error, _reason} ->
          {:reply, {:error, %{errors: changeset}}, socket}
      
      end
   end
end

