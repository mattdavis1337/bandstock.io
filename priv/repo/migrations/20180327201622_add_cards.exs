defmodule Discuss.Repo.Migrations.AddCards do
  use Ecto.Migration

  def change do
	create table(:cards) do
  		add :hash, :string
  		add :value, :integer
  	end
  end
end
