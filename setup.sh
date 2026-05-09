#!/usr/bin/env bash

echo "Memulai proses update sistem..."
sudo apt update -y

echo "Menginstal Python3 dan paket yang dibutuhkan..."
sudo apt install python3 python3-pip python3-venv python3-pil -y

echo "Membuat dan mengaktifkan virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo "Menginstal paket dari requirements.txt..."
# Pastikan file requirements.txt ada di direktori tempat script ini dijalankan
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "Peringatan: File requirements.txt tidak ditemukan. Melewati proses pip install."
fi

echo "Membuat file shortcut 'dor' di /usr/local/bin/dor..."
sudo tee /usr/local/bin/dor > /dev/null << 'EOF'
#!/usr/bin/env bash

# Pindah ke folder aplikasi Anda secara otomatis
cd /root/dor || exit

# Aktifkan virtual environment
source venv/bin/activate

# Jalankan program
python3 main.py
EOF

echo "Memberikan izin eksekusi pada file 'dor'..."
sudo chmod +x /usr/local/bin/dor

echo "Setup selesai! Sekarang Anda bisa menjalankan program dengan mengetikkan perintah: dor"
