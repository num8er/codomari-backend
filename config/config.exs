# This configuration file is loaded before any dependency and
# is restricted to this project.

import Config

config :codomari_api,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :codomari_api, CodomariApi.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [
      html: CodomariApi.Renderers.ErrorHTML,
      json: CodomariApi.Renderers.ErrorJSON
    ],
    layout: false
  ]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :codomari_api, CodomariApi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

# DB
import_config "databases/couchdb.exs"

import_config "#{config_env()}.exs"
