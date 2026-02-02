📦 UPDATE: BYPASS AUTORUN V.1 

Ini hanyalah script biasa untuk menjalankan bypass pubg menggunakan "NoRoot Firewall". Bagi kalian yang menggunakan app itu untuk melakukan bypass di PUBG dan malas harus membuka dan menutup aplikasi kalian. Ini script yang cocok untuk anda, semoga membantu.
Saya juga menambahkan script untuk membersihkan cache dan kill app "NoRoot Firewall" dan app "PUBG" yang masih berjalan di latar belakang.Terimakasih 

📂 File Name: bypass_autorun_v.2.zip
🛠 Status: STABLE & TESTED
🚀 Changelog V.2:

    [New] Universal Logic: Menggunakan metode Event-Driven Waiting. Tidak lagi bergantung pada koordinat pixel (Anti-Meleset di semua resolusi layar).

    [New] Nuclear Cleaner: Deep cleaning cache sistem via nsenter & pm trim-caches. Sapu bersih jejak shader dan log secara tuntas.

    [Fix] Xiaomi Anti-Restart: Ditambahkan logika ip link set tun0 down untuk mencegah Cloudflare/VPN lain melakukan auto-start yang bisa menendang Firewall.

    [Fix] Process Killer: Penambahan killall -9 vpnserv untuk memastikan Firewall mati total saat cleaner dijalankan (No more Lag!).

    [Optimized] Stability: Jeda waktu (sleep) disesuaikan agar tidak terjadi Race Condition atau App Crash.