# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :paywise_scheduler,
  ecto_repos: [PaywiseScheduler.Repo]


# Configures the endpoint
config :paywise_scheduler, PaywiseSchedulerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: PaywiseSchedulerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PaywiseScheduler.PubSub,
  live_view: [signing_salt: "hHD+f+ws"]

config :paywise_scheduler, Acme.Scheduler, 
  jobs: [
     custom_task: [
      schedule: "* * * * *",
      task: fn -> PaywiseScheduler.Process.get_scheduled_transfers() end
      # task: fn -> File.write("task.txt", "#{Timex.now}", [:append]) end
    ]
  ]
# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :paywise_scheduler, PaywiseScheduler.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
