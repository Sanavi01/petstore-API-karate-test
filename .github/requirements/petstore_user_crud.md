# Requirement: User Management API - Petstore

## Objective
Validar el ciclo de vida completo de un usuario (crear, consultar, actualizar y eliminar), verificando la consistencia de los datos mediante payloads y responses.

---

## Domain
users

---

## API Base URL
https://petstore.swagger.io/v2

---

## Endpoints to Test

- `POST /user` — Crear usuario  
- `GET /user/{username}` — Consultar usuario  
- `PUT /user/{username}` — Actualizar usuario  
- `DELETE /user/{username}` — Eliminar usuario  

---

## Authentication
No requerida para `/user`

(Opcional)
- Header: `api_key: special-key`

---

## Expected Behavior (Happy Path)

- Cuando se crea un usuario con datos válidos → se retorna 200
- Cuando se consulta el usuario creado → se obtiene la información correcta
- Cuando se actualiza el usuario → los cambios persisten
- Cuando se consulta el usuario actualizado → refleja los nuevos datos
- Cuando se elimina el usuario → se confirma la eliminación
- Cuando se consulta el usuario eliminado → retorna 404

---

## Validation Rules

- Status code:
  - 200 → operaciones exitosas
  - 404 → recurso no encontrado

- Response debe contener:
  - `username`
  - `firstName`
  - `lastName`
  - `email`

- El campo `email` debe tener formato válido

- Validar persistencia de datos entre requests

---

## Test Data Requirements

- Usuario inicial:
  - id: 1001
  - username: user_test_123
  - firstName: Santiago
  - lastName: Test
  - email: test@mail.com

- Usuario actualizado:
  - firstName: UpdatedName
  - email: updated@mail.com

---

# Scenarios

---

## Scenario 1: Crear usuario

### Request
**POST /user**

### Payload
`````````json
{
  "id": 1001,
  "username": "user_test_123",
  "firstName": "Santiago",
  "lastName": "Test",
  "email": "test@mail.com",
  "password": "123456",
  "phone": "123456789",
  "userStatus": 1
}
` ``

### Expected Response
````````json
{
  "code": 200,
  "type": "unknown",
  "message": "1001"
}
` ``

### Validations
- Status code = 200
- `message` = "1001"

---

## Scenario 2: Buscar usuario creado

### Request
**GET /user/user_test_123**

### Expected Response
```````json
{
  "id": 1001,
  "username": "user_test_123",
  "firstName": "Santiago",
  "lastName": "Test",
  "email": "test@mail.com",
  "password": "123456",
  "phone": "123456789",
  "userStatus": 1
}
` ``

### Validations
- Status code = 200
- `username` = "user_test_123"
- `email` = "test@mail.com"

---

## Scenario 3: Actualizar usuario

### Request
**PUT /user/user_test_123**

### Payload
``````json
{
  "id": 1001,
  "username": "user_test_123",
  "firstName": "UpdatedName",
  "lastName": "Test",
  "email": "updated@mail.com",
  "password": "123456",
  "phone": "123456789",
  "userStatus": 1
}
` ``

### Expected Response
`````json
{
  "code": 200,
  "type": "unknown",
  "message": "1001"
}
` ``

### Validations
- Status code = 200

---

## Scenario 4: Validar actualización

### Request
**GET /user/user_test_123**

### Validations
- Status code = 200
- `firstName` = "UpdatedName"
- `email` = "updated@mail.com"

---

## Scenario 5: Eliminar usuario

### Request
**DELETE /user/user_test_123**

### Expected Response
````json
{
  "code": 200,
  "type": "unknown",
  "message": "user_test_123"
}
` ``

### Validations
- Status code = 200

---

## Scenario 6: Validar eliminación

### Request
**GET /user/user_test_123**

### Expected Response
```json
{
  "code": 1,
  "type": "error",
  "message": "User not found"
}
` ``

### Validations
- Status code = 404
- `message` = "User not found"

---

## Edge Cases & Negative Scenarios

- Crear usuario con username duplicado → validar comportamiento
- Crear usuario con campos faltantes → 400
- Email inválido → validar respuesta
- Buscar usuario inexistente → 404
- Actualizar usuario inexistente → 404
- Eliminar usuario inexistente → 404

---

## Notes

- API docs: https://petstore.swagger.io/
- No requiere autenticación para `/user`
- Puede no persistir datos permanentemente (API de prueba)
```

> **Nota:** Los bloques de código que terminan en ` `` ` deben quedar como ` ``` ` al pegarlo — aquí se muestran separados para que el bloque externo no los cierre prematuramente.