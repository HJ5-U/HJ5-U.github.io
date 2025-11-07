---
title: "API Reference"
weight: 2
---

# API Reference

Complete API documentation for the Student API endpoints.

## Base URL

```
http://localhost:8080/api/v1
```

## Authentication

All endpoints (except `/register` and `/login`) require Sanctum token authentication.

### Register New User

**Endpoint:** `POST /api/v1/register`

**Request Body:**
```json
{
  "name": "newuser",
  "email": "user@example.com",
  "password": "password1234"
}
```

**Response:**
```json
{
  "user": {
    "id": 3,
    "name": "newuser",
    "email": "user@example.com",
    "role": "user",
    "email_verified_at": "2025-11-06T12:00:00.000000Z",
    "created_at": "2025-11-06T12:00:00.000000Z",
    "updated_at": "2025-11-06T12:00:00.000000Z"
  }
}
```

### Login

**Endpoint:** `POST /api/v1/login`

**Headers:**
```
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "name": "Admin",
  "password": "Admin@123!Secure"
}
```

**Response:**
```json
{
  "token": "1|abc123def456...",
  "user": {
    "id": 1,
    "name": "Admin",
    "email": "admin@example.com",
    "role": "admin",
    "email_verified_at": "2025-11-06T10:30:00.000000Z",
    "created_at": "2025-11-06T10:30:00.000000Z",
    "updated_at": "2025-11-06T10:30:00.000000Z"
  }
}
```

**Note:** For web requests (non-API), the login redirects to the dashboard instead of returning JSON.

### Logout

**Endpoint:** `POST /api/v1/logout`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Response:**
```json
{
  "message": "Logged out successfully"
}
```

---

## Student Endpoints

All student endpoints require authentication. Include the token in the `Authorization` header.

### Get All Students

**Endpoint:** `GET /api/v1/students`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "course": "CSI123",
    "major": "Computer Science",
    "year": 1,
    "created_at": "2025-11-06T10:30:00.000000Z",
    "updated_at": "2025-11-06T10:30:00.000000Z"
  },
  {
    "id": 2,
    "name": "Jane Smith",
    "course": "MAT201",
    "major": "Mathematics",
    "year": 2,
    "created_at": "2025-11-06T10:30:00.000000Z",
    "updated_at": "2025-11-06T10:30:00.000000Z"
  }
]
```

### Get Single Student

**Endpoint:** `GET /api/v1/students/{id}`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/students/1" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "id": 1,
  "name": "John Doe",
  "course": "CSI123",
  "major": "Computer Science",
  "year": 1,
  "created_at": "2025-11-06T10:30:00.000000Z",
  "updated_at": "2025-11-06T10:30:00.000000Z"
}
```

### Create Student

**Endpoint:** `POST /api/v1/students`

**Headers:**
```
Authorization: Bearer {token}
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "name": "Bob Johnson",
  "course": "PSY204",
  "major": "Psychology",
  "year": 3
}
```

**Validation Rules:**
- `name` - required, string, max 255 characters
- `course` - required, string, max 255 characters
- `major` - required, string, max 255 characters
- `year` - required, integer, min 1, max 5

**Example:**
```bash
curl -X POST "http://localhost:8080/api/v1/students" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"name":"Bob Johnson","course":"PSY204","major":"Psychology","year":3}'
```

**Response:**
```json
{
  "id": 9,
  "name": "Bob Johnson",
  "course": "PSY204",
  "major": "Psychology",
  "year": 3,
  "created_at": "2025-11-06T12:00:00.000000Z",
  "updated_at": "2025-11-06T12:00:00.000000Z"
}
```

### Update Student

**Endpoint:** `PUT /api/v1/students/{id}`

**Headers:**
```
Authorization: Bearer {token}
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "name": "Alice Doe",
  "course": "CSI456",
  "major": "Computer Science",
  "year": 4
}
```

**Note:** All fields follow the same validation rules as creation. You can update individual fields or all fields at once.

**Example:**
```bash
curl -X PUT "http://localhost:8080/api/v1/students/1" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"name":"Alice Doe Updated","year":4}'
```

**Response:**
```json
{
  "id": 1,
  "name": "Alice Doe",
  "course": "CSI123",
  "major": "Computer Science",
  "year": 4,
  "created_at": "2025-11-06T10:30:00.000000Z",
  "updated_at": "2025-11-06T13:00:00.000000Z"
}
```

### Delete Student

**Endpoint:** `DELETE /api/v1/students/{id}`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Example:**
```bash
curl -X DELETE "http://localhost:8080/api/v1/students/2" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "message": "Student deleted successfully"
}
```

---

## Filtering Endpoints

Filter students by various attributes. All filtering endpoints require authentication.

### Filter by Name

**Endpoint:** `GET /api/v1/students/by-name/{name}`

Searches for students whose name contains the search term (case-insensitive, partial match).

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/students/by-name/John" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "course": "CSI123",
    "major": "Computer Science",
    "year": 1,
    "created_at": "2025-11-06T10:30:00.000000Z",
    "updated_at": "2025-11-06T10:30:00.000000Z"
  },
  {
    "id": 9,
    "name": "Bob Johnson",
    "course": "PSY204",
    "major": "Psychology",
    "year": 3,
    "created_at": "2025-11-06T12:00:00.000000Z",
    "updated_at": "2025-11-06T12:00:00.000000Z"
  }
]
```

### Filter by Course

**Endpoint:** `GET /api/v1/students/by-course/{course}`

Searches for students whose course contains the search term (case-insensitive, partial match).

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/students/by-course/CSI123" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

### Filter by Major

**Endpoint:** `GET /api/v1/students/by-major/{major}`

Searches for students whose major contains the search term (case-insensitive, partial match).

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/students/by-major/Computer" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

### Filter by Year

**Endpoint:** `GET /api/v1/students/by-year/{year}`

Returns students in a specific year (exact match).

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/students/by-year/1" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "course": "CSI123",
    "major": "Computer Science",
    "year": 1,
    "created_at": "2025-11-06T10:30:00.000000Z",
    "updated_at": "2025-11-06T10:30:00.000000Z"
  }
]
```

---

## User Profile Endpoints

### Get User Profile

**Endpoint:** `GET /api/v1/user`

Returns the authenticated user's profile information.

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Example:**
```bash
curl -X GET "http://localhost:8080/api/v1/user" \
  -H "Authorization: Bearer {token}" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "id": 1,
  "name": "Admin",
  "email": "admin@example.com",
  "role": "admin",
  "email_verified_at": "2025-11-06T10:30:00.000000Z",
  "created_at": "2025-11-06T10:30:00.000000Z",
  "updated_at": "2025-11-06T10:30:00.000000Z"
}
```

### Update User Profile

**Endpoint:** `PUT /api/v1/user/update`

Updates the authenticated user's profile.

**Headers:**
```
Authorization: Bearer {token}
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "name": "Updated Name",
  "email": "newemail@example.com"
}
```

---

## Admin-Only Endpoints

These endpoints require admin role privileges. The `admin` middleware enforces this restriction.

### Delete All Students

**Endpoint:** `DELETE /api/v1/students/delete-all`

**⚠️ WARNING:** This endpoint deletes ALL students from the database. Admin access required.

**Headers:**
```
Authorization: Bearer {admin-token}
Accept: application/json
```

**Example:**
```bash
curl -X DELETE "http://localhost:8080/api/v1/students/delete-all" \
  -H "Authorization: Bearer {admin-token}" \
  -H "Accept: application/json"
```

**Response:**
```json
{
  "message": "All students deleted successfully"
}
```

---

## Error Responses

### 401 Unauthorized
Returned when no valid token is provided or token is expired.

```json
{
  "message": "Unauthenticated."
}
```

### 403 Forbidden
Returned when user lacks required permissions (e.g., non-admin accessing admin routes).

```json
{
  "message": "This action is unauthorized."
}
```

### 404 Not Found
Returned when the requested student doesn't exist.

```json
{
  "message": "Student not found"
}
```

### 422 Validation Error
Returned when request data fails validation.

```json
{
  "message": "The given data was invalid.",
  "errors": {
    "name": ["The name field is required."],
    "year": ["The year must be between 1 and 5."]
  }
}
```

---

## Complete Testing Script

A comprehensive bash script for testing all endpoints is available at:

```bash
/home/hj5u/projects/Project2/project2/code/command.sh
```

**To run the script:**
```bash
cd /home/hj5u/projects/Project2/project2/code
chmod +x command.sh
./command.sh
```

The script demonstrates:
- ✅ Login with Sanctum token
- ✅ Token storage and management
- ✅ All CRUD operations on students
- ✅ All filtering endpoints
