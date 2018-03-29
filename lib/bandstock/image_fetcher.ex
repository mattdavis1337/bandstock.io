defmodule Bandstock.ImageFetcher do
  use GenServer

  alias Bandstock.Repo
  alias Bandstock.Card


  @name :image_fetcher

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts ++ [name: @name])
  end

  def hello() do
    IO.puts('hello')
  end

  def get_image(card) do
    IO.puts("In ImageFetcher")
    GenServer.cast(@name, card)
  end

  # Server implementation
  def init(_), do: {:ok, []}

  def handle_cast(card, _state) do

    IO.puts("++++struct")
    IO.inspect(card)

    %Card{hash: hash} = card
    image = Bandstock.Identicon.main(hash)
    params = %{image_binary: image, image_binary_type: "image/png"}
    IO.puts("++++params")
    IO.inspect(params)


    changeset = Card.changeset(card, params)
    IO.puts("++++changeset")
    IO.inspect(changeset)
    

    changeset
    |> Repo.update!
    
    {:noreply, []}
  end
  
  #defp get_content_type(headers) do
  #  header_map = headers |> Map.new
  #  header_map["Content-Type"]
  #end
end