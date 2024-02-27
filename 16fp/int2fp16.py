import struct

def float_to_hex(float_value):
    # 使用struct.pack将10进制的半精度浮点数转换为bytes对象
    hex_bytes = struct.pack('<e', float_value)

    # 将bytes对象转换为16进制字符串
    hex_string = hex(int.from_bytes(hex_bytes, byteorder='little'))

    return hex_string

# 示例
decimal_value = 0.4
hex_value = float_to_hex(decimal_value)
print(f"10进制: {decimal_value}, 16进制: {hex_value}")
