defmodule HttpServer do
  require Logger
  
  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false,reuseaddr: true])
    Logger.info("Listening on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
    loop_acceptor(socket)
  end

  defp serve(socket) do
  socket
  |> read_line()
  |> write_line(socket)
  serve(socket)
  end

  defp read_line(socket) do
    {:ok, line} = :gen_tcp.recv(socket, 0)
    line
  end

  defp write_line(line,socket) do
    :gen_tcp.send(socket, line)
  end
end
