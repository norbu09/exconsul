defmodule Exconsul.MixProject do
  use Mix.Project

  def project do
    [
      app: :exconsul,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :tesla, :poison, :con_cache],
      included_applications: [:exactor, :mime],
      mod: {Exconsul.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla,  ">= 0.10.0"},
      {:poison, ">= 1.0.0"},
      {:con_cache, ">= 0.12.1"},
      # dev related
      {:credo, ">= 0.7.3", only: :dev, warn_missing: false},
      {:distillery, ">= 1.0.0", only: :dev, warn_missing: false}
    ]
  end
end
