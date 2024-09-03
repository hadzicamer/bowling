# Bowling Game API

This project is a simple API for managing a bowling game. It allows you to create games, view game details, roll the ball, and calculate the score of a game.

## Endpoints

### Create a Game

**Endpoint:** `POST /api/v1/games`

**Description:** Creates a new game.

**Response:**
- **Status:** `201 Created`
- **Body:** JSON representation of the created game.

### Show Game Details

**Endpoint:** `GET /api/v1/games/:id`

**Description:** Retrieves the details of a specific game, including its frames.

**Parameters:**
- `id` (path parameter): The ID of the game to retrieve.

**Response:**
- **Status:** `200 OK`
- **Body:** JSON representation of the game, including its frames.

### Calculate Game Score

**Endpoint:** `GET /api/v1/games/:id/score`

**Description:** Calculates and retrieves the score of a specific game.

**Parameters:**
- `id` (path parameter): The ID of the game to calculate the score for.

**Response:**
- **Status:** `200 OK`
- **Body:** JSON representation of the game's score.

### Roll the Ball

**Endpoint:** `POST /api/v1/games/:id/rolls`

**Description:** Records a roll in a specific game.

**Parameters:**
- `id` (path parameter): The ID of the game to record the roll for.
- `pins` (body parameter): The number of pins knocked down in the roll.

**Response:**
- **Status:** `200 OK`
- **Body:** JSON representation of the updated game state.

## Installation

1. Clone the repository

2. Install dependencies:
   ```sh
   bundle install
   
3. Create database:
   ```sh
   rails db:create
   rails db:migrate
   
4. Run server:
   ```sh
   rails server   
   
