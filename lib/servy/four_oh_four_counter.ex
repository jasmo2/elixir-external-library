defmodule Servy.FourOhFourCounter do
  @name :four_oh_four_counter

  alias Servy.GenericServer, as: GS

  def start do
    IO.puts("Starting the pledge server...")
    GS.start(__MODULE__, %{}, @name)
  end

  def bump_count(path) do
    GS.call(@name, {:bump_count, path})
  end

  def get_counts do
    IO.inspect(GS.call(@name, :get_counts))
  end

  def get_count(path) do
    GS.call(@name, {:get_count, path})
  end

  def reset do
    GS.cast(@name, :reset)
  end

  # Server Callbacks

  def handle_call({:bump_count, path}, state) do
    # new_state = Map.update(state, path, 1, &(&1 + 1))
    new_state = Map.update(state, path, 1, fn acc -> acc + 1 end)
    {:ok, new_state}
  end

  def handle_call(:get_counts, state) do
    {state, state}
  end

  def handle_call({:get_count, path}, state) do
    count = Map.get(state, path, 0)
    {count, state}
  end

  def handle_cast(:reset, _state) do
    %{}
  end

  def handle_info(other, state) do
    IO.puts("Unexpected message #{inspect(other)}")
    state
  end
end
