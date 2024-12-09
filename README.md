# DjangoTemplate
Template for generic Django project


# Local Dev and compose Quickstart:

Initial project structure is made of the following components:

- Database (Postgres alpine)
- Backend (Django + DRF)
- Frontent (nginx)

`.env` file is loaded by Compose automatically.

For local development use ~~the force, luke~~ the command:

```bash
docker compose up
# or if you prefer to daemonize the stuff:
docker compose up -d
```

For production use:

```bash
docker compose -f compose.yml -f compose.prod.yml up -d
```

Web server is now available on http://localhost/. Feel free to change this via `ALLOWED_HOSTS` in `.env`