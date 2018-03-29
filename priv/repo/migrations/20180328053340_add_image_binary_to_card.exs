defmodule Discuss.Repo.Migrations.AddImageBinaryToCard do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :image_binary, :binary
      add :image_binary_type, :string
    end
  end
end
