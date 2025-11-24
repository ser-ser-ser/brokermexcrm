# Brokermex CRM — Esquema de Base de Datos

Este repositorio contiene la estructura completa del backend del CRM inmobiliario **Brokermex V2**, basado en:

- Supabase (PostgreSQL)
- RLS (Row Level Security)
- Políticas de seguridad por usuario
- Tablas optimizadas para flujo inmobiliario industrial, comercial y residencial

## Archivos incluidos

### `schema.sql`
Contiene **toda la estructura de la base de datos**:
- Extensiones (`pgcrypto`, `uuid-ossp`)
- Tablas completas
- Tipos de datos (`uuid[]`, `text[]`)
- Llaves primarias y foráneas
- Constraints y checks

Es un archivo **autosuficiente** para restaurar la base completa en Supabase.

### `policies.sql`
Contiene **todas las Row Level Security Policies**, necesarias para garantizar que:
- Los brokers solo vean su información
- Las propiedades compartidas funcionen correctamente
- Oportunidades y pipeline sean privados
- Los clientes tengan dueño asignado
- Las integraciones sean seguras

### `ERD.svg`
Diagrama visual del modelo de datos.

## ¿Qué es un ERD?

Significa **Entity Relationship Diagram**  
En español: **Diagrama de Relaciones entre Entidades**.

Sirve para visualizar:
- Tablas
- Relaciones
- Llaves primarias
- Llaves foráneas
- Estructura general del sistema

Ideal para tu portafolio o documentación del proyecto.

## Dónde colocar estos archivos

Colócalos dentro de tu proyecto en la carpeta:

```
crm-inmobiliario-pro-v2/
│
├── database/
│   ├── schema.sql
│   ├── policies.sql
│   └── ERD.svg
│
└── frontend/
    └── (tu React + Supabase)
```

## Cómo usarlos

Para restaurar o migrar la base en Supabase:
1. Abrir **SQL Editor**
2. Pegar el contenido de `schema.sql`
3. Ejecutar
4. Luego ejecutar `policies.sql`
