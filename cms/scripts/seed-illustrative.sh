#!/usr/bin/env bash
# One-off script: loads the illustrative/placeholder content that already
# lives in /prototype into Strapi via the REST API. Safe to re-run; Strapi
# will just create duplicate entries if run twice (no upsert), so this is
# meant to be run once against a fresh database.
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:1337}"
TOKEN="${STRAPI_API_TOKEN:?Set STRAPI_API_TOKEN to a full-access API token}"

post() {
  local path="$1"
  local data="$2"
  curl -s -X POST "$BASE_URL$path" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "$data"
  echo
}

put_single() {
  local path="$1"
  local data="$2"
  curl -s -X PUT "$BASE_URL$path" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "$data"
  echo
}

echo "== Services =="
post /api/services '{"data":{"title":"Data & Analytics","slug":"data-analytics","pillar":"Data & Analytics","summary":"Dashboards ejecutivos, analitica descriptiva y diagnostica, gobierno de datos e indicadores que dan visibilidad real del negocio.","description":"Dashboards ejecutivos, analitica descriptiva y diagnostica, gobierno de datos e indicadores que dan visibilidad real del negocio.","highlights":["Dashboards ejecutivos personalizados y visualizacion de datos","Analitica descriptiva y diagnostica, indicadores de gestion","Gobierno de datos y estudios estadisticos","Procesamiento masivo de datos y ETL robusto"],"order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/services '{"data":{"title":"Technology","slug":"technology","pillar":"Technology","summary":"Desarrollo de software, plataformas SaaS, APIs e integraciones complejas. Arquitectura pensada para escalar, no solo para lanzar.","description":"Desarrollo de software, plataformas SaaS, APIs e integraciones complejas. Arquitectura pensada para escalar, no solo para lanzar.","highlights":["Aplicaciones web, moviles y empresariales","Plataformas SaaS y sistemas de gestion a medida","Diseno de APIs e integraciones complejas","Infraestructura cloud, hosting y soporte tecnico"],"order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/services '{"data":{"title":"AI & Automation","slug":"ai-automation","pillar":"AI & Automation","summary":"Machine learning, IA generativa, automatizacion de procesos y modelos predictivos que quitan trabajo manual del camino.","description":"Machine learning, IA generativa, automatizacion de procesos y modelos predictivos que quitan trabajo manual del camino.","highlights":["Modelado de Machine Learning y Deep Learning","Inteligencia Artificial Generativa y PLN","Sistemas predictivos y clasificacion automatica","Automatizacion de procesos (RPA/ETL)"],"order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Projects =="
post /api/projects '{"data":{"title":"Optimizacion de ocupacion hotelera","slug":"optimizacion-ocupacion-hotelera","sector":"Hospitalidad","city":"Punta Cana","problem":"Cadena hotelera con ocupacion fragmentada por propiedad, sin visibilidad consolidada.","solution":"Dashboard de BI unificado con prediccion de demanda por temporada, integrando datos de las distintas propiedades.","result":"+12% precision de forecast de ocupacion","isIllustrative":true,"order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/projects '{"data":{"title":"Automatizacion de reposicion de inventario","slug":"automatizacion-reposicion-inventario","sector":"Retail","city":"Santiago","problem":"Cadena retail con inventario descoordinado entre tiendas y quiebres de stock frecuentes.","solution":"Automatizacion ETL de los sistemas de punto de venta y un modelo de reposicion predictivo por tienda.","result":"-18% en quiebres de stock (ahorro estimado RD$2.4M/ano)","isIllustrative":true,"order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/projects '{"data":{"title":"Tablero de riesgo financiero","slug":"tablero-riesgo-financiero","sector":"Finanzas","city":"Santo Domingo","problem":"Reportes de riesgo armados a mano cada mes, con datos de multiples sistemas.","solution":"Pipeline de datos automatizado y tablero ejecutivo de riesgo actualizado en tiempo real.","result":"De dias a horas en la generacion de reportes","isIllustrative":true,"order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Team members =="
post /api/team-members '{"data":{"name":"CEO / Gerencia General","direction":"CEO / Gerencia General","roleSummary":"Direccion estrategica","initials":"CEO","order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Direccion Comercial, Formacion e IA","direction":"Direccion Comercial, Formacion e IA","roleSummary":"Crecimiento y casos de IA","initials":"CD","order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Direccion de Tecnologia y Arq. Digital","direction":"Direccion de Tecnologia y Arq. Digital","roleSummary":"Plataformas y ciberseguridad","initials":"CTO","order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Direccion de Automatizacion e Innovacion","direction":"Direccion de Automatizacion e Innovacion","roleSummary":"RPA, integraciones e I+D+i","initials":"AeI","order":4,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Direccion de BI y Analitica Empresarial","direction":"Direccion de BI y Analitica Empresarial","roleSummary":"Datos e inteligencia de negocio","initials":"BI","order":5,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Sectors =="
post /api/sectors '{"data":{"name":"Hospitalidad","slug":"hospitalidad","order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"PYMEs","slug":"pymes","order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Retail","slug":"retail","order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Finanzas","slug":"finanzas","order":4,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Educacion","slug":"educacion","order":5,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Posts (Insights) =="
post /api/posts '{"data":{"title":"Como elegir el primer caso de uso de IA generativa para tu empresa","slug":"primer-caso-uso-ia-generativa","category":"IA","excerpt":"Una guia practica para no empezar por el proyecto equivocado.","body":"Una guia practica para no empezar por el proyecto equivocado.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"Dashboards que nadie mira: 5 errores comunes de gobierno de datos","slug":"dashboards-que-nadie-mira","category":"BI","excerpt":"Por que la mayoria de los tableros ejecutivos terminan abandonados.","body":"Por que la mayoria de los tableros ejecutivos terminan abandonados.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"RPA vs. automatizacion inteligente: cuando usar cada una","slug":"rpa-vs-automatizacion-inteligente","category":"Automatizacion","excerpt":"No todo proceso manual necesita el mismo tipo de solucion.","body":"No todo proceso manual necesita el mismo tipo de solucion.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"Gobierno de datos para PYMEs: por donde empezar sin un equipo grande","slug":"gobierno-de-datos-pymes","category":"Data","excerpt":"Tres practicas minimas antes de invertir en herramientas.","body":"Tres practicas minimas antes de invertir en herramientas.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"IA generativa en atencion al cliente: que automatizar y que no","slug":"ia-generativa-atencion-cliente","category":"IA","excerpt":"Donde el toque humano sigue ganando, con datos de proyectos recientes.","body":"Donde el toque humano sigue ganando, con datos de proyectos recientes.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"El costo real de un reporte manual mensual","slug":"costo-real-reporte-manual","category":"BI","excerpt":"Como calculamos el ROI de automatizar el reporting financiero.","body":"Como calculamos el ROI de automatizar el reporting financiero.","publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== About page (single type) =="
put_single /api/about-page '{"data":{"queHacemosHeading":"Consultoria tecnologica con base en datos, no en suposiciones.","queHacemosBody":"TRINALYZE es una firma dominicana de consultoria tecnologica, desarrollo de software, inteligencia artificial y business intelligence. Ayudamos a organizaciones a diagnosticar procesos ineficientes, construir la infraestructura de datos que les falta, y automatizar lo que hoy hacen a mano.\n\nOperamos con un modelo matricial: equipos multidisciplinarios de consultores, desarrolladores, analistas y cientificos de datos se arman por proyecto segun lo que cada iniciativa realmente necesita.","hqCity":"Santo Domingo, RD","activeBusinessLines":7,"filosofiaHeading":"Colaboracion transversal.","filosofiaBody":"Ningun proyecto se resuelve desde una sola disciplina. Consultores, desarrolladores, analistas y cientificos de datos trabajan juntos desde el diagnostico hasta la implementacion.\n\nEs de suma importancia la participacion de todos los colaboradores: cada direccion aporta su mirada antes de que una solucion se de por terminada.","publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Process page (single type) =="
put_single /api/process-page '{"data":{"heading":"Un ciclo metodologico de cinco fases, retroalimentado.","intro":"De la conceptualizacion estrategica del negocio hasta la implementacion y el soporte continuo, cada fase responde una pregunta concreta antes de pasar a la siguiente.","phases":[{"numeral":"I","title":"Negocio","question":"Que problema debemos resolver?","detail":"Comprender negocio y objetivos"},{"numeral":"II","title":"Datos","question":"Que informacion necesitamos?","detail":"Recopilar, integrar y validar datos"},{"numeral":"III","title":"Analisis","question":"Que nos dicen los datos?","detail":"Identificar patrones y tendencias"},{"numeral":"IV","title":"Inteligencia","question":"Que puede suceder?","detail":"Modelos predictivos y recomendaciones"},{"numeral":"V","title":"Solucion","question":"Que debemos implementar?","detail":"Ejecutar acciones y evaluar"}],"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "Done."
