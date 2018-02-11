defmodule Tesla.Middleware.ParseResponse do

  require Logger

  def call(env, next, _opts) do
    env
    |> Tesla.run(next)
    |> parse()
  end

  # parser types
  defp parse(res) do
    Logger.debug("RAW: #{inspect res}")
    case res.status do
      200 -> parse_body(res.body)
      _ -> res
    end
  end

  defp parse_body("") do
    :ok
  end
  defp parse_body(body) do
    body
  end
end
