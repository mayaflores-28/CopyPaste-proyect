import os
from pathlib import Path

from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.responses import HTMLResponse, FileResponse
from pydantic import BaseModel

# --- CARGA DE VARIABLES DE ENTORNO ---
# Las claves ya NO van escritas en el código. Se leen desde un archivo .env
# que NUNCA se sube a GitHub (está en .gitignore). Usa .env.example como
# plantilla para crear el tuyo.
load_dotenv()

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
GEMINI_MODEL = os.getenv("GEMINI_MODEL", "gemini-2.5-flash")
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

BASE_DIR = Path(__file__).resolve().parent.parent  # raíz del proyecto (donde están los .html)

app = FastAPI()

# --- CLIENTES EXTERNOS (se inicializan solo si hay credenciales) ---
supabase = None
if SUPABASE_URL and SUPABASE_KEY:
    try:
        from supabase import create_client
        supabase = create_client(SUPABASE_URL, SUPABASE_KEY)
    except Exception as e:
        print(f"⚠️  No se pudo conectar a Supabase: {e}")

gemini_client = None
if GEMINI_API_KEY:
    try:
        from google import genai
        gemini_client = genai.Client(api_key=GEMINI_API_KEY)
    except Exception as e:
        print(f"⚠️  No se pudo inicializar Gemini: {e}")

# --- DATOS DE RESPALDO ---
# Si Supabase no está configurado (o falla), la app sigue funcionando con
# este dataset de ejemplo, para que la demo nunca se quede en blanco.
ESTUDIANTES_FALLBACK = [
    {"nombre": "Ana Torres", "asistencia_pct": 62, "tendencia_notas": "baja", "trabaja": True, "repitio": False, "seccion": "3ro B", "semana": 4},
    {"nombre": "Luis Quispe", "asistencia_pct": 91, "tendencia_notas": "sube", "trabaja": False, "repitio": False, "seccion": "3ro B", "semana": 4},
    {"nombre": "Marisol Rojas", "asistencia_pct": 74, "tendencia_notas": "estable", "trabaja": False, "repitio": True, "seccion": "3ro B", "semana": 4},
    {"nombre": "Jhon Mamani", "asistencia_pct": 55, "tendencia_notas": "baja", "trabaja": True, "repitio": True, "seccion": "3ro B", "semana": 4},
    {"nombre": "Camila Vera", "asistencia_pct": 96, "tendencia_notas": "sube", "trabaja": False, "repitio": False, "seccion": "3ro B", "semana": 4},
]


class DatosEstudiante(BaseModel):
    nombre: str
    asistencia: float
    notas: str
    trabaja: bool
    repite: bool
    puntaje: int


# --- RUTAS DE PÁGINAS ---

def _serve(filename: str):
    return FileResponse(BASE_DIR / filename)


@app.get("/", response_class=HTMLResponse)
def pagina_login():
    return _serve("login.html")


@app.get("/menu", response_class=HTMLResponse)
def pagina_menu():
    return _serve("menu.html")


@app.get("/cursos", response_class=HTMLResponse)
def pagina_cursos():
    return _serve("cursos.html")


@app.get("/reporte", response_class=HTMLResponse)
def pagina_reporte():
    return _serve("index.html")


# --- RUTAS DE API ---

@app.get("/api/estudiantes")
def obtener_estudiantes():
    if supabase is not None:
        try:
            respuesta = supabase.table("estudiantes").select("*").execute()
            if respuesta.data:
                return respuesta.data
        except Exception as e:
            print(f"⚠️  Error al conectar con Supabase, usando datos de respaldo: {e}")
    return ESTUDIANTES_FALLBACK


def _recomendacion_local(datos: DatosEstudiante) -> str:
    """Recomendación de respaldo (sin IA) por si Gemini no está disponible."""
    piezas = []
    if datos.asistencia < 75:
        piezas.append("conversar hoy mismo sobre los motivos de las inasistencias")
    if datos.notas == "baja":
        piezas.append("reforzar el tema donde bajó su nota con una sesión corta")
    if datos.trabaja:
        piezas.append("coordinar horarios de estudio compatibles con su trabajo")
    if datos.repite:
        piezas.append("hacer seguimiento cercano por el antecedente de repitencia")
    if not piezas:
        piezas.append("mantener el acompañamiento habitual, no hay señales de alerta fuertes")
    return f"Con {datos.nombre} se recomienda: " + "; ".join(piezas) + "."


@app.post("/api/recomendacion")
def generar_recomendacion(datos: DatosEstudiante):
    if gemini_client is not None:
        contexto_trabajo = "trabaja además de estudiar" if datos.trabaja else "solo se dedica a estudiar"
        contexto_repite = "repitió el año anterior" if datos.repite else "no ha repetido años"

        prompt = f"""
Eres un orientador escolar en Perú. Analiza brevemente a este estudiante de secundaria:
- Nombre: {datos.nombre}
- Asistencia: {datos.asistencia}%
- Tendencia de notas: {datos.notas}
- Contexto: {contexto_trabajo}, {contexto_repite}.
- Nivel de riesgo de abandono escolar: {datos.puntaje}/100.

Escribe una recomendación única y práctica de máximo 3 oraciones para que su tutor aplique esta semana.
Sé empático, ve directo al grano, no uses saludos ni viñetas.
"""
        try:
            respuesta = gemini_client.models.generate_content(
                model=GEMINI_MODEL,
                contents=prompt,
            )
            return {"recomendacion": respuesta.text}
        except Exception as e:
            print(f"⚠️  ERROR DETALLADO DE GEMINI: {e}")
            # cae al respaldo local en vez de romper la demo

    return {"recomendacion": _recomendacion_local(datos)}
