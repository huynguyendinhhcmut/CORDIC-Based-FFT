import re
import math
import struct

# ==========================================
# 1. CẤU HÌNH
# ==========================================
# Đổi tên file nếu cần
INPUT_FILE = "/home/nguyendinhhuy/rtl/cordic-based-fft-fixed-point/sim/output_cordic.txt"

# Hệ số tỉ lệ Q16.16
SCALE_FACTOR = 1 << 16  # 65536

# Ngưỡng sai số chấp nhận được (Absolute Error)
# 1 LSB = 1/65536 ~= 0.000015
# CORDIC thường có sai số tích lũy, cho phép khoảng 5 LSB
TOLERANCE = 8.0 / SCALE_FACTOR 

# ==========================================
# 2. HÀM HỖ TRỢ
# ==========================================
def hex_to_q16_16(hex_str):
    """Chuyển Hex string (32-bit) sang số thực float (Q16.16 Signed)."""
    try:
        # Xử lý chuỗi hex (loại bỏ ký tự lạ)
        clean_hex = hex_str.strip().lower().replace("_", "")
        val_int = int(clean_hex, 16)
        
        # Xử lý số âm (Signed 32-bit: bù 2)
        if val_int >= 0x80000000:
            val_int -= 0x100000000
            
        return val_int / SCALE_FACTOR
    except ValueError:
        return None

def parse_cordic_file(filename):
    """Đọc file log và trích xuất dữ liệu từng Test Case."""
    results = []
    current_case = {}
    
    # Regex patterns để bắt dữ liệu
    regex_case  = r"TEST CASE (\d+)"
    regex_angle = r"Angle:.*\(Hex:\s*([0-9a-fA-F]+)\)"
    regex_sin   = r"Sin\s*:.*\(Hex:\s*([0-9a-fA-F]+)\)"
    regex_cos   = r"Cos\s*:.*\(Hex:\s*([0-9a-fA-F]+)\)"

    try:
        with open(filename, 'r') as f:
            lines = f.readlines()
            
        for line in lines:
            line = line.strip()
            
            # Bắt đầu Case mới
            match_case = re.search(regex_case, line)
            if match_case:
                if current_case: # Lưu case cũ trước khi sang case mới
                    results.append(current_case)
                current_case = {'id': int(match_case.group(1))}
                continue
            
            # Lấy Angle
            match_angle = re.search(regex_angle, line)
            if match_angle:
                current_case['angle_hex'] = match_angle.group(1)
                continue
                
            # Lấy Sin
            match_sin = re.search(regex_sin, line)
            if match_sin:
                current_case['sin_hex'] = match_sin.group(1)
                continue
                
            # Lấy Cos
            match_cos = re.search(regex_cos, line)
            if match_cos:
                current_case['cos_hex'] = match_cos.group(1)
                continue
        
        # Lưu case cuối cùng
        if current_case:
            results.append(current_case)
            
        return results
    except FileNotFoundError:
        print(f"Lỗi: Không tìm thấy file {filename}")
        return []

def verify_cordic(data):
    """So sánh kết quả mô phỏng với tính toán chuẩn của Python."""
    print(f"=== KẾT QUẢ KIỂM TRA CORDIC (Sai số cho phép: {TOLERANCE:.6f}) ===")
    print(f"{'CASE':<5} | {'ANGLE(deg)':<10} | {'SIN (SIM)':<10} | {'SIN (REF)':<10} | {'DIFF_SIN':<10} | {'COS (SIM)':<10} | {'COS (REF)':<10} | {'DIFF_COS':<10} | {'STATUS'}")
    print("-" * 115)
    
    pass_cnt = 0
    fail_cnt = 0
    
    for item in data:
        cid = item.get('id', -1)
        angle_hex = item.get('angle_hex')
        sin_hex = item.get('sin_hex')
        cos_hex = item.get('cos_hex')
        
        # Bỏ qua nếu thiếu dữ liệu
        if not (angle_hex and sin_hex and cos_hex):
            continue
            
        # 1. Chuyển đổi từ Hex Q16.16 sang Float
        angle_rad = hex_to_q16_16(angle_hex)
        sim_sin = hex_to_q16_16(sin_hex)
        sim_cos = hex_to_q16_16(cos_hex)
        
        # 2. Tính giá trị chuẩn (Reference)
        # Lưu ý: angle_rad là input thực tế đưa vào CORDIC (đã bị làm tròn Q16.16)
        ref_sin = math.sin(angle_rad)
        ref_cos = math.cos(angle_rad)
        
        # 3. Tính sai số tuyệt đối
        diff_sin = abs(sim_sin - ref_sin)
        diff_cos = abs(sim_cos - ref_cos)
        
        # 4. Đánh giá Pass/Fail
        status = "PASS"
        if diff_sin > TOLERANCE or diff_cos > TOLERANCE:
            status = "FAIL"
            fail_cnt += 1
        else:
            pass_cnt += 1
            
        # Đổi ra độ để dễ nhìn
        angle_deg = math.degrees(angle_rad)
        
        print(f"{cid:<5} | {angle_deg:<10.2f} | {sim_sin:<10.5f} | {ref_sin:<10.5f} | {diff_sin:<10.5f} | {sim_cos:<10.5f} | {ref_cos:<10.5f} | {diff_cos:<10.5f} | {status}")

    print("-" * 115)
    print(f"TỔNG SỐ CASE: {len(data)}")
    print(f"SỐ CASE PASS: {pass_cnt}")
    print(f"SỐ CASE FAIL: {fail_cnt}")

# ==========================================
# 3. MAIN
# ==========================================
if __name__ == "__main__":
    # Bước 1: Đọc file
    data_list = parse_cordic_file(INPUT_FILE)
    
    # Bước 2: Kiểm tra
    if data_list:
        verify_cordic(data_list)
    else:
        print("Không có dữ liệu để kiểm tra.")

