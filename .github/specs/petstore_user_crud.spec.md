# Spec: Petstore User CRUD

status: APPROVED

## Summary
This spec covers the full lifecycle of a Petstore user through the public Swagger Petstore API. It validates creation, retrieval, update, and deletion of the same user record while checking status codes, response payload consistency, and persistence across requests.

## Domain
users

## Scope
**In scope:**
- Create a user with valid payload data (`POST /user`)
- Retrieve an existing user by username (`GET /user/{username}`)
- Update an existing user by username (`PUT /user/{username}`)
- Delete an existing user by username (`DELETE /user/{username}`)
- Validate that updates persist across follow-up requests
- Validate the not-found response after deletion

**Out of scope:**
- Authentication flows beyond the optional `api_key` header
- Bulk user operations
- Database-level verification
- Non-user Petstore resources

---

## Scenarios

### Scenario 1: Create user with valid payload
| Field | Value |
|-------|-------|
| Method | `POST` |
| Endpoint | `/user` |
| Preconditions | User does not already exist with username `user_test_123` |
| Input | Data file: `data/users/create-user-request.json` |
| Expected Status | `200` |
| Response Assertions | `response.code == 200`, `response.type == 'unknown'`, `response.message == '1001'` |
| Tags | `@smoke @users` |

### Scenario 2: Get created user by username
| Field | Value |
|-------|-------|
| Method | `GET` |
| Endpoint | `/user/{username}` |
| Preconditions | User `user_test_123` exists |
| Input | Path param: `username=user_test_123` |
| Expected Status | `200` |
| Response Assertions | `response.username == 'user_test_123'`, `response.firstName == 'Santiago'`, `response.lastName == 'Test'`, `response.email == 'test@mail.com'` |
| Tags | `@smoke @users` |

### Scenario 3: Update existing user
| Field | Value |
|-------|-------|
| Method | `PUT` |
| Endpoint | `/user/{username}` |
| Preconditions | User `user_test_123` exists |
| Input | Data file: `data/users/update-user-request.json` |
| Expected Status | `200` |
| Response Assertions | `response.code == 200`, `response.type == 'unknown'`, `response.message == '1001'` |
| Tags | `@regression @users` |

### Scenario 4: Get updated user by username
| Field | Value |
|-------|-------|
| Method | `GET` |
| Endpoint | `/user/{username}` |
| Preconditions | User `user_test_123` was updated successfully |
| Input | Path param: `username=user_test_123` |
| Expected Status | `200` |
| Response Assertions | `response.firstName == 'UpdatedName'`, `response.email == 'updated@mail.com'`, `response.username == 'user_test_123'` |
| Tags | `@smoke @users` |

### Scenario 5: Delete existing user
| Field | Value |
|-------|-------|
| Method | `DELETE` |
| Endpoint | `/user/{username}` |
| Preconditions | User `user_test_123` exists |
| Input | Path param: `username=user_test_123` |
| Expected Status | `200` |
| Response Assertions | `response.code == 200`, `response.type == 'unknown'`, `response.message == 'user_test_123'` |
| Tags | `@regression @users` |

---

## Data Requirements
- `data/users/create-user-request.json` — Valid user payload for the create scenario
- `data/users/update-user-request.json` — Valid user payload for the update scenario

## Schema Requirements
- `schemas/users/user-response.schema.json` — Create/update/delete API response with `code`, `type`, and `message`
- `schemas/users/user-detail-response.schema.json` — User detail response for GET requests

## Helper Requirements
- No auth helper is required for the `/user` endpoints
- Optional `api_key: special-key` header may be supported if the implementation needs to exercise it

## Risks
- The public Petstore API may not persist changes consistently across requests
- Duplicate-user behavior may vary depending on API implementation
- Invalid email validation may not be enforced server-side, so response assertions must account for accepted payloads
- The API may return `200` with an error-shaped payload for not-found cases, so tests must validate both status and body

## Approval Criteria
- [ ] All happy path scenarios are defined
- [ ] Data requirements are documented
- [ ] Schema requirements are documented
- [ ] Domain is identified