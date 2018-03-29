defmodule Bandstock.Repo.Migrations.AddSheets do
  use Ecto.Migration

  def change do
	create table(:sheets) do
  		add :hash, :string
  		add :name, :string
  	end
  end
end
