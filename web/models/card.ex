defmodule Bandstock.Card do
	use Bandstock.Web, :model

	schema "cards" do
		field :hash, :string
		field :value, :integer
		field :image_binary, :binary
      	field :image_binary_type, :string
      	#belongs_to :sheet, Bandstock.Sheet
	end


	def changeset(struct, params \\ %{}) do
		#struct has a finite set of properties
		#struct represents a record in our database
		#params hash is a description of the new properties that we want to update our model with

		struct
		|> cast(params, [:hash, :image_binary, :image_binary_type, :value]) #produces the changeset. The object that records the updates to the database that we want to make. 
		|> validate_required([:hash]) 
	end
end