defmodule Servy.FourOhFourCounter do
  @name :counter_404

  # Client Interface

  def start do
    IO.puts("Starting the 404 counter...")
    pid = spawn(__MODULE__, :listen_loop, [%{}])
    Process.register(pid, @name)
    pid
  end

  def bump_count(path) do
    send(@name, {self(), :bump_count, path})

    receive do
      {:response, status} -> status
    end
  end

  def get_count(path) do
    send(@name, {self(), :get_count, path})

    receive do
      {:response, couter} -> couter
    end
  end

  # Server

  def listen_loop(state) do
    receive do
      {sender, :bump_count, path} ->
        new_state = Map.update(state, path, 1, fn v -> v + 1 end)
        send(sender, {:response, new_state})
        listen_loop(new_state)

      {sender, :get_count} ->
        send(sender, {:response, state})
        listen_loop(state)

      unexpected ->
        IO.puts("Unexpected messaged: #{inspect(unexpected)}")
        listen_loop(state)
    end
  end

  defp send_pledge_to_service(_name) do
    # CODE GOES HERE TO SEND PLEDGE TO EXTERNAL SERVICE
    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end
end

# alias Servy.FourOhFourCounterx`

# pid = FourOhFourCounter.start()

# send pid, {:stop, "hammertime"}

# IO.inspect FourOhFourCounter.bump_count("larry", 10)
# IO.inspect FourOhFourCounter.bump_count("moe", 20)
# IO.inspect FourOhFourCounter.bump_count("curly", 30)
# IO.inspect FourOhFourCounter.bump_count("daisy", 40)
# IO.inspect FourOhFourCounter.bump_count("grace", 50)

# IO.inspect FourOhFourCounter.recent_pledges()

# IO.inspect FourOhFourCounter.total_pledged()

# IO.inspect Process.info(pid, :messages)
