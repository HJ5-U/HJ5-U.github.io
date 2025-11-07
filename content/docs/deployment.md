---
title: "Deployment"
weight: 3
---

# Deployment Guide

This guide covers deploying the Student API using Docker.

## Quick Start with Docker

The Student_API comes with a complete Docker setup including an automated setup script.

### Prerequisites

- Docker installed
- Docker Compose installed
- Git (to clone the repository)

### Automated Setup Script

The easiest way to deploy is using the provided `setup.sh` script:

```bash
cd /path/to/project2/code
./setup.sh
```

**Select Option 1: Initial Setup**

The script automatically:
- ✅ Creates `.env` file from `.env.example`
- ✅ Configures database connection for Docker
- ✅ Builds Docker containers
- ✅ Starts all services (app, MySQL, phpMyAdmin)
- ✅ Generates application key
- ✅ Sets proper permissions
- ✅ Runs database migrations
- ✅ Seeds database with sample data

**Access Points:**
- Application: http://localhost:8080
- phpMyAdmin: http://localhost:8081

### Manual Docker Setup

If you prefer manual setup or need custom configuration:

1. **Navigate to Student_API Directory**
```bash
cd /path/to/project2/code/Student_API
```

2. **Create Environment File**
```bash
cp .env.example .env
```

Edit `.env` for your environment:
```env
APP_NAME="Student API"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8080

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=student_api
DB_USERNAME=student_user
DB_PASSWORD=P@ssword123
```

3. **Build and Start Containers**
```bash
docker-compose build
docker-compose up -d
```

4. **Initialize Application**
```bash
# Wait for MySQL to be ready (about 10 seconds)
sleep 10

# Generate application key
docker-compose exec app php artisan key:generate

# Set permissions
docker-compose exec app chown -R www-data:www-data /var/www/html/storage
docker-compose exec app chown -R www-data:www-data /var/www/html/bootstrap/cache

# Run migrations
docker-compose exec app php artisan migrate --force

# Seed database
docker-compose exec app php artisan db:seed --force
```

---

## Docker Architecture

The Student_API uses a three-container setup:

### Container Details

**1. Application Container (`project2_laravel_app`)**
- **Base Image:** PHP 8.3 with Apache
- **Port:** 8080 → 80
- **Includes:** PHP extensions, Composer, Node.js/NPM
- **Web Root:** `/var/www/html/public`

**2. MySQL Container (`project2_mysql`)**
- **Image:** MySQL 8.0
- **Port:** 3307 → 3306
- **Database:** student_api
- **Credentials:**
  - User: student_user
  - Password: P@ssword123
  - Root Password: rootpassword

**3. phpMyAdmin Container (`project2_phpmyadmin`)**
- **Image:** phpMyAdmin
- **Port:** 8081 → 80
- **Access:** http://localhost:8081

### Network Configuration

All containers run on a bridge network named `laravel`:
- Containers can communicate using service names (e.g., `mysql`, `app`)
- Database host in Laravel config is set to `mysql`
- Isolated from host network for security

---

## Managing Containers

Use the `setup.sh` script for easy container management:

### Start Containers
```bash
./setup.sh
# Select option 2
```

### Stop Containers
```bash
./setup.sh
# Select option 3
```

### Restart Containers
```bash
./setup.sh
# Select option 4
```

### View Logs
```bash
./setup.sh
# Select option 5
```

Or manually:
```bash
cd /path/to/Student_API
docker-compose logs -f
docker-compose logs -f app    # App logs only
docker-compose logs -f mysql  # MySQL logs only
```

### Access Application Shell
```bash
./setup.sh
# Select option 8
```

Or manually:
```bash
docker-compose exec app bash
```

### Run Migrations
```bash
./setup.sh
# Select option 6
```

### Seed Database
```bash
./setup.sh
# Select option 7
```

### Clear Laravel Cache
```bash
./setup.sh
# Select option 9
```

---

## Production Deployment

For production environments, modify the configuration:

### 1. Update Environment Variables

Edit `.env`:
```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com

DB_PASSWORD=<use-strong-password>
```

### 2. Modify docker-compose.yml

Change restart policy and ports:
```yaml
services:
  app:
    restart: always  # Changed from unless-stopped
    ports:
      - "80:80"      # Changed from 8080:80
      - "443:443"    # Add HTTPS if needed
    environment:
      - APP_ENV=production
      - APP_DEBUG=false
```

### 3. Optimize for Production
```bash
docker-compose exec app php artisan config:cache
docker-compose exec app php artisan route:cache
docker-compose exec app php artisan view:cache
```

### 4. Remove phpMyAdmin (Optional)

For production, comment out or remove phpMyAdmin from `docker-compose.yml`:
```yaml
# phpmyadmin:
#   image: phpmyadmin/phpmyadmin
#   ...
```

---

## SSL/HTTPS Setup (Production)

### Using Let's Encrypt with Certbot

1. **Add Certbot to Dockerfile**

Add after the PHP extensions:
```dockerfile
RUN apt-get update && apt-get install -y certbot python3-certbot-apache
```

2. **Rebuild Container**
```bash
docker-compose build --no-cache
docker-compose up -d
```

3. **Obtain SSL Certificate**
```bash
docker-compose exec app certbot --apache -d your-domain.com -d www.your-domain.com
```

4. **Auto-renewal Setup**

Add certificate volume to `docker-compose.yml`:
```yaml
volumes:
  - ./:/var/www/html
  - ./storage:/var/www/html/storage
  - ./bootstrap/cache:/var/www/html/bootstrap/cache
  - /etc/letsencrypt:/etc/letsencrypt
```

Test renewal:
```bash
docker-compose exec app certbot renew --dry-run
```

---

## Database Management

### Backup Database

```bash
# Create backup
docker-compose exec mysql mysqldump -u student_user -pP@ssword123 student_api > backup_$(date +%Y%m%d).sql

# Or using root
docker-compose exec mysql mysqldump -u root -prootpassword student_api > backup_$(date +%Y%m%d).sql
```

### Restore Database

```bash
# Stop application
docker-compose stop app

# Restore from backup
docker-compose exec -T mysql mysql -u student_user -pP@ssword123 student_api < backup_20251106.sql

# Start application
docker-compose start app
```

### Access MySQL CLI

```bash
# Via Docker
docker-compose exec mysql mysql -u student_user -pP@ssword123 student_api

# Or via phpMyAdmin
# Open http://localhost:8081
```

### Reset Database

```bash
# Access application shell
docker-compose exec app bash

# Inside container:
php artisan migrate:fresh --seed
```

---

## Troubleshooting

### Permission Issues

If you encounter permission errors:

```bash
# Set proper ownership
docker-compose exec app chown -R www-data:www-data /var/www/html/storage
docker-compose exec app chown -R www-data:www-data /var/www/html/bootstrap/cache

# Set proper permissions
docker-compose exec app chmod -R 775 /var/www/html/storage
docker-compose exec app chmod -R 775 /var/www/html/bootstrap/cache
```

### Database Connection Issues

**Check MySQL is running:**
```bash
docker-compose ps
```

**Check database connection:**
```bash
docker-compose exec app php artisan tinker
>>> DB::connection()->getPdo();
```

**View MySQL logs:**
```bash
docker-compose logs mysql
```

### Container Won't Start

**Check logs:**
```bash
docker-compose logs app
```

**Rebuild containers:**
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Application Errors

**Clear all caches:**
```bash
docker-compose exec app php artisan optimize:clear
```

**View Laravel logs:**
```bash
docker-compose exec app tail -f /var/www/html/storage/logs/laravel.log
```

**View Apache logs:**
```bash
docker-compose exec app tail -f /var/log/apache2/error.log
```

### Port Conflicts

If ports 8080, 8081, or 3307 are already in use, modify `docker-compose.yml`:

```yaml
services:
  app:
    ports:
      - "9080:80"  # Changed from 8080
  
  mysql:
    ports:
      - "3308:3306"  # Changed from 3307
  
  phpmyadmin:
    ports:
      - "9081:80"  # Changed from 8081
```

---

## Monitoring & Maintenance

### View Container Status

```bash
docker-compose ps
```

### View Resource Usage

```bash
docker stats
```

### Restart Specific Container

```bash
docker-compose restart app
docker-compose restart mysql
```

### Stop and Remove All Containers

```bash
docker-compose down
```

### Remove Volumes (⚠️ Deletes Database)

```bash
docker-compose down -v
```

### Update Application Code

```bash
# Pull latest code
git pull origin main

# Rebuild and restart
docker-compose build
docker-compose up -d
