defmodule PledgeTest do
  # IO.inspect PledgeServer.create_pledge("larry", 10)
  # IO.inspect PledgeServer.create_pledge("moe", 20)
  # IO.inspect PledgeServer.create_pledge("curly", 30)
  # IO.inspect PledgeServer.create_pledge("daisy", 40)
  # IO.inspect PledgeServer.create_pledge("grace", 50)
  use ExUnit.Case, async: true
  alias Servy.PledgeServer

  test "latest three pladges" do
    latest_pledge = [
      {"grace", 50},
      {"daisy", 40},
      {"curly", 30},
    ]

    # spawn(PlegeServer,:start,[])
    PledgeServer.start()
    # pid = self()
    PledgeServer.create_pledge("larry", 10)
    PledgeServer.create_pledge("moe", 20)
    PledgeServer.create_pledge("curly", 30)
    PledgeServer.create_pledge("daisy", 40)
    PledgeServer.create_pledge("grace", 50)

    recent_pledges = PledgeServer.recent_pledges()
    assert Enum.count(recent_pledges) == 3
    assert latest_pledge == recent_pledges
  end
end
