defmodule MyAppWeb.LayoutView do
  use MyAppWeb, :view

  if Mix.env() == :prod do
    @path "/"
    @asset_manifest :my_app
                    |> Application.get_env(MyAppWeb.Endpoint)
                    |> Keyword.get(:asset_manifest)
                    |> File.read!()
                    |> Jason.decode!()

    def vite_manifest(), do: @asset_manifest

    def vite_path(conn, file) when is_binary(file) do
      Routes.static_path(conn, @path <> @asset_manifest[file]["file"])
    end
  else
    def vite_manifest(), do: %{}

    def vite_path(conn, file) when is_binary(file) do
      Routes.static_path(conn, file)
    end
  end
end
