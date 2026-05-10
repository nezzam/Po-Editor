#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
echo -e "${BLUE}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║      NZ PO Editor — المثبّت          ║"
echo "  ║   محرر ملفات الترجمة .po            ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}❌ شغّل بصلاحيات المدير:  sudo bash install.sh${NC}"; exit 1
fi
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Check Node.js
if ! command -v node &>/dev/null || [ "$(node --version | sed 's/v//' | cut -d. -f1)" -lt 18 ]; then
    echo -e "${YELLOW}📦 تثبيت Node.js...${NC}"
    if command -v apt-get &>/dev/null; then
        apt-get update -qq && apt-get install -y nodejs npm
    elif command -v dnf &>/dev/null; then dnf install -y nodejs npm
    elif command -v pacman &>/dev/null; then pacman -S --noconfirm nodejs npm
    else echo -e "${RED}❌ ثبّت Node.js v18+ يدوياً من nodejs.org${NC}"; exit 1; fi
fi
echo -e "${GREEN}✓ Node.js $(node --version)${NC}"
echo -e "\n${BLUE}📦 تثبيت الحزمة...${NC}"
dpkg -i "$DIR/nz-po-editor_1.0.0_amd64.deb"
apt-get install -f -y 2>/dev/null || true
echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅  تم تثبيت NZ PO Editor!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "  🚀 من الطرفية:     ${YELLOW}nz-po-editor${NC}"
echo -e "  📱 أو من قائمة التطبيقات"
echo -e "  📄 فتح ملف مباشرة: ${YELLOW}nz-po-editor file.po${NC}"
echo -e "  🖱️  أو كليك يمين على ملف .po ← فتح بواسطة ← NZ PO Editor"
echo -e "  🗑️  إزالة:          ${YELLOW}sudo apt remove nz-po-editor${NC}\n"
