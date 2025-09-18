# 📶 Portal WiFi - Script para Portal Cautivo en Android

![Termux](https://img.shields.io/badge/Platform-Android-Termux?logo=android&style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)
![Educational](https://img.shields.io/badge/Purpose-Educational-blue.svg?style=for-the-badge)

Herramienta educativa para demostrar vulnerabilidades de seguridad en redes WiFi públicas mediante un portal cautivo implementado en Termux.

> ⚠️ **ADVERTENCIA**: Este proyecto es estrictamente para fines educativos y de concienciación en seguridad. Úselo solo en entornos controlados y con el consentimiento explícito de todos los participantes.

## 📖 Tabla de Contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Opciones del Script](#-opciones-del-script)
- [Demostraciones Educativas](#-demostraciones-educativas)
- [Consideraciones de Seguridad](#-consideraciones-de-seguridad)
- [Contramedidas de Seguridad](#-contramedidas-de-seguridad)
- [Personalización](#-personalización)
- [FAQ](#-faq)
- [Contribución](#-contribución)
- [Licencia](#-licencia)

## ✨ Características

- 🌐 **Creación de Access Point** con portal cautivo personalizado
- 📱 **Interfaz web responsive** que simula login WiFi legítimo
- 🔍 **Monitor en tiempo real** de conexiones y capturas
- 📊 **Dashboard educativo** para demostraciones
- 🎯 **Múltiples opciones** de configuración y monitoreo
- 🔄 **Redirección inteligente** post-autenticación
- 📝 **Registro detallado** de actividad para análisis

## 🛠️ Requisitos

### Prerrequisitos de Sistema
- Dispositivo Android con root
- Termux instalado desde F-Droid
- Conexión a Internet inicial

### Paquetes Requeridos
```bash
# Ejecutar en Termux antes de comenzar:
pkg update && pkg upgrade
pkg install root-repo x11-repo
pkg install git php apache2 nano curl dnsutils net-tools iptables termux-auth
```

## 📥 Instalación

Sigue estos pasos para configurar el portal cautivo:

### 1. Configuración Inicial de Termux
```bash
# Dar permisos de almacenamiento
termux-setup-storage

# Instalar dependencias esenciales
pkg install root-repo
pkg install git php apache2 hostapd dnsmasq net-tools
```

### 2. Clonar el Repositorio
```bash
git clone https://github.com/tu-usuario/portal-wifi.git
cd portal-wifi
chmod +x portal-cautivo.sh
```

### 3. Ejecutar el Script
```bash
# Ejecutar con privilegios root
su
./portal-cautivo.sh
```

## 🚀 Uso

### Ejecución Básica
```bash
# Navegar al directorio del proyecto
cd portal-wifi

# Ejecutar el script principal
./portal-cautivo.sh
```

### Modo Monitor
```bash
# Solo monitorear capturas existentes
./portal-cautivo.sh --monitor
```

### Configuración Personalizada
```bash
# Especificar SSID personalizado
./portal-cautivo.sh --ssid "Free_WiFi_Cafe"

# Usar puerto personalizado
./portal-cautivo.sh --port 8081
```

## 🎯 Opciones del Script

| Opción | Descripción | Comando |
|--------|-------------|---------|
| **Opción 1** | Configura e inicia portal completo | `./portal-cautivo.sh` |
| **Opción 2** | Solo monitorear capturas existentes | `./portal-cautivo.sh --monitor` |
| **Opción 3** | Configurar con SSID personalizado | `./portal-cautivo.sh --ssid "Nombre_WiFi"` |
| **Opción 4** | Salir del programa | `Ctrl + C` o Opción 3 en menú |

## 🎓 Demostraciones Educativas

### Mensaje Educativo para Participantes
> "Esta demostración muestra cómo los puntos de acceso WiFi públicos no seguros pueden capturar sus credenciales. Nunca ingrese información sensible en redes WiFi públicas desconocidas sin verificar su autenticidad."

### Características para Demostraciones
- ✅ **Interfaz realista** que simula portales WiFi legítimos
- ✅ **Dashboard en tiempo real** para mostrar conexiones
- ✅ **Ejemplos visuales** de ataques de intermediario
- ✅ **Material educativo** integrado para participantes

### Posibles Mejoras para Demostraciones
```markdown
- [ ] Página de Términos y Condiciones simulada
- [ ] Redirección a Google después del login
- [ ] Captura de direcciones MAC de dispositivos
- [ ] Dashboard en tiempo real de conexiones
- [ ] Estadísticas de intentos de conexión
- [ ] Modo "espejo" para mostrar ataques en tiempo real
```

## ⚠️ Consideraciones de Seguridad

### Requisitos Técnicos
- **Root obligatorio** en dispositivo Android
- **Kernel personalizado**可能需要 en algunos dispositivos
- **Hardware compatible** con modo AP (punto de acceso)

### Consideraciones Éticas
1. **Solo uso educativo** - demostración de vulnerabilidades
2. **Consentimiento explícito** de todos los participantes
3. **Eliminación de datos** después de demostraciones
4. **Transparencia completa** sobre el propósito
5. **Entorno controlado** para todas las pruebas

### Limitaciones Técnicas
- Algunos dispositivos pueden requerir kernel personalizado
- Compatibilidad variable entre marcas de Android
- Rendimiento depende del hardware del dispositivo

## 🔒 Contramedidas de Seguridad

Enseña estas prácticas de seguridad en tus talleres:

### Protecciones Esenciales
| Práctica | Descripción | Nivel de Protección |
|----------|-------------|---------------------|
| **VPN** | Conexión cifrada punto a punto | 🔴 Alto |
| **Verificación SSL** | Validación de certificados | 🟡 Medio |
| **Autenticación 2FA** | Doble factor de autenticación | 🔴 Alto |
| **Contraseñas Únicas** | No reutilizar credenciales | 🟡 Medio |
| **Navegación Incógnita** | Limitación de rastreo | 🔵 Bajo |

### Recomendaciones Adicionales
- Usar aplicaciones de gestión de contraseñas
- Habilitar notificaciones de seguridad
- Verificar regularmente actividad de cuentas
- Actualizar dispositivos regularmente
- Usar redes WiFi conocidas y verificadas

## 🎨 Personalización

### Modificar SSID Predeterminado
Edita el archivo de configuración:
```bash
nano /data/data/com.termux/files/usr/etc/hostapd/hostapd.conf
```
Cambia la línea:
```conf
ssid=Free_Public_WiFi
```

### Personalizar Página de Login
Modifica los archivos HTML en:
```bash
cd /data/data/com.termux/files/usr/share/apache2/default-site/htdocs
```

### Configurar Redirección Post-Login
Edita el archivo PHP:
```bash
nano /data/data/com.termux/files/usr/share/apache2/default-site/htdocs/login.php
```

## ❓ FAQ

### P: ¿Necesito root para usar este script?
**R:** Sí, el acceso root es necesario para configurar el punto de acceso y las reglas de red.

### P: ¿Funciona en todos los dispositivos Android?
**R:** La compatibilidad varía. Dispositivos con kernels personalizados suelen tener mejor compatibilidad.

### P: ¿Es legal usar este script?
**R:** Solo es legal para fines educativos y con el consentimiento de todos los participantes.

### P: ¿Los datos capturados se almacenan permanentemente?
**R:** No, el script está diseñado para eliminar datos después de las demostraciones.

### P: ¿Puedo usar esto para pruebas de penetración reales?
**R:** Solo en entornos controlados y con autorización explícita por escrito.

## 🤝 Contribución

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Guía de Contribución
- Sigue el estilo de código existente
- Incluye documentación actualizada
- Añade tests si es posible
- Mantén el enfoque educativo del proyecto

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

**⚠️ Descargo de Responsabilidad**: Este software es solo para fines educativos. El mal uso de esta herramienta es responsabilidad exclusiva del usuario. Los desarrolladores no se hacen responsables del uso indebido de este software.

**🔐 Recuerda**: La seguridad informática debe practicarse de manera ética y legal. Siempre obtén el permiso apropiado antes de realizar cualquier prueba de seguridad.

---

<div align="center">
¿Necesitas ayuda o tienes preguntas? Abre un <a href="https://github.com/tu-usuario/portal-wifi/issues">issue</a> en GitHub.
</div>
