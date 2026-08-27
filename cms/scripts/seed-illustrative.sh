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
    -H "Content-Type: application/json; charset=utf-8" \
    -H "Authorization: Bearer $TOKEN" \
    --data-binary "$data"
  echo
}

put_single() {
  local path="$1"
  local data="$2"
  curl -s -X PUT "$BASE_URL$path" \
    -H "Content-Type: application/json; charset=utf-8" \
    -H "Authorization: Bearer $TOKEN" \
    --data-binary "$data"
  echo
}

echo "== Services =="
post /api/services '{"data":{"title":"Data & Analytics","slug":"data-analytics","pillar":"Data & Analytics","summary":"Dashboards ejecutivos, analítica descriptiva y diagnóstica, gobierno de datos e indicadores que dan visibilidad real del negocio.","description":"Dashboards ejecutivos, analítica descriptiva y diagnóstica, gobierno de datos e indicadores que dan visibilidad real del negocio.","highlights":["Dashboards ejecutivos personalizados y visualización de datos","Analítica descriptiva y diagnóstica, indicadores de gestión","Gobierno de datos y estudios estadísticos","Procesamiento masivo de datos y ETL robusto"],"order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/services '{"data":{"title":"Technology","slug":"technology","pillar":"Technology","summary":"Desarrollo de software, plataformas SaaS, APIs e integraciones complejas. Arquitectura pensada para escalar, no solo para lanzar.","description":"Desarrollo de software, plataformas SaaS, APIs e integraciones complejas. Arquitectura pensada para escalar, no solo para lanzar.","highlights":["Aplicaciones web, móviles y empresariales","Plataformas SaaS y sistemas de gestión a medida","Diseño de APIs e integraciones complejas","Infraestructura cloud, hosting y soporte técnico"],"order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/services '{"data":{"title":"AI & Automation","slug":"ai-automation","pillar":"AI & Automation","summary":"Machine learning, IA generativa, automatización de procesos y modelos predictivos que quitan trabajo manual del camino.","description":"Machine learning, IA generativa, automatización de procesos y modelos predictivos que quitan trabajo manual del camino.","highlights":["Modelado de Machine Learning y Deep Learning","Inteligencia Artificial Generativa y PLN","Sistemas predictivos y clasificación automática","Automatización de procesos (RPA/ETL)"],"order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Projects =="
post /api/projects '{"data":{"title":"Optimización de ocupación hotelera","slug":"optimizacion-ocupacion-hotelera","sector":"Hospitalidad","city":"Punta Cana","problem":"Cadena hotelera con ocupación fragmentada por propiedad, sin visibilidad consolidada.","solution":"Dashboard de BI unificado con predicción de demanda por temporada, integrando datos de las distintas propiedades.","result":"+12% precisión de forecast de ocupación","isIllustrative":true,"order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/projects '{"data":{"title":"Automatización de reposición de inventario","slug":"automatizacion-reposicion-inventario","sector":"Retail","city":"Santiago","problem":"Cadena retail con inventario descoordinado entre tiendas y quiebres de stock frecuentes.","solution":"Automatización ETL de los sistemas de punto de venta y un modelo de reposición predictivo por tienda.","result":"-18% en quiebres de stock (ahorro estimado RD$2.4M/año)","isIllustrative":true,"order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/projects '{"data":{"title":"Tablero de riesgo financiero","slug":"tablero-riesgo-financiero","sector":"Finanzas","city":"Santo Domingo","problem":"Reportes de riesgo armados a mano cada mes, con datos de múltiples sistemas.","solution":"Pipeline de datos automatizado y tablero ejecutivo de riesgo actualizado en tiempo real.","result":"De días a horas en la generación de reportes","isIllustrative":true,"order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Team members =="
post /api/team-members '{"data":{"name":"CEO / Gerencia General","direction":"CEO / Gerencia General","roleSummary":"Dirección estratégica","initials":"CEO","order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Dirección Comercial, Formación e IA","direction":"Dirección Comercial, Formación e IA","roleSummary":"Crecimiento y casos de IA","initials":"CD","order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Dirección de Tecnología y Arq. Digital","direction":"Dirección de Tecnología y Arq. Digital","roleSummary":"Plataformas y ciberseguridad","initials":"CTO","order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Dirección de Automatización e Innovación","direction":"Dirección de Automatización e Innovación","roleSummary":"RPA, integraciones e I+D+i","initials":"AeI","order":4,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/team-members '{"data":{"name":"Dirección de BI y Analítica Empresarial","direction":"Dirección de BI y Analítica Empresarial","roleSummary":"Datos e inteligencia de negocio","initials":"BI","order":5,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Sectors =="
post /api/sectors '{"data":{"name":"Hospitalidad","slug":"hospitalidad","order":1,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"PYMEs","slug":"pymes","order":2,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Retail","slug":"retail","order":3,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Finanzas","slug":"finanzas","order":4,"publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/sectors '{"data":{"name":"Educación","slug":"educacion","order":5,"publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Posts (Insights) =="
post /api/posts '{"data":{"title":"Cómo elegir el primer caso de uso de IA generativa para tu empresa","slug":"primer-caso-uso-ia-generativa","category":"IA","excerpt":"Una guía práctica para no empezar por el proyecto equivocado.","body":"Una guía práctica para no empezar por el proyecto equivocado.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"Dashboards que nadie mira: 5 errores comunes de gobierno de datos","slug":"dashboards-que-nadie-mira","category":"BI","excerpt":"Por qué la mayoría de los tableros ejecutivos terminan abandonados.","body":"Por qué la mayoría de los tableros ejecutivos terminan abandonados.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"RPA vs. automatización inteligente: cuándo usar cada una","slug":"rpa-vs-automatizacion-inteligente","category":"Automatizacion","excerpt":"No todo proceso manual necesita el mismo tipo de solución.","body":"No todo proceso manual necesita el mismo tipo de solución.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"Gobierno de datos para PYMEs: por dónde empezar sin un equipo grande","slug":"gobierno-de-datos-pymes","category":"Data","excerpt":"Tres prácticas mínimas antes de invertir en herramientas.","body":"Tres prácticas mínimas antes de invertir en herramientas.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"IA generativa en atención al cliente: qué automatizar y qué no","slug":"ia-generativa-atencion-cliente","category":"IA","excerpt":"Dónde el toque humano sigue ganando, con datos de proyectos recientes.","body":"Dónde el toque humano sigue ganando, con datos de proyectos recientes.","publishedAt":"2026-08-27T00:00:00.000Z"}}'
post /api/posts '{"data":{"title":"El costo real de un reporte manual mensual","slug":"costo-real-reporte-manual","category":"BI","excerpt":"Cómo calculamos el ROI de automatizar el reporting financiero.","body":"Cómo calculamos el ROI de automatizar el reporting financiero.","publishedAt":"2026-08-27T00:00:00.000Z"}}'

echo "== Home page (single type, component-based) =="
put_single /api/home-page '{"data":{
  "hero":{"eyebrow":"Datos · Tecnología · Estrategia","heading":"Transformamos datos en decisiones.\nTransformamos decisiones en resultados.","lede":"Consultoría tecnológica, inteligencia artificial, automatización y business intelligence para organizaciones dominicanas y de la región que quieren competir con evidencia — no con intuición.","primaryCtaLabel":"Solicitar diagnóstico","primaryCtaHref":"/contacto","secondaryCtaLabel":"Ver nuestro proceso","secondaryCtaHref":"/soluciones"},
  "queHacemos":{"heading":"Consultoría tecnológica con base en datos, no en suposiciones.","body":"TRINALYZE es una firma dominicana de consultoría tecnológica, desarrollo de software, inteligencia artificial y business intelligence. Ayudamos a organizaciones a diagnosticar procesos ineficientes, construir la infraestructura de datos que les falta, y automatizar lo que hoy hacen a mano.\n\nOperamos con un modelo matricial: equipos multidisciplinarios de consultores, desarrolladores, analistas y científicos de datos se arman por proyecto según lo que cada iniciativa realmente necesita.","stats":[{"value":"Santo Domingo, RD","label":"Sede central"},{"value":"7","label":"Líneas de negocio activas"}]},
  "serviciosHeader":{"eyebrow":"Servicios","heading":"Tres pilares, un mismo objetivo."},
  "proyectosHeader":{"eyebrow":"Proyectos","heading":"Problema, solución, resultado."},
  "sectoresHeader":{"eyebrow":"Sectores","heading":"Trabajamos donde los datos mueven la operación."},
  "insightsHeader":{"eyebrow":"Insights","heading":"Notas sobre datos, IA, BI y automatización."},
  "ctaFinal":{"eyebrow":"Siguiente paso","heading":"¿Listos para ver qué dicen sus datos?","buttonLabel":"Solicitar diagnóstico","buttonHref":"/contacto"},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Servicios page (single type) =="
put_single /api/servicios-page '{"data":{
  "header":{"eyebrow":"Servicios","heading":"Tres pilares, un mismo objetivo: decisiones mejores y más rápidas.","dek":"Cada línea de negocio se apoya en las otras dos — los datos alimentan la IA, la tecnología sostiene ambas. Así trabajamos cada proyecto, sin importar por cuál pilar entre el cliente."},
  "ctaFinal":{"eyebrow":"¿No sabes por dónde empezar?","heading":"Un diagnóstico gratuito te dice cuál pilar resolver primero.","buttonLabel":"Solicitar diagnóstico","buttonHref":"/contacto"},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Soluciones page (single type) =="
put_single /api/soluciones-page '{"data":{
  "header":{"eyebrow":"Soluciones · Nuestro proceso","heading":"Un ciclo metodológico de cinco fases, retroalimentado.","dek":"De la conceptualización estratégica del negocio hasta la implementación y el soporte continuo, cada fase responde una pregunta concreta antes de pasar a la siguiente."},
  "phases":[{"numeral":"I","title":"Negocio","question":"¿Qué problema debemos resolver?","detail":"Comprender negocio y objetivos"},{"numeral":"II","title":"Datos","question":"¿Qué información necesitamos?","detail":"Recopilar, integrar y validar datos"},{"numeral":"III","title":"Análisis","question":"¿Qué nos dicen los datos?","detail":"Identificar patrones y tendencias"},{"numeral":"IV","title":"Inteligencia","question":"¿Qué puede suceder?","detail":"Modelos predictivos y recomendaciones"},{"numeral":"V","title":"Solución","question":"¿Qué debemos implementar?","detail":"Ejecutar acciones y evaluar"}],
  "ctaFinal":{"eyebrow":"Vea el proceso aplicado","heading":"Así se vio en proyectos reales de nuestros clientes.","buttonLabel":"Ver proyectos","buttonHref":"/proyectos"},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Proyectos page (single type) =="
put_single /api/proyectos-page '{"data":{
  "header":{"eyebrow":"Proyectos","heading":"Problema, solución, resultado.","dek":"Así documentamos cada proyecto — sin adornos, con el resultado medible al final. Los casos abajo son ilustrativos, pensados para mostrar el formato en el que reportamos resultados reales."},
  "ctaFinal":{"eyebrow":"¿Su empresa tiene un caso parecido?","heading":"Cuéntenos qué proceso quiere mejorar.","buttonLabel":"Solicitar diagnóstico","buttonHref":"/contacto"},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Equipo page (single type) =="
put_single /api/equipo-page '{"data":{
  "header":{"eyebrow":"Nuestro equipo","heading":"CEO + 4 socios, cada uno al frente de una dirección.","dek":"Un modelo matricial orientado a proyectos: cada dirección aporta su especialidad, y los equipos se arman según lo que cada iniciativa realmente necesita."},
  "filosofia":{"heading":"Colaboración transversal.","body":"Ningún proyecto se resuelve desde una sola disciplina. Consultores, desarrolladores, analistas y científicos de datos trabajan juntos desde el diagnóstico hasta la implementación.\n\nEs de suma importancia la participación de todos los colaboradores: cada dirección aporta su mirada antes de que una solución se dé por terminada."},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Insights page (single type) =="
put_single /api/insights-page '{"data":{
  "header":{"eyebrow":"Insights","heading":"Notas sobre datos, IA, BI y automatización.","dek":"Lo que aprendemos aplicando esto en clientes reales, en formato corto y sin relleno."},
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "== Contacto page (single type) =="
put_single /api/contacto-page '{"data":{
  "header":{"eyebrow":"Contacto","heading":"Solicitar diagnóstico","dek":"Cuéntanos qué proceso o decisión quieres mejorar. Uno de nuestros representantes se pondrá en contacto contigo de inmediato, en los próximos 5 minutos."},
  "whatsappLabel":"Escríbenos por WhatsApp (RD +1 809)",
  "footerNote":"Con sede en Santo Domingo, República Dominicana.",
  "publishedAt":"2026-08-27T00:00:00.000Z"
}}'

echo "Done."
