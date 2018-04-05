defmodule Bandstock.SheetController do
	import Plug.Conn
	use Bandstock.Web, :controller

	alias Bandstock.Sheet
	alias Bandstock.Card

#def show(conn, %{"id" => sheet_id}) do
#		sheet = Repo.get(Sheet, sheet_id)
#		render conn, "show.html", sheet: sheet
#end

	def main(conn, params) do
		sheet = Repo.get(Sheet, 1) |>  
		Repo.preload(:cards)

		IO.inspect(sheet)
		render conn, "show.html", sheet: sheet
	end

	def new(conn, _params) do
		changeset = Sheet.changeset(%Sheet{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"sheet" => sheet}) do
		changeset = Sheet.changeset(%Sheet{}, sheet)

		case Repo.insert(changeset) do
			{:ok, new_sheet} -> 
				conn
				|> put_flash(:info, "Sheet Created")
				|> redirect(to: sheet_path(conn, :index))

			{:error, changeset} -> 
				IO.inspect(changeset)
				render conn, "new.html", changeset: changeset
		end
	end

	def index(conn, _params) do
		sheets = Repo.all(Sheet)
		render conn, "index.html", sheets: sheets
	end

	def show(conn, %{"id" => sheet_id}) do



		sheet = Repo.get(Sheet, sheet_id) |> preload(:cards)



		render conn, "show.html", sheet: sheet
	end
end
