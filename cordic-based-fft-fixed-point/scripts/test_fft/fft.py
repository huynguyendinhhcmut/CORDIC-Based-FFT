import numpy as np
import matplotlib.pyplot as plt

# ==========================================
# 1. CẤU HÌNH FIXED POINT (Q16.16)
# ==========================================
# Q16.16: 1 bit dấu (trong phần int), 15 bit nguyên, 16 bit thập phân
FRACTION_BITS = 16
SCALE_FACTOR = 1 << FRACTION_BITS  # 2^16 = 65536

def float_to_fixed(val_float):
    """Chuyển float sang số nguyên fixed-point"""
    # Nhân với 2^16 và ép kiểu về int
    val_fixed = int(val_float * SCALE_FACTOR)
    
    # (Tùy chọn) Saturation: Giới hạn trong khoảng 32-bit có dấu
    max_val = (1 << 31) - 1
    min_val = -(1 << 31)
    if val_fixed > max_val: val_fixed = max_val
    if val_fixed < min_val: val_fixed = min_val
    
    return val_fixed

def fixed_to_hex(val_fixed):
    """Chuyển số nguyên fixed-point sang Hex 32-bit (Bù 2)"""
    # & 0xFFFFFFFF để xử lý số âm (Bù 2) cho đúng format 32-bit
    return hex(val_fixed & 0xFFFFFFFF)[2:].zfill(8)

def fixed_to_float(val_fixed):
    """Chuyển ngược lại float để vẽ đồ thị kiểm tra"""
    return val_fixed / SCALE_FACTOR

# ==========================================
# 2. CẤU HÌNH TÍN HIỆU
# ==========================================
fs = 100_000            # 100 kHz
points_per_frame = 1024 
num_frames = 2          
total_points = points_per_frame * num_frames 

np.random.seed(42)      

t = np.arange(total_points) / fs

# --- TẠO 2 SÓNG (FLOATING POINT GỐC) ---
t1 = t[:points_per_frame]
sig_frame1 = 1.0 * np.sin(2 * np.pi * 2_000 * t1)

t2 = t[points_per_frame:]
sig_frame2 = 0.5 * np.sin(2 * np.pi * 10_000 * t2)

sig_clean = np.concatenate((sig_frame1, sig_frame2))

# --- THÊM NHIỄU ---
interference = 0.3 * np.sin(2 * np.pi * 24_600 * t)
noise = np.random.normal(0, 0.2, total_points)

signal_float = sig_clean + interference + noise

# ==========================================
# 3. CHUYỂN ĐỔI SANG FIXED POINT VÀ GHI FILE
# ==========================================
file_name = "fft_input_fixed_Q16_16.txt"

# Tạo mảng chứa giá trị Fixed Point (số nguyên)
signal_fixed = [float_to_fixed(x) for x in signal_float]

print(f"Đang xử lý {total_points} điểm dữ liệu (Fixed Point Q16.16)...")

with open(file_name, "w") as f_out:
    for val in signal_fixed:
        val_hex = fixed_to_hex(val)
        f_out.write(f"{val_hex}\n")

print(f"-> Đã ghi file hex: {file_name}")

# ==========================================
# 4. VẼ ĐỒ THỊ KIỂM TRA (DÙNG DỮ LIỆU ĐÃ QUANTIZE)
# ==========================================
# Lưu ý: Chúng ta convert ngược từ Fixed Point về Float để vẽ
# Điều này giúp bạn thấy được sai số lượng tử hóa (nếu có)
signal_restored = np.array([fixed_to_float(x) for x in signal_fixed])

# Tính FFT trên tín hiệu đã lượng tử hóa
fft_values = np.fft.fft(signal_restored)
frequencies = np.fft.fftfreq(total_points, 1/fs) / 1e3 # kHz
magnitude = np.abs(fft_values) * 2 / total_points

plt.figure(figsize=(14, 8))

# --- HÌNH 1: MIỀN THỜI GIAN (FIXED POINT VISUALIZATION) ---
plt.subplot(2, 1, 1)
plt.plot(t * 1e3, signal_restored, color='#2c3e50', linewidth=1, label='Fixed-Point Signal')
plt.axvline(x=t[points_per_frame]*1e3, color='red', linestyle='--', linewidth=2)
plt.text(5.0, 2.5, "FRAME 1 (2 kHz)\n(Quantized)", color='green', fontweight='bold', ha='center')
plt.text(15.0, 2.5, "FRAME 2 (10 kHz)\n(Quantized)", color='green', fontweight='bold', ha='center')

plt.title(f"FIXED POINT Q16.16 SIGNAL (Mô phỏng phần cứng)")
plt.xlabel("Thời gian (ms)")
plt.ylabel("Biên độ (Thực)")
plt.grid(True, alpha=0.3)

# --- HÌNH 2: MIỀN TẦN SỐ ---
plt.subplot(2, 1, 2)
plt.plot(frequencies[:total_points//2], magnitude[:total_points//2], color='#d35400')
plt.title("PHỔ TẦN SỐ (Từ dữ liệu Fixed Point)")
plt.xlabel("Tần số (kHz)")
plt.ylabel("Biên độ")
plt.xlim(0, 50)
plt.grid(True, alpha=0.3)

# Annotate
plt.annotate('2 kHz', xy=(2, 0.8), xytext=(2, 1.0), arrowprops=dict(facecolor='green', shrink=0.05))
plt.annotate('10 kHz', xy=(10, 0.4), xytext=(10, 0.6), arrowprops=dict(facecolor='green', shrink=0.05))

plt.tight_layout()
plt.show()

# In thử vài giá trị để kiểm tra
print("\n--- Mẫu dữ liệu chuyển đổi ---")
print(f"{'Float Gốc':<15} | {'Fixed Int':<15} | {'Hex (Q16.16)':<15} | {'Float Hồi phục':<15}")
print("-" * 70)
for i in range(5):
    f_val = signal_float[i]
    fix_val = signal_fixed[i]
    h_val = fixed_to_hex(fix_val)
    r_val = signal_restored[i]
    print(f"{f_val:<15.6f} | {fix_val:<15} | {h_val:<15} | {r_val:<15.6f}")
