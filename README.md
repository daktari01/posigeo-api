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
```
___

## Local Setup
1. Clone the application
```
git clone git@github.com:daktari01/posigeo-api.git
cd posigeo_api
```

2. Install the dependencies
```
bundle install
```

3. Setup the database
```
rails db:create
rails db:migrate
```

4. Start the application
```
rails server
```
___

## Docker Setup
1. Pull the docker image
```
docker pull daktari01/posigeo-api:latest
```

2. Run the container
```
docker compose up -d
```

3. Access the application
```
http://localhost:3000
```

---

## Testing the API
1. Get the Auth token
```
POST http://localhost:3000/api/v1/login
{
  "email": "daktari@posigeo.com",
  "password": "password"
}
```

2. Public endpoint
- Lookup a geolocation by IP or URL
```
GET http://localhost:3000/api/v1/geolocations/lookup?ip=8.8.8.8
GET http://localhost:3000/api/v1/geolocations/lookup?url=google.com
```

3. Protected endpoint
- Create a geolocation
```
POST http://localhost:3000/api/v1/geolocations
```

- Delete a geolocation
```
DELETE http://localhost:3000/api/v1/geolocations/1
```

---

## Run tests
```
rspec
```

## License
Copyright 2026 Posigeo API [daktari01](https://github.com/daktari01)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

