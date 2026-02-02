#!/system/bin/sh

# --- KONFIGURASI ---
TARGET_DIR="/sdcard/Android/data/com.tencent.ig/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra"

echo "=== BYPASS REAKTIF: WILDCARD SMART CHECK ==="

# --- STEP 0: BERSIHKAN VPN LAIN ---
am force-stop com.cloudflare.onedotonedotonedotone > /dev/null 2>&1
am force-stop com.v2ray.ang > /dev/null 2>&1
am force-stop com.github.kr328.clash > /dev/null 2>&1

# --- Membunuh sisa-sisa aplikasi yang masih berjalan 
su -c "killall -9 com.cloudflare.onedotonedotonedotone" 2>/dev/null

while ifconfig tun0 > /dev/null 2>&1; do
    echo "Menunggu jalur VPN benar-benar lepas..."
    su -c "ip link set tun0 down" 2>/dev/null
    sleep 0.8
done

# --- STEP 1: WILDCARD SMART CHECK (LOGIKA FLEKSIBEL) ---
echo "Mengecek status folder secara menyeluruh..."

# Cari folder apapun yang berawalan 'content' tapi BUKAN tepat bernama 'content'
ANY_HIDDEN=$(find "$TARGET_DIR" -maxdepth 1 -type d -name "content*" | grep -vE "/content$")

if [ ! -z "$ANY_HIDDEN" ]; then
    echo "Cheat sudah tersembunyi di: $(basename "$ANY_HIDDEN")"
    HIDDEN_NAME=$(basename "$ANY_HIDDEN")
else
    if [ -d "$TARGET_DIR/content" ]; then
        echo "Folder content ditemukan, menyembunyikan..."
        HIDDEN_NAME="content_active"
        mv "$TARGET_DIR/content" "$TARGET_DIR/$HIDDEN_NAME"
    else
        echo "ERROR: Folder cheat tidak ditemukan sama sekali!"
        exit 1
    fi
fi

# --- STEP 2: FIREWALL (HARD LOCK) ---
echo "Membuka NoRoot Firewall..."
monkey -p app.greyshirts.firewall -c android.intent.category.LAUNCHER 1

while [ -z "$(dumpsys window windows | grep -i "app.greyshirts.firewall")" ]; do
    sleep 0.3
done

echo "Mencoba Aktifkan VPN..."
while true; do
    if ifconfig tun0 2>/dev/null | grep -q "UP"; then
        echo "Firewall AKTIF!"
        break
    else
        sleep 1.2
    fi
done

# --- STEP 3: START GAME ---
echo "GASS BUKA PUBG..."
monkey -p com.tencent.ig -c android.intent.category.LAUNCHER 1

# --- STEP 4: AUTO-DETECT LOGO (STABLE METHOD) ---
echo "Menunggu Logo Game Stabil..."

STABLE_COUNT=0
while [ $STABLE_COUNT -lt 2 ]; do
    # Cek apakah activity PUBG bener-bener ada di paling depan
    CURRENT_APP=$(dumpsys activity activities | grep -E "mResumedActivity|topResumedActivity" | grep "com.tencent.ig")
    
    if [ ! -z "$CURRENT_APP" ]; then
        STABLE_COUNT=$((STABLE_COUNT + 1))
        echo "Sinyal Logo $STABLE_COUNT terdeteksi..."
    else
        STABLE_COUNT=0
    fi
    sleep 0.8
done

echo "Game Stabil. Melakukan Injeksi..."

# --- STEP 5: RESTORE FOLDER (SAFE INJECTION) ---
if [ ! -z "$HIDDEN_NAME" ] && [ -d "$TARGET_DIR/$HIDDEN_NAME" ]; then
    # Pastikan game sudah benar-benar melewati fase inisialisasi awal
    sleep 1.5 
    
    su -c "mv '$TARGET_DIR/$HIDDEN_NAME' '$TARGET_DIR/content'"
    su -c "sync" # Paksa Android nulis perubahan file ke disk saat itu juga
    
    echo "INJEKSI BERHASIL: Folder dikembalikan aman."
else
    echo "ERROR: Folder bypass tidak ditemukan!"
fi

# --- STEP FINAL: PEMBERSIHAN ---
echo "Bypass Selesai. Membersihkan proses latar belakang..."
sync
exit 0

echo "=== SELESAI ==="