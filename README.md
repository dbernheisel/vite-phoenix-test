# MyApp

Generated with `mix phx.new my_app --live --no-ecto`

This tries to get an integration between Vite and Phoenix.

Dev environment seems to be working, but prod deploys need some help still.

# Building for prod

To build for prod, run `bin/build` and `bin/start-prod`. The server will 
run on port [`localhost:4000`](http://localhost:4000). You'll need docker 
installed to build the image. This was tested on linux.

# Running for dev

To start your Phoenix server:

  * Make sure Elixir and Erlang are installed. `brew install elixir` should be fine.
  * Make sure node v14 is installed.
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install` inside the `assets` directory.
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
