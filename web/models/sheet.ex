defmodule Bandstock.Sheet do
	use Bandstock.Web, :model

	schema "sheets" do
		field :hash, :string
		field :name, :string
		has_many :cards, Bandstock.Card

		#timestamps()
	end

	def changeset(struct, params \\ %{}) do
		#struct has a finite set of properties
		#struct represents a record in our database
		#params hash is a description of the new properties that we want to update our model with

		struct
		|> cast(params, [:hash, :name]) #produces the changeset. The object that records the updates to the database that we want to make. 
		|> validate_required([:hash, :name])
	end
end