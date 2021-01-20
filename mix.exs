defmodule MyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_app,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [
        my_app: [
          steps: [:assemble, :tar],
          include_executables_for: [:unix],
          include_erts: true,
          applications: [runtime_tools: :permanent],
          path: "releases/artifacts"
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {MyApp.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.6"},
      # {:phoenix, github: "dbernheisel/phoenix", ref: "9dab39f7de0a517a44e35d3756c47a1a45037960", override: true}, # module key
      # {:phoenix, github: "dbernheisel/phoenix", ref: "0f2f3ee80b8500f2da84bdec5c5541cbe852eb5b", override: true}, # exports set with esm wrapper

      {:phoenix_live_view, "~> 0.15"},
      # {:phoenix_live_view, github: "dbernheisel/phoenix_live_view", ref: "757d1676b8cbbe34566781285f14e115412749b6", override: true}, # module key
      # {:phoenix_live_view, github: "dbernheisel/phoenix_live_view", ref: "602e1ffe31ad9d5f6c1b2bd3e4048f9c7e6af61a", override: true}, # export sset with esm wrapper

      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:floki, ">= 0.27.0", only: :test},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"],
      test: ["test"]
    ]
  end
end
