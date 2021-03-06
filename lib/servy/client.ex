defmodule Servy.HttpClient do
  def send_request(request) do
    some_host_in_net = 'localhost'
    {:ok, sock} = :gen_tcp.connect(some_host_in_net, 4000, [:binary, packet: :raw, active: false])
    :ok = :gen_tcp.send(sock, request)
    {:ok, _response} = :gen_tcp.recv(sock, 0)
    :ok = :gen_tcp.close(sock)
  end
end
