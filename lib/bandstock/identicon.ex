defmodule Bandstock.Identicon do
  alias Bandstock.Identicon.Image
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    #|> save_image("identicon")
  end

  def save_image(image, filename) do
    File.write("#{filename}.png", image)
    image
  end

  def draw_image(%Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    black = :egd.color({0,0,0})

    :egd.filledRectangle(image, {0,0}, {250,250}, black)
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
      #:egd.rectangle(image, start, stop, black)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end

    %Image{image | pixel_map: pixel_map}
  end

  def build_grid(%Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Image{image | grid: grid}
  end

  def filter_odd_squares(%Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end

    %Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | tail] = row
    row ++ [second, first]
  end

  def pick_color(%Image{hex: [r, g, b | _tail]} = image) do
    %Image{image | color: {r, g, b}} 
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Image{hex: hex}
  end
end
