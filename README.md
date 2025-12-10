NexoCRM

Autor: Iván Carlo Tovilla Sánchez
Licencia: Apache License 2.0
Año: 2025

🏢 Descripción General

BrokermexCRM es un sistema CRM especializado para el sector inmobiliario industrial, comercial, residencial y de desarrollos.
Está diseñado para brokers y agencias modernas que necesitan una plataforma:

Segura

Rápida

Escalable

Documentada

Con RLS (Row Level Security) correctamente configurado

Integrable con portales y APIs externas

Este proyecto combina Supabase, React, políticas RLS, integración con APIs externas y un pipeline adaptable, en una arquitectura clara y profesional.

🚀 Tecnologías Utilizadas
Backend / Datos

Supabase (PostgreSQL + Auth + Storage)

Row Level Security (RLS)

Policies SQL

ERD (Entity Relationship Diagram)

SQL schema versionado

Frontend

React + Vite

React Hooks

Future PWA integration

Extras

Integraciones: Meta/Facebook, Instagram, Inmuebles24, Casas y Terrenos

Python para automatizaciones futuras

🧱 Estructura del Proyecto
brokermexcrm/
│
├── LICENSE                 → Licencia Apache 2.0
├── README.md               → ESTE README (documentación principal)
│
├── supabase/
│   ├── schema.sql          → Esquema completo de la base de datos
│   ├── policies.sql        → Políticas RLS (Row Level Security)
│   ├── erd.svg             → Diagrama ERD del schema
│
├── frontend/
│   ├── README.md           → Documentación del frontend (React)
│   └── ...                 → Código del frontend
│
└── package-lock.json

📦 Instalación del Proyecto
1. Clonar el repositorio
git clone https://github.com/ser-ser-ser/brokermexcrm.git
cd brokermexcrm

🗂 Supabase: Base de Datos, RLS y Seguridad

Este proyecto contiene:

✔ schema.sql — Esquema completo (clientes, propiedades, oportunidades, pipeline, etc.)
✔ policies.sql — Todas las políticas RLS revisadas y activas
✔ erd.svg — Diagrama ERD generado desde la plataforma

Cada cambio en la base de datos debe estar versionado antes de desplegarlo.

🎯 Roadmap del Proyecto
1. Foundation (completado parcial)

Creación del repositorio

Licencia Apache 2.0

README profesional

Supabase configurado

Tablas diseñadas

RLS activado

Diagrama ERD generado

2. Documentación

Agregar Manifiesto del Proyecto a /docs/MANIFIESTO.md

Agregar guía de contribución

Agregar documentación de APIs externas

3. Frontend

Setup completo de React

Login + registro con Supabase Auth

Dashboard principal

CRUD de propiedades

CRUD de clientes

Pipeline drag & drop

4. Integraciones Externas

API Meta (forms)

API Instagram

Scraper/API para Inmuebles24

Conexión con Casas y Terrenos

5. Automatizaciones (Python)

Webhooks

Limpieza y transformación de datos

Sincronización automática de leads

📜 Licencia

Este proyecto está bajo la Apache License 2.0, lo que permite uso comercial, modificaciones y distribución con atribución.

Autor: Iván Carlo Tovilla Sánchez

📌 Nota Final

Este README forma parte del sistema de documentación profesional del proyecto.
Todo cambio mayor debe ser discutido, revisado y aprobado antes de aplicarse, siguiendo el Manifiesto del Proyecto BrokermexCRM.
