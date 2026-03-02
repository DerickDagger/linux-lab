#Reporte de Analisis de Logs

**Archivo analizado:** sample.log
**Fecha del analisis:** 2026-03-01 23:24:08
**Total de entradas:** 500

---

## 1. Top 10 Direcciones IP

| Solicitudes | Direccion IP |
|-------------|-------------|
| 179 | 192.168.1.10 |
| 94 | 10.0.0.5 |
| 60 | 10.0.0.99 |
| 59 | 203.0.113.42 |
| 56 | 192.168.1.25 |
| 52 | 172.16.0.3 |

## 2. Distribucion por Severidad

| Nivel | Cantidad |
|-------------|-------------|
 | FATAL | 101 | 
 | ERROR | 82 | 
 | WARNING | 77 | 
 | INFO | 240 | 

## 3. Eventos por Hora

| Hora | Eventos |
|------|---------|
| 00:00 | 28 |
| 01:00 | 22 |
| 02:00 | 25 |
| 03:00 | 14 |
| 04:00 | 22 |
| 05:00 | 30 |
| 06:00 | 19 |
| 07:00 | 19 |
| 08:00 | 19 |
| 09:00 | 25 |
| 10:00 | 15 |
| 11:00 | 20 |
| 12:00 | 28 |
| 13:00 | 17 |
| 14:00 | 18 |
| 15:00 | 17 |
| 16:00 | 20 |
| 17:00 | 19 |
| 18:00 | 19 |
| 19:00 | 22 |
| 20:00 | 22 |
| 21:00 | 24 |
| 22:00 | 18 |
| 23:00 | 18 |

## 4. Top 5 Mensajes de Error

|Frecuencia | Mensaje |
|------------|---------|
| 59 | Connectiontimeoutafter30s |
| 52 | Authenticationfailedforuseradmin |
| 29 | OutofmemoryerrorinmoduleX |
| 28 | Databaseconnectionrefused |
| 15 | Failedtowritetodisk |

## 5. Resumen

 - Sistema analizado con 500 eventos registrados
 - 183 eventos requieren atencion (ERROR y FATAL)
 - Analisis completado con herramientas UNIX estandar
