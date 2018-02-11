defmodule Exconsul do
  @moduledoc """
  Exconsul is a module that intrfaces with the consul daemon. It aims at
  providing a simple, flat API, being fast and robust 
  """

  require Logger

  # Service calls
  def add_service(service) do
    {:ok, pid} = GenServer.start_link(Exconsul.Client, [])
    res = Exconsul.Client.add_service(pid, service)
    GenServer.stop(pid)
    res
  end
  def find_service(service) do
    {:ok, pid} = GenServer.start_link(Exconsul.Client, [])
    res = Exconsul.Client.find_service(pid, service)
    GenServer.stop(pid)
    res
  end
  def del_service(service) do
    {:ok, pid} = GenServer.start_link(Exconsul.Client, [])
    res = Exconsul.Client.del_service(pid, service)
    GenServer.stop(pid)
    res
  end

  def list_services do
    {:ok, pid} = GenServer.start_link(Exconsul.Client, [])
    res = Exconsul.Client.list_services(pid)
    GenServer.stop(pid)
    res
  end

end
