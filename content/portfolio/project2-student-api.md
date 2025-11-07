---
title: "Project 2 - Student API"
weight: 1
---

# Project 2 - Student API

**Course:** ASE-230 Server-Side Programming  
**Date:** November 7,2025 
**Repository:** [GitHub - ASE-230](https://github.com/HJ5-U/ASE-230)  
**Live Demo:** [API Documentation](https://hj5-u.github.io/)

## Overview

A comprehensive Laravel 12 RESTful API system for managing student information with role-based access control and Sanctum authentication. The system simulates a secure university database accessible by faculty and administrators.

## Key Features

✅ **Complete CRUD Operations** - Create, Read, Update, Delete student records  
✅ **Token-Based Authentication** - Secure API access using Laravel Sanctum  
✅ **Role-Based Access Control** - Admin and user permission levels  
✅ **Advanced Filtering** - Search by name, course, major, and academic year  
✅ **Docker Containerization** - Fully automated setup with Docker Compose  
✅ **Comprehensive Documentation** - Hugo-based documentation site with GitHub Pages

## Technical Implementation

### Backend Architecture
- **Framework:** Laravel 12 (PHP 8.3)
- **Authentication:** Laravel Sanctum with username-based login
- **Database:** MySQL 8.0
- **ORM:** Eloquent for database interactions
- **API Design:** RESTful principles with versioned endpoints (`/api/v1/`)

### Database Schema

**Users Table:**
- ID, Name, Email, Password (hashed)
- Role (admin/user)
- Timestamps

**Students Table:**
- ID, Name, Course, Major, Year
- Timestamps

### API Endpoints

#### Authentication
```
POST /api/v1/register - Register new user
POST /api/v1/login    - Login and receive token
POST /api/v1/logout   - Revoke current token
```

#### Student Management
```
GET    /api/v1/students      - List all students
GET    /api/v1/students/{id} - Get specific student
POST   /api/v1/students      - Create new student
PUT    /api/v1/students/{id} - Update student
DELETE /api/v1/students/{id} - Delete student
```

#### Filtering
```
GET /api/v1/students/by-name/{name}     - Filter by name
GET /api/v1/students/by-course/{course} - Filter by course
GET /api/v1/students/by-major/{major}   - Filter by major
GET /api/v1/students/by-year/{year}     - Filter by year
```

#### Admin Only
```
DELETE /api/v1/students/delete-all - Delete all students
```

## DevOps & Deployment

### Docker Setup
- **Services:** PHP-FPM, MySQL, phpMyAdmin
- **Ports:** 8080 (API), 8081 (phpMyAdmin), 3307 (MySQL)
- **Automation:** One-command setup with `setup.sh`

### CI/CD Pipeline
- GitHub Actions workflow for automatic deployment
- Hugo site builds and deploys to GitHub Pages on push
- Zero-downtime deployments

### Testing Scripts
Custom bash scripts for API testing:
- `setup.sh` - Automated Docker environment setup
- `run.sh` - Start Docker containers
- `command.sh` - API endpoint testing

## Challenges & Solutions

### Challenge 1: Sanctum Configuration
**Problem:** Initial setup had Sanctum package missing  
**Solution:** Installed Laravel Sanctum, configured `HasApiTokens` trait in User model, and published Sanctum migrations

### Challenge 2: Docker Port Conflicts
**Problem:** MySQL port 3306 already in use on host system  
**Solution:** Mapped MySQL to port 3307 to avoid conflicts with host services

### Challenge 3: Image Paths in Hugo
**Problem:** Images not displaying on deployed GitHub Pages site  
**Solution:** Moved images from content folder to `static/images/` and updated paths to `/images/`

## Screenshots

### Docker Setup
![Setup Script](../../images/setup.sh.png)

### Running Application
![Run Script](../../images/run.sh.png)

### API Pages
![Page 1](../../images/page1.png)
![Page 2](../../images/page2.png)
![Page 3](../../images/page3.png)

## Learning Outcomes

- Mastered Laravel framework and MVC architecture
- Implemented secure authentication with Sanctum tokens
- Gained experience with Docker containerization
- Learned RESTful API design principles
- Practiced Git version control and GitHub workflows
- Deployed production-ready applications with CI/CD

## Future Enhancements

- Email verification for user registration
- Rate limiting for API endpoints
- Unit and integration testing with PHPUnit
- API response caching with Redis
- GraphQL endpoint implementation
- Real-time notifications with Laravel Echo

---

**Technologies Used:** Laravel 12, PHP 8.3, MySQL 8.0, Docker, Sanctum, Hugo, GitHub Actions
