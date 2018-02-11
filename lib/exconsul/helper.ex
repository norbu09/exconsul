defmodule Exconsul.Helper do

  use Tesla
  
  def client(config) do
    case config[:client] do
      nil ->
        Tesla.build_client [
          {Tesla.Middleware.ParseConsulResponse, []},
          {Tesla.Middleware.BaseUrl, "#{config.url}/v1/"},
          {Tesla.Middleware.JSON, decode_content_types: ["application/json"]},
          headers(config)
        ]
     client -> client
    end
  end

  defp headers(config) do
    case config[:token] do
      nil   -> {Tesla.Middleware.Headers, %{"User-Agent" => "exConsul"}}
      token -> {Tesla.Middleware.Headers, %{"User-Agent" => "exConsul", "X-Consul-Token" => token}}
    end
  end

end
