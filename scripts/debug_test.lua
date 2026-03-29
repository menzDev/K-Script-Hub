-- Script de Prueba de Inyección y Entorno
-- Ejecuta este script primero para ver si tu executor funciona correctamente.

print("--- DIAGNÓSTICO DE EXECUTOR ---")

local success_notification, err_notification = pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Executor Activo",
        Text = "La inyección ha sido exitosa.",
        Duration = 5
    })
end)

if success_notification then
    print("[SUCCESS] Notificaciones funcionando.")
else
    print("[WARNING] No se pudo enviar notificación (posible falta de permisos).")
end

-- Prueba de Drawing API
if Drawing and Drawing.new then
    print("[SUCCESS] Librería 'Drawing' detectada.")
else
    print("[ERROR] Tu executor NO soporta la librería 'Drawing'. El script de Arsenal fallará.")
end

-- Prueba de Metamethod Hooking
if hookmetamethod then
    print("[SUCCESS] 'hookmetamethod' detectado.")
else
    print("[ERROR] Tu executor NO soporta 'hookmetamethod'. El Silent Aim no funcionará.")
end

-- Prueba de CoreGui
local success_core, err_core = pcall(function()
    local test = game:GetService("CoreGui")
    print("[SUCCESS] Acceso a CoreGui permitido.")
end)

if not success_core then
    print("[ERROR] No tienes acceso a CoreGui. La interfaz del script fallará.")
end

print("-------------------------------")
print("Cierra la consola (F9) y revisa los resultados.")
