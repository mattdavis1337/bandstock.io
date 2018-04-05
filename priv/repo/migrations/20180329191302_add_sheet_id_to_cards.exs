defmodule Bandstock.Repo.Migrations.AddSheetIdToCards do
  use Ecto.Migration

  def change do
  	alter table(:cards) do
  		add :sheet_id, references(:sheets)
  	end
  end
end
