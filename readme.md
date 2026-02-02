📦 UPDATE: BYPASS AUTORUN V.2 

Update kali ini fokus pada stabilitas tingkat tinggi dan Universal Compatibility. Script sudah dioptimasi untuk menembus proteksi agresif pada MIUI/HyperOS dan OneUI.

📂 File Name: bypass_autorun_v.2.zip
🛠 Status: STABLE & TESTED
🚀 Changelog V.2:

    [New] Universal Logic: Menggunakan metode Event-Driven Waiting. Tidak lagi bergantung pada koordinat pixel (Anti-Meleset di semua resolusi layar).

    [New] Nuclear Cleaner: Deep cleaning cache sistem via nsenter & pm trim-caches. Sapu bersih jejak shader dan log secara tuntas.

    [Fix] Xiaomi Anti-Restart: Ditambahkan logika ip link set tun0 down untuk mencegah Cloudflare/VPN lain melakukan auto-start yang bisa menendang Firewall.

    [Fix] Process Killer: Penambahan killall -9 vpnserv untuk memastikan Firewall mati total saat cleaner dijalankan (No more Lag!).

    [Optimized] Stability: Jeda waktu (sleep) disesuaikan agar tidak terjadi Race Condition atau App Crash.