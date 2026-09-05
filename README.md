# PrevenIA

##  Nombre y Misión

**PrevenIA** es una aplicación web que analiza indicadores académicos y de contexto de cada estudiante (asistencia, tendencia de notas, situación laboral y repitencia) para identificar señales tempranas de bajo rendimiento académico y generar, mediante Inteligencia Artificial, recomendaciones de acompañamiento personalizadas para el tutor.

---

##  Problema & Enfoque Lean

### Problema

Los tutores de secundaria suelen enterarse de que un estudiante tiene dificultades académicas cuando el problema ya es evidente (notas muy bajas, ausencias prolongadas). Las señales previas —asistencia irregular, notas en descenso, tener que trabajar, haber repetido de año— ya existen antes de eso, pero hoy nadie las junta ni las prioriza de forma automática, por lo que el tutor no siempre puede intervenir a tiempo.

###  Usuario objetivo

Docentes tutores y responsables de acompañamiento académico de una sección de secundaria (30-35 estudiantes), que necesitan identificar rápidamente qué estudiantes requieren atención y por qué, sin tener que revisar manualmente el historial de cada uno.

###  Enfoque Lean

En lugar de que el tutor cruce manualmente asistencia, notas y contexto de cada estudiante, PrevenIA centraliza esa información y calcula automáticamente un indicador de riesgo de bajo rendimiento, explicando qué factores pesan más en cada caso y sugiriendo, con ayuda de IA, una acción concreta de acompañamiento.

###  Producto Mínimo Viable (MVP)

El MVP construido durante el hackathon permite:

1. Consultar la lista de estudiantes de una sección, con sus datos de asistencia, tendencia de notas y contexto.
2. Calcular automáticamente un puntaje de 0 a 100 que indica el nivel de señal de bajo rendimiento (🟢 bajo · 🟡 medio · 🔴 alto).
3. Mostrar al tutor una lista priorizada, ordenada de mayor a menor señal.
4. Explicar el puntaje: qué parte viene de asistencia, de notas, de trabajo o de repitencia (no es una caja negra).
5. Generar, con un clic, una recomendación de acompañamiento redactada por un modelo de IA a partir de los datos reales del estudiante.

###  Propuesta de valor

PrevenIA transforma datos académicos y de contexto, que hoy están dispersos, en una señal clara y priorizada de qué estudiantes necesitan acompañamiento, junto con una recomendación concreta generada por IA — permitiendo a los tutores actuar antes de que la situación se agrave.

---

##  Stack Tecnológico & IA

| Capa | Tecnología |
|---|---|
| Frontend | HTML5, CSS3, JavaScript (vanilla) |
| Backend | Python + FastAPI |
| Base de datos | Supabase (PostgreSQL) |
| Inteligencia Artificial |Gemini ia |
| Hosting / Deploy | Vercel |
| Control de versiones | Git + GitHub |

El frontend consulta directamente los datos de los estudiantes en Supabase (vía su API REST autogenerada), y se comunica con un endpoint de FastAPI que recibe los indicadores de un estudiante y devuelve una recomendación generada por el modelo de IA.

---

##  Arquitectura General

La solución sigue una arquitectura de tres capas: frontend, base de datos gestionada (Supabase) y un backend ligero en FastAPI dedicado exclusivamente a la generación de recomendaciones con IA.

El diagrama detallado (Mermaid) está en [`/docs/arquitectura.md`](./docs/arquitectura.md).

---

##  Setup Local

### Requisitos previos

- Node.js no es necesario para el frontend (es HTML/CSS/JS puro, sin build).
- Python 3.10 o superior (para el backend).
- Git.
- Una cuenta de Supabase con el proyecto ya configurado.

### 1. Clonar el repositorio

```bash
git clone https://github.com/mayaflores-28/CopyPaste-proyect.git
cd prevenia
```

### 2. Levantar el frontend

El frontend es un archivo estático. Basta con abrir `index.html` en el navegador, o servirlo con cualquier servidor local:

```bash
npx serve .
```

### 3. Levantar el backend (recomendación con IA)

```bash
cd backend
py -m venv .venv
.\.venv\Scripts\Activate.ps1   # En Windows
pip install -r requirements.txt
```

Crear un archivo `.env` en la carpeta `backend/` con (no colocamos las claves por seguridad ):

```
```


Ejecutar el servidor:

```bash
uvicorn main:app --reload
```

Y abrir: `http://127.0.0.1:8000/docs` para ver los endpoints disponibles.

---

##  Integrantes & Roles

| Integrante | GitHub | Rol |
|---|---|---|
| Renato Manuel Haqquehua Chavez | [@RenatoHaqquehua] | Backend / Integración con IA |
| Shayli Mishelly Flores Urbano | [@mayaflores-28] | Frontend / Base de datos (Supabase) |
| Andre Marco  Reátegui Rivera  | [@areategui0804] |  Documentación |
|Cervantes Sifuentes, Joel Cristhian| @ikybouu | Arquitectura / Backend|

---

##  Estado del proyecto — Fase 1

- [x] Interfaz web inicial con panel de estudiantes y semáforo de señales.
- [x] Base de datos conectada en Supabase con datos de prueba.
- [x] Cálculo del puntaje de señal de bajo rendimiento (ponderado por asistencia, notas, trabajo y repitencia).
- [x] Backend en FastAPI con endpoint de recomendación por IA (en integración con el frontend).
- [x] Repositorio en GitHub configurado.
- [ ] Pruebas automáticas (Fase 2).
- [ ] Despliegue en producción (Fase 2).

---

##  Seguridad

Las claves de API y credenciales de Supabase se manejan mediante variables de entorno (`.env`), nunca hardcodeadas en el código ni subidas al repositorio. Se incluye `.env.example` con la estructura esperada, sin valores reales.

---

##  Contexto del proyecto

PrevenIA fue desarrollado como propuesta tecnológica para la **Software Week Hackathon 2026 – UNI**, en la categoría de soluciones orientadas a problemáticas reales del entorno educativo peruano.




