defmodule Exconsul.Service do

  use Tesla
  require Logger

  def add(config, service) do
    c = Exconsul.Helper.client(config)
    res = put(c, "/agent/service/register", service)
    {res, c}
  end
  
  def all(config) do
    c = Exconsul.Helper.client(config)
    res = get(c, "/agent/services") 
    {res, c}
  end

  def find(config, %{"Name" => name}) do
    c = Exconsul.Helper.client(config)
    res = get(c, "/catalog/service/#{name}") 
    {res, c}
  end

  def del(config, %{"ID" => id}) do
    c = Exconsul.Helper.client(config)
    res = put(c, "/agent/service/deregister/#{id}", "") 
    {res, c}
  end

  def maint(config, service) do
    c = Exconsul.Helper.client(config)
    res = put(c, "/agent/service/maintenance/#{service["ID"]}", "") 
    {res, c}
  end

end
