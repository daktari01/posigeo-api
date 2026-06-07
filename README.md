# Posigeo API

A RESTful Ruby on Rails API that provides geolocation data based on IP address or URL using the [ipstack](https://ipstack.com/) service. Results are cached in PostgreSQL.

## Features

- Lookup geolocation by IP or URL (public endpoint)
- Create/refresh and delete geolocation records (protected)
- Modular geolocation provider architecture
- JWT Authentication

## Tech Stack

- Ruby 3.3.1
- Ruby on Rails 8
- PostgreSQL
- JWT
- Docker

---

## Prerequisites

- Ruby 3.3.1
- PostgreSQL
- Docker (for containerized setup)
- An [ipstack API key](https://ipstack.com/)

---

## Environment Variables

Copy the example and fill in your keys:

```bash
cp .env.example .env