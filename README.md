# Flix - a movies system

This is a project created for learning purposes, following the **Ruby on Rails** course by Pragmatic Studio. The project is built with Ruby on Rails and focuses on movies, reviews, favorites and users.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

### Prerequisites

- Ruby 3.2.3
- Rails 7.1.3.3

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/mende1/flix.git
   cd flix
   ```

2. Install the required gems:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:

   ```bash
   rails s
   ```

5. Visit http://localhost:3000 in your web browser.

## Usage

This project includes features for managing movies, reviews and favorites, based on users. You can create, read, update, and delete records for each entity. The app demonstrates basic CRUD operations and the use of Ruby on Rails for creating a modern, interactive web application.
