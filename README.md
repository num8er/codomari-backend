# CodomariBackend

Set of backend apps for Codomari project.

Based on monorepo (umbrella) pattern:

1. apps located in `apps` folder
2. shared libs are in `lib`.

---

To run `apps/APP_NAME` need to execute:

```sh
cd apps/APP_NAME
mix run --no-halt
```

Currently we have `codomari_api` which can be run as:

```sh
cd apps/codomari_api
mix run --no-halt
```
