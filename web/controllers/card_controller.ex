defmodule Bandstock.CardController do
	import Plug.Conn
	use Bandstock.Web, :controller

	alias Bandstock.Card
	alias Bandstock.ImageFetcher


	def show(conn, %{"id" => card_id}) do
		card = Repo.get(Card, card_id)
		render conn, "show.html", card: card
	end

	def index(conn, _params) do
		cards = Repo.all(Card)
		render conn, "index.html", cards: cards
	end

	def new(conn, _params) do
		changeset = Card.changeset(%Card{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"card" => card}) do
		IO.puts("+++card_controller card:")
		IO.inspect(card)  #%{"hash" => "Flatland2"}
		changeset = Card.changeset(%Card{}, card)
		IO.puts("+++card_controller changeset")
		IO.inspect(changeset) 
		IO.puts("++++")

		case Repo.insert(changeset) do
			{:ok, new_card} -> 
				IO.puts("+++card_controller new_card:")
				IO.inspect(new_card)
				IO.puts("++++")
				ImageFetcher.get_image(new_card)
				
				conn
				|> put_flash(:info, "Card Created")
				|> redirect(to: card_path(conn, :index))

			{:error, changeset} -> 
				IO.inspect(changeset)
				render conn, "new.html", changeset: changeset
		end
	end

	def image(conn, %{"id" => id}) do
	  card = Repo.get!(Card, id)
	  conn
	  |> put_resp_content_type("image/png", "utf-8") #get content type from db - card.image_binary_type
	  |> send_resp(200, card.image_binary)
	end

end