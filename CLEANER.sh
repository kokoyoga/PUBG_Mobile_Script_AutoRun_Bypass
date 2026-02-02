#!/system/bin/sh

TARGET_DIR="/sdcard/Android/data/com.tencent.ig/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra"

echo "=== PEMBERSIHAN NUCLEAR + KILL FIREWALL ==="

# 1. Matikan aplikasi secara brutal (WAJIB)
echo "Menghentikan PUBG & Firewall..."
am force-stop com.tencent.ig
am force-stop app.greyshirts.firewall

# Kill semua sisa proses yang mungkin masih nyangkut di RAM
killall com.tencent.ig 2>/dev/null
killall app.greyshirts.firewall 2>/dev/null
# Tambahan: Bunuh proses vpnserv (mesin utama NoRoot Firewall)
su -c "killall -9 vpnserv" 2>/dev/null 

sleep 1

# 2. Hapus Cache (Metode Triple: Standard + Find + PM)
echo "Membersihkan Cache sistem secara paksa..."
pm trim-caches 999G 2>/dev/null

su -c "nsenter -t 1 -m find /data/data/com.tencent.ig/cache -mindepth 1 -delete"
su -c "nsenter -t 1 -m find /data/data/com.tencent.ig/code_cache -mindepth 1 -delete"

# Re-create cache folder untuk reset lock
su -c "nsenter -t 1 -m rm -rf /data/data/com.tencent.ig/cache"
su -c "nsenter -t 1 -m mkdir -p /data/data/com.tencent.ig/cache"
su -c "nsenter -t 1 -m chmod 771 /data/data/com.tencent.ig/cache"

# 3. Hapus Log & Shader (Standard)
echo "Membersihkan jejak Logs & Shader..."
rm -rf "$TARGET_DIR/Saved/Logs"/*
rm -rf "$TARGET_DIR/Saved/UpdateInfo"/*
rm -rf "$TARGET_DIR/Saved/com.tencent.ig.gp_shader_cache"

# 4. Logic Random Rename
echo "Mengamankan folder cheat..."
RAND_NAME="content_$RANDOM"
EXISTING_CONTENT=$(find "$TARGET_DIR" -maxdepth 1 -type d -name "content*")

if [ ! -z "$EXISTING_CONTENT" ]; then
    for folder in $EXISTING_CONTENT; do
        echo "Menyamarkan: $(basename $folder) -> $RAND_NAME"
        su -c "nsenter -t 1 -m mv '$folder' '$TARGET_DIR/$RAND_NAME'"
    done
fi

# 5. Finalisasi
echo "Finalisasi sistem..."
su -c "logcat -c"
su -c "sync"

echo "=== CEK ULANG CACHE ==="
CHECK_CACHE=$(su -c "nsenter -t 1 -m ls -A /data/data/com.tencent.ig/cache")
if [ -z "$CHECK_CACHE" ]; then
    echo "CACHE: BERHASIL DIKOSONGKAN!"
else
    echo "CACHE: MASIH ADA ISI (Sistem Lock)"
    echo "Isi sisa: $CHECK_CACHE"
fi

echo "=== SELESAI ==="