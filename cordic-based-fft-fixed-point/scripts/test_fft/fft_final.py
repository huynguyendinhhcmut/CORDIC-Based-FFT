import re
import numpy as np
import matplotlib.pyplot as plt

# ==========================================
# 1. CẤU HÌNH & ĐỌC DỮ LIỆU TỪ FILE
# ==========================================
INPUT_FILE = "/home/nguyendinhhuy/rtl/cordic-based-fft-fixed-point/sim/output_fft.txt"

print(f"Đang đọc dữ liệu từ: {INPUT_FILE} ...")

try:
    with open(INPUT_FILE, "r") as f:
        raw_log_data = f.read()
    print(f"-> Đã đọc thành công {len(raw_log_data.splitlines())} dòng.")
except FileNotFoundError:
    print(f"LỖI: Không tìm thấy file tại {INPUT_FILE}")
    print("Vui lòng kiểm tra lại đường dẫn.")
    raw_log_data = "" # Gán rỗng để tránh lỗi crash sau đó

# ==========================================
# 2. CẤU HÌNH HỆ THỐNG
# ==========================================
FS = 100000.0   # 100 kHz
N_POINT = 1024  # FFT 1024 điểm

# ==========================================
# 3. HÀM XỬ LÝ (Q16.16 & PARSING)
# ==========================================
def hex_to_q16_16(hex_str):
    val = int(hex_str, 16)
    if val & (1 << 31): # Xử lý số âm (Bù 2)
        val -= 1 << 32
    return val / 65536.0 # Chia cho 2^16

def parse_and_reconstruct(log_data):
    pattern = re.compile(r"Pair\s+(\d+)\s+\|\s+A_Re:\s+([0-9a-fA-F]+)\s+\|\s+B_Re:\s+([0-9a-fA-F]+)\s+\|\s+\(Imag\s+A:\s+([0-9a-fA-F]+),\s+B:\s+([0-9a-fA-F]+)\)")
    
    frame1 = np.zeros(N_POINT, dtype=np.complex128)
    frame2 = np.zeros(N_POINT, dtype=np.complex128)
    stride = 512 
    
    lines_processed = 0
    for line in log_data.strip().split('\n'):
        match = pattern.search(line)
        if match:
            pair_idx = int(match.group(1))
            a_re = hex_to_q16_16(match.group(2))
            b_re = hex_to_q16_16(match.group(3))
            a_im = hex_to_q16_16(match.group(4))
            b_im = hex_to_q16_16(match.group(5))
            
            val_A = complex(a_re, a_im)
            val_B = complex(b_re, b_im)
            
            if pair_idx < 512:
                frame1[pair_idx] = val_A
                frame1[pair_idx + stride] = val_B
            else:
                relative_idx = pair_idx - 512
                frame2[relative_idx] = val_A
                frame2[relative_idx + stride] = val_B
            lines_processed += 1
    return frame1, frame2

def get_peak_frequency(fft_data, fs, n_points):
    """Tìm tần số có biên độ lớn nhất"""
    magnitude = np.abs(fft_data)
    # Bỏ qua thành phần DC (index 0) để tìm tín hiệu chính xác hơn
    peak_idx = np.argmax(magnitude[1:]) + 1 
    peak_freq = peak_idx * (fs / n_points)
    return peak_freq, magnitude[peak_idx]

# ==========================================
# 4. CHẠY VÀ VẼ ĐỒ THỊ
# ==========================================

if raw_log_data:
    fft_f1, fft_f2 = parse_and_reconstruct(raw_log_data)

    # Tạo trục tần số (x-axis)
    # Từ 0 đến Fs, chia làm 1024 điểm
    freq_axis = np.linspace(0, FS, N_POINT, endpoint=False)
    freq_axis_khz = freq_axis / 1000.0  # Đổi sang kHz

    # Tìm đỉnh tín hiệu (Peak Detection)
    peak_f1, mag_f1 = get_peak_frequency(fft_f1, FS, N_POINT)
    peak_f2, mag_f2 = get_peak_frequency(fft_f2, FS, N_POINT)

    print(f"\n--- KẾT QUẢ PHÂN TÍCH TẦN SỐ (FS = {FS/1000} kHz) ---")
    print(f"Frame 1 Peak: {peak_f1/1000:.2f} kHz (Biên độ: {mag_f1:.2f})")
    print(f"Frame 2 Peak: {peak_f2/1000:.2f} kHz (Biên độ: {mag_f2:.2f})")

    # Vẽ đồ thị
    plt.figure(figsize=(12, 10))

    # Frame 1
    plt.subplot(2, 1, 1)
    plt.plot(freq_axis_khz, np.abs(fft_f1))
    plt.title(f"Frame 1 Spectrum")
    plt.ylabel("Magnitude (Q16.16)")
    plt.grid(True, linestyle='--', alpha=0.6)
    # Chỉ hiển thị đến Fs/2 (Nyquist) nếu muốn zoom vào phần có ích
    # plt.xlim(0, FS/2/1000) 

    # Frame 2
    plt.subplot(2, 1, 2)
    plt.plot(freq_axis_khz, np.abs(fft_f2), color='orange')
    plt.title(f"Frame 2 Spectrum")
    plt.xlabel("Frequency (kHz)")
    plt.ylabel("Magnitude (Q16.16)")
    plt.grid(True, linestyle='--', alpha=0.6)

    plt.tight_layout()
    plt.show()
