defmodule Exconsul.Client do
  @moduledoc """
  The Exconsul.Client is the GenServer that acts as a general entry point to the consul functionality
  """
  use GenServer
  require Logger

  def start_link do
    start_link(nil)
  end
  def start_link([], default) do
    start_link(default)
  end
  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def init(_args) do
    # get config and put it in the state
    url    = System.get_env("CONSUL_URL") || Application.get_env(:exconsul, :url, "http://localhost:8500")
    config = %{url: url}
    Logger.debug("Started Consul interface...")
    {:ok, %{config: config}}
  end

  def add_service(pid, service) do
    GenServer.call(pid, {:add_service, service})
  end
  def find_service(pid, service) do
    GenServer.call(pid, {:find_service, service})
  end
  def del_service(pid, service) do
    GenServer.call(pid, {:del_service, service})
  end

  def list_services(pid) do
    GenServer.call(pid, :list_services)
  end

  @doc """
  Internal implementation below the fold
  --------------------------------------

  These are the tasks that map to the actual implementation of the calls
  """

  def handle_call({:add_service, service}, _from, state) do
    {response, client} = Exconsul.Service.add(state.config, service)
    {:reply, response, Map.put(state, "client", client)}
  end
  def handle_call({:find_service, service}, _from, state) do
    {response, client} = Exconsul.Service.find(state.config, service)
    {:reply, response, Map.put(state, "client", client)}
  end
  def handle_call({:del_service, service}, _from, state) do
    {response, client} = Exconsul.Service.del(state.config, service)
    {:reply, response, Map.put(state, "client", client)}
  end

  def handle_call(:list_services, _from, state) do
    {response, client} = Exconsul.Service.all(state.config)
    {:reply, response, Map.put(state, "client", client)}
  end

end
