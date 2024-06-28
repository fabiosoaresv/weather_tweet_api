# Weather Tweet API
This Rails API provides weather information for a specified city and generates a formatted tweet with the weather forecast. The application uses an external weather SDK to retrieve temperature and weather conditions for the upcoming days.

# Prerequisites
- Twitter Developer Account
- OpenWeatherMap API Key
- Ruby 3.1.2
- Bundler
- Rails 7.1.3

# Setup

#### Twitter Developer Account
1. Create a Twitter Developer Account at https://developer.twitter.com/en/apply-for-access
2. Go to User authentication settings and set it up as follows:
  - **App permissions**
    - Read, Write, and Direct Messages
  - **Type of App**
    - Web App, Automated App or Bot
3. Create a new Twitter App and generate the following keys:
   - Consumer Key
   - Consumer Secret
   - Access Token
   - Token Secret

#### OpenWeatherMap
1. Create an OpenWeatherMap account at https://home.openweathermap.org/users/sign_up
2. Generate an API key https://home.openweathermap.org/api_keys
3. Get the city ID for the city you want to get weather information for. You can find the city ID by searching for the city on the OpenWeatherMap website by going to https://openweathermap.org/find?q=city_name

## Clone the repository:
```bash
$ git clone https://github.com/your-username/weather_tweet_api.git
$ cd weather_tweet_api
```

## Install dependencies:
```bash
$ bundle install
```

## Set up environment variables:
Create a `.env` file at the root of the project with the following content:

```
API_KEY=your_openweathermap_api_key
CONSUMER_KEY=your_twitter_consumer_key
CONSUMER_SECRET=your_twitter_consumer_secret
ACCESS_TOKEN=your_twitter_access_token
TOKEN_SECRET=your_twitter_access_token_secret
```

# Usage 

## Replace the environment variables
Don't forget to create a `.env` file as mentioned above.

## Start the server

**Without Docker**:
```bash
$ RAILS_ENV=development rails s
```

**With Docker:**
```bash
$ docker-compose up --build
```

## Make requests to the API:
Open another terminal and execute the following:

```bash
$ make tweet cid=<your_city_id>
```

or without the `make` command:

```bash
$ curl -X POST -H "Content-Type: application/json" -d '{"city_id": "your_city_id"}' http://localhost:3000/twitter/tweets
```

Replace `your_city_id` with the actual city ID you want to get weather information for. Works both with `"` or without. Here's an example of each type of execution:

```shell
$ make tweet cid=2643743
```
```shell
$ curl -X POST -H "Content-Type: application/json" -d '{"city_id": "2643743"}' http://localhost:3000/twitter/tweets
```


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

2. You can read the entire scope of the challenge in the [`challenge.pdf`](challenge.pdf) file.
