import Config

config :codomari_backend, :couchdb,
  host: "127.0.0.1",
  port: 5984,
  username: "codomari",
  password: "codomari",
  database: "codomari"

config :codomari_backend, :couchdb_pool,
  name: {:local, :couchdb_pool},
  worker_module: CodomariBackend.Database.PoolWorker,
  size: 10,
  max_overflow: 5
