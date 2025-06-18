# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

This is a Rails 8.0.2 application called "crazysoccer" built with modern Rails conventions:
- **Database**: PostgreSQL with multiple databases for production (main, cache, queue, cable)
- **Asset Pipeline**: Propshaft (modern Rails asset pipeline)
- **Frontend**: Hotwire (Turbo + Stimulus), Importmap for JavaScript
- **Background Jobs**: Solid Queue (database-backed)
- **Caching**: Solid Cache (database-backed)  
- **WebSockets**: Solid Cable (database-backed)
- **Deployment**: Kamal with Docker containerization

## Development Commands

### Basic Rails Commands
- `bin/rails server` - Start development server
- `bin/rails console` - Rails console
- `bin/rails generate` - Rails generators
- `bin/rails db:create` - Create databases
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:seed` - Seed database

### Code Quality & Security
- `bin/rubocop` - Ruby linting (Omakase style guide)
- `bin/brakeman` - Security vulnerability scanning

### Background Jobs
- `bin/jobs` - Run Solid Queue job worker

### Asset Management
- `bin/importmap` - Manage JavaScript dependencies via importmap

## Database Configuration

The application uses PostgreSQL with separate databases in production:
- **Main**: `crazysoccer_production` 
- **Cache**: `crazysoccer_production_cache`
- **Queue**: `crazysoccer_production_queue` 
- **Cable**: `crazysoccer_production_cable`

Development uses `crazysoccer_development` and test uses `crazysoccer_test`.

## Architecture Notes

### Modern Rails Stack (Rails 8)
- Uses Solid Queue for background jobs instead of Redis/Sidekiq
- Uses Solid Cache for caching instead of Redis
- Uses Solid Cable for WebSockets instead of Redis
- All backed by PostgreSQL for simplicity

### Frontend Architecture
- **Hotwire**: Uses Turbo for SPA-like navigation and Stimulus for JavaScript sprinkles
- **No Node.js**: Uses Importmap for JavaScript dependencies, avoiding npm/webpack
- **Propshaft**: Modern asset pipeline, simpler than Sprockets

### Deployment
- **Kamal**: Modern Rails deployment tool
- **Docker**: Containerized with multi-stage build
- **Thruster**: HTTP/2 proxy and asset acceleration
- **Let's Encrypt**: SSL auto-certification configured

## Key Files & Directories

- `app/models/application_record.rb` - Base model class
- `app/controllers/application_controller.rb` - Base controller class  
- `config/routes.rb` - URL routing (currently minimal with health check)
- `config/deploy.yml` - Kamal deployment configuration
- `Dockerfile` - Production container build configuration
- `/bin/*` - Rails binstubs and custom scripts

## Testing

No test framework is currently configured (Rails test unit is disabled in application.rb). When adding tests, common Rails patterns include:
- RSpec with `rspec-rails` gem
- Minitest (Rails default)
- System/integration tests with Capybara

## Development Notes

- Ruby version: 3.4.3
- The application currently has minimal routes and no custom models/controllers
- Health check available at `/up` endpoint
- PWA support is commented out but available
- Security scanning with Brakeman is configured