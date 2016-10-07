defmodule Web.Resolver.User do

  alias Web.User
  alias Web.Repo

  def find(%{id: id}, _) do
    case Web.Repo.get(User, id) do
      nil  -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def all(_, _) do
    {:ok, Repo.all(User) }
  end

  def create(attributes, _) do
    IO.inspect attributes
    changeset = User.changeset(%User{}, attributes)
    case Repo.insert(changeset) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end
end
