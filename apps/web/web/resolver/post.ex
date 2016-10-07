defmodule Web.Resolver.Post do

  alias Web.Post
  alias Web.Repo

  def find(%{id: id}, _) do
    case Web.Repo.get(Post, id) do
      nil  -> {:error, "Post id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def all(_, _) do
    {:ok, Repo.all(Post) }
  end

  def create(attributes, _) do
    IO.inspect attributes
    changeset = Post.changeset(%Post{}, attributes)
    case Repo.insert(changeset) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end
end
