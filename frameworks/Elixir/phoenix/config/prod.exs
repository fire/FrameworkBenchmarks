use Mix.Config

config :hello, Hello.Endpoint,
  url: [host: "0.0.0.0"],
  http: [port: 8080, protocol_options: [max_keepalive: :infinity], backlog: 8096],
  cache_static_lookup: false,
  check_origin: false,
  debug_errors: false,
  code_reloader: false,
  server: true

config :hello, Hello.Repo,
  adapter: Ecto.Adapters.SnappyData,
  username: "app",
  password: "app",
  hostname: "192.168.0.23",
  port: 32254,
  pool_size: 20

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config:hello, Hello.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :logger, level: :error
