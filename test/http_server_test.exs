defmodule HttpServerTest do
  use ExUnit.Case, async: true
  alias Servy.HttpServer

  test "concurrent Http server petition Task()" do
    spawn(HttpServer, :start, [4000])

    url = "http://localhost:4000/wildthings"

    1..5
    |> Enum.map(fn _ -> Task.async(fn -> HTTPoison.get(url) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.map(&assert_successful_response/1)
  end

  defp assert_successful_response({:ok, res}) do
    assert res.status_code == 200
  end
end
