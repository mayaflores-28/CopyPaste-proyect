<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>PrevenIA — Ingresar</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600&display=swap" rel="stylesheet">
<style>
:root{
  --navy:#14213D; --navy-2:#1C2C4C; --bg:#F4F5F3; --panel:#FFFFFF; --ink:#14213D;
  --muted:#5B6472; --line:#E3E5E1; --gold:#C98A2B; --green:#2E8B57; --green-bg:#E9F5EE;
  --amber:#C98A2B; --amber-bg:#FBF1DE; --red:#B5423A; --red-bg:#FBEBE8;
}
*{box-sizing:border-box;}
html,body{margin:0;padding:0; height:100%;}
body{
  font-family:'IBM Plex Sans', system-ui, sans-serif;
  background:radial-gradient(1200px 800px at 20% 10%, #1C2C4C 0%, var(--navy) 45%, #0F1830 100%);
  color:var(--ink);
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:24px;
}
.mono{font-family:'IBM Plex Mono', monospace;}

.wrap{
  width:100%;
  max-width:920px;
  display:grid;
  grid-template-columns: 1.05fr 1fr;
  background:var(--panel);
  border-radius:16px;
  overflow:hidden;
  box-shadow:0 30px 60px rgba(0,0,0,0.35);
}
@media (max-width:760px){ .wrap{grid-template-columns:1fr;} .brand-side{display:none;} }

.brand-side{
  background:linear-gradient(160deg, var(--navy) 0%, #0F1830 100%);
  color:#EDEFF3;
  padding:44px 38px;
  display:flex;
  flex-direction:column;
  justify-content:space-between;
}
.brand-side .name{font-size:26px; font-weight:700; letter-spacing:-0.01em;}
.brand-side .tag{font-size:13.5px; color:#AEB6C8; margin-top:6px; line-height:1.5; max-width:280px;}
.brand-side .badge-list{display:flex; flex-direction:column; gap:14px; margin-top:30px;}
.mini-feat{display:flex; gap:10px; align-items:flex-start; font-size:12.5px; color:#C7CCDA;}
.mini-feat .dot{width:7px; height:7px; border-radius:50%; background:var(--gold); margin-top:5px; flex:0 0 auto;}
.brand-side .foot{font-size:11px; color:#7D869C;}

.form-side{padding:44px 40px;}
.form-side h1{font-size:22px; margin:0 0 4px 0;}
.form-side .sub{font-size:13px; color:var(--muted); margin-bottom:24px;}

.tabs{display:flex; gap:4px; background:#F1F2EE; border-radius:9px; padding:4px; margin-bottom:24px;}
.tab-btn{
  flex:1; border:none; background:transparent; padding:9px 0; border-radius:6px;
  font-family:'IBM Plex Sans'; font-size:13px; font-weight:600; color:var(--muted); cursor:pointer;
}
.tab-btn.active{background:var(--panel); color:var(--navy); box-shadow:0 1px 3px rgba(0,0,0,0.08);}

.field{margin-bottom:16px;}
.field label{display:block; font-size:12px; font-weight:600; color:var(--muted); margin-bottom:6px; text-transform:uppercase; letter-spacing:.03em;}
.field input{
  width:100%; padding:11px 13px; border-radius:8px; border:1px solid var(--line);
  font-family:'IBM Plex Sans'; font-size:14px; background:#FBFBFA; color:var(--ink);
}
.field input:focus{outline:none; border-color:var(--gold); background:#fff;}

.err{
  display:none; background:var(--red-bg); color:var(--red); font-size:12.5px;
  padding:9px 12px; border-radius:7px; margin-bottom:14px;
}
.err.show{display:block;}

.submit-btn{
  width:100%; background:var(--navy); color:#fff; border:none; padding:12px 0;
  border-radius:8px; font-family:'IBM Plex Sans'; font-size:14.5px; font-weight:600;
  cursor:pointer; margin-top:6px;
}
.submit-btn:hover{background:var(--navy-2);}

.hint{font-size:11.5px; color:var(--muted); text-align:center; margin-top:16px;}
</style>
</head>
<body>

<div class="wrap">
  <div class="brand-side">
    <div>
      <div class="name">PrevenIA</div>
      <div class="tag">Alerta temprana de riesgo de bajo rendimiento y abandono escolar, con recomendaciones generadas por IA.</div>
      <div class="badge-list">
        <div class="mini-feat"><span class="dot"></span> Panel priorizado por nivel de riesgo</div>
        <div class="mini-feat"><span class="dot"></span> Explicación transparente del puntaje</div>
        <div class="mini-feat"><span class="dot"></span> Recomendaciones de acompañamiento con IA</div>
      </div>
    </div>
    <div class="foot mono">Software Week Hackathon 2026 · UNI</div>
  </div>

  <div class="form-side">
    <div class="tabs">
      <button class="tab-btn active" id="tabLogin">Iniciar sesión</button>
      <button class="tab-btn" id="tabRegister">Registrarme</button>
    </div>

    <!-- LOGIN -->
    <form id="formLogin">
      <h1>Bienvenido de vuelta</h1>
      <div class="sub">Ingresa con tu correo institucional.</div>
      <div class="err" id="errLogin"></div>
      <div class="field">
        <label>Correo</label>
        <input type="email" id="loginEmail" placeholder="profesor@colegio.edu.pe" required>
      </div>
      <div class="field">
        <label>Contraseña</label>
        <input type="password" id="loginPass" placeholder="••••••••" required>
      </div>
      <button type="submit" class="submit-btn">Ingresar</button>
      <div class="hint">Demo del hackathon: cualquier correo y contraseña funcionan.</div>
    </form>

    <!-- REGISTER -->
    <form id="formRegister" style="display:none;">
      <h1>Crear cuenta</h1>
      <div class="sub">Regístrate para empezar a usar PrevenIA.</div>
      <div class="err" id="errRegister"></div>
      <div class="field">
        <label>Nombre completo</label>
        <input type="text" id="regName" placeholder="Ej. Renato Haqquehua" required>
      </div>
      <div class="field">
        <label>Correo</label>
        <input type="email" id="regEmail" placeholder="profesor@colegio.edu.pe" required>
      </div>
      <div class="field">
        <label>Contraseña</label>
        <input type="password" id="regPass" placeholder="••••••••" required>
      </div>
      <div class="field">
        <label>Confirmar contraseña</label>
        <input type="password" id="regPass2" placeholder="••••••••" required>
      </div>
      <button type="submit" class="submit-btn">Crear cuenta</button>
      <div class="hint">Demo del hackathon: no se valida contra una base de datos real todavía.</div>
    </form>
  </div>
</div>

<script>
const tabLogin = document.getElementById('tabLogin');
const tabRegister = document.getElementById('tabRegister');
const formLogin = document.getElementById('formLogin');
const formRegister = document.getElementById('formRegister');

tabLogin.addEventListener('click', () => {
  tabLogin.classList.add('active'); tabRegister.classList.remove('active');
  formLogin.style.display = 'block'; formRegister.style.display = 'none';
});
tabRegister.addEventListener('click', () => {
  tabRegister.classList.add('active'); tabLogin.classList.remove('active');
  formRegister.style.display = 'block'; formLogin.style.display = 'none';
});

function showErr(id, msg){
  const el = document.getElementById(id);
  el.textContent = msg;
  el.classList.add('show');
}

function goToMenu(nombre, correo){
  localStorage.setItem('prevenia_user', JSON.stringify({ nombre, correo }));
  window.location.href = '/menu';
}

formLogin.addEventListener('submit', (e) => {
  e.preventDefault();
  const email = document.getElementById('loginEmail').value.trim();
  const pass = document.getElementById('loginPass').value;
  if(!email || !pass){ showErr('errLogin', 'Completa correo y contraseña.'); return; }
  // Demo: no hay verificación real contra base de datos, cualquier credencial pasa.
  const nombre = email.split('@')[0].replace(/[._]/g,' ');
  goToMenu(nombre.charAt(0).toUpperCase() + nombre.slice(1), email);
});

formRegister.addEventListener('submit', (e) => {
  e.preventDefault();
  const nombre = document.getElementById('regName').value.trim();
  const email = document.getElementById('regEmail').value.trim();
  const pass = document.getElementById('regPass').value;
  const pass2 = document.getElementById('regPass2').value;
  if(!nombre || !email || !pass || !pass2){ showErr('errRegister', 'Completa todos los campos.'); return; }
  if(pass !== pass2){ showErr('errRegister', 'Las contraseñas no coinciden.'); return; }
  goToMenu(nombre, email);
});

// Si ya hay sesión guardada, saltar directo al menú
if (localStorage.getItem('prevenia_user')) {
  window.location.href = '/menu';
}
</script>
</body>
</html>
