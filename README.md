# Weather Tweet API
This Rails API provides weather information for a specified city and generates a formatted tweet with the weather forecast. The application uses an external weather SDK to retrieve temperature and weather conditions for the upcoming days.

# Prerequisites
Make sure you have the following installed on your system:
- Ruby 3.1.2
- Bundler
- Rails 7.1.3

# Setup
## Clone the repository:
```bash
$ git clone https://github.com/your-username/weather_tweet_api.git
$ cd weather_tweet_api
```

## Install dependencies:
```bash
$ bundle install
```

# Usage (without Docker)
## Set up environment variables:
Create a `.env` file at the root of the project with the following content:

```
API_KEY=your_api_key
CONSUMER_KEY=your_twitter_consumer_key
CONSUMER_SECRET=your_twitter_consumer_secret
ACCESS_TOKEN=your_twitter_access_token
TOKEN_SECRET=your_twitter_token_secret
```

## Run the Rails server:
```bash
$ RAILS_ENV=development rails s
```

# Usage (with Docker)
Build the Docker image:

```bash
$ docker-compose up --build
```

# Replace the environment variables
Don't forget to create a `.env` as mentioned above.

# Make requests to the API:
```bash
$ curl -X POST -H "Content-Type: application/json" -d '{"city_id": "your_city_id"}' http://localhost:3000/twitter/tweets
```

Replace `your_city_id` with the actual city ID you want to get weather information for.


# Running Unit Tests
To run unit tests, execute the following command:

```bash
$ rspec
......

Finished in 1.94 seconds (files took 4.99 seconds to load)
6 examples, 0 failures
```

# Additional Notes
1. After successful API requests, you can check your Twitter account for the published tweet with weather information.
   ![image](https://github.com/fabiosoaresv/weather_tweet_api/assets/31450742/cfeee706-bd0a-401c-bd18-d1e526b3215f)

3. You can read all scope of challenge in `challenge.pdf` file.
