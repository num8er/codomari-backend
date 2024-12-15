import Config

config :codomari, :couchdb,
  host: "127.0.0.1",
  port: 5984,
  username: "codomari",
  password: "codomari",
  database: "codomari"

config :codomari_api, :couchdb_pool,
  name: {:local, :couchdb_pool},
  worker_module: Codomari.Database.PoolWorker,
  size: 10,
  max_overflow: 5
