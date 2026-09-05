import os
from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from google import genai
from supabase import create_client, Client

# --- CONFIGURACIÓN DE APIS ---
# 1. Configura tu clave de Gemini
client = genai.Client(api_key="AIzaSyCZBGTDn1T7STuICdNmaTRbjUjnatl-3lQ")

# 2. Configura tu conexión a Supabase
SUPABASE_URL = "https://qoievyxjaicubvjpakdz.supabase.co"
SUPABASE_KEY = "sb_publishable_h6KYEmjz0Npyq370BsPVPg_xAj-4ZVN"
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

app = FastAPI()



# --- RUTAS DE LA APLICACIÓN ---

# Ruta 1: Sirve la interfaz gráfica (HTML)
@app.get("/", response_class=HTMLResponse)
def leer_inicio():
    ruta_html = os.path.join(os.path.dirname(__file__), "index.html")
    with open(ruta_html, "r", encoding="utf-8") as f:
        return f.read()

# Ruta 2: Obtiene la lista de estudiantes desde Supabase
@app.get("/api/estudiantes")
def obtener_estudiantes():
    try:
        respuesta = supabase.table("estudiantes").select("*").execute()
        return respuesta.data
    except Exception as e:
        print(f"Error al conectar con Supabase: {e}")
        return []

# Ruta 3: Genera la recomendación única usando Gemini 3.5
@app.post("/api/recomendacion")
def generar_recomendacion(datos: DatosEstudiante):
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
        respuesta = client.models.generate_content(
            model='gemini-3.5-flash',
            contents=prompt
        )
        recomendacion_ia = respuesta.text
    except Exception as e:
        print(f"⚠️ ERROR DETALLADO DE GEMINI: {e}") 
        recomendacion_ia = "Hubo un error de conexión con la IA. Revisa la terminal de VS Code."
        
    return {"recomendacion": recomendacion_ia}