---
title: "Getting Started"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
# bookHref: ''
# bookIcon: ''
---


# Getting Started with Student API

This guide will help you set up and run the Student API locally using Docker.

## Prerequisites

Before you begin, ensure you have:
- Docker installed
- Docker Compose installed
- Git (to clone the repository)

## Installation

### 1. Clone the Repository

```bash
cd /home/hj5u/projects/Project2/project2/code
```

### 2. Run the Setup Script

The project includes an automated setup script that handles everything:

```bash
cd /home/hj5u/projects/Project2/project2/code
./setup.sh
```

**Select Option 1: Initial Setup**

The script will:
- ✅ Create and configure `.env` file
- ✅ Build Docker containers
- ✅ Start all services (app, MySQL, phpMyAdmin)
- ✅ Generate application key
- ✅ Run database migrations
- ✅ Seed the database with sample data

### 3. Access the Application

Once setup is complete, you can access:

- **Application**: http://localhost:8080
- **phpMyAdmin**: http://localhost:8081
  - Username: `student_user`
  - Password: `P@ssword123`

## Default Credentials

The database is seeded with a default admin user:

- **email**: `admin@example.com`
- **name**: `Admin`
- **password**: `Admin@123!Secure`
- **role**: `admin`

And a regular user:
- **email**: `test@example.com`
- **name**: `Test`
- **password**: `password123`
- **role**: `user`

## Next Steps

- Explore the API endpoints (see API Reference)
- Learn about deployment options

## Common Commands

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

### View Logs
```bash
./setup.sh
# Select option 5
```

### Access Application Shell
```bash
./setup.sh
# Select option 8
```
