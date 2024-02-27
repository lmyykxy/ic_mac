def hex_to_float_16(hex_string):
    # 将16进制字符串转换为整数
    hex_int = int(hex_string, 16)

    # 获取符号位、指数位和尾数位
    sign = (hex_int >> 15) & 0x1
    exponent = (hex_int >> 10) & 0x1F
    fraction = hex_int & 0x3FF

    # 根据IEEE 754规范计算浮点数
    if exponent == 0:
        # 非规格化数
        result = (-1) ** sign * 2 ** -14 * (fraction / 2 ** 10)
    elif exponent == 0x1F:
        # 无穷大或NaN，这里简化处理为无穷大
        result = float('inf') if fraction == 0 else float('nan')
    else:
        # 规格化数
        result = (-1) ** sign * 2 ** (exponent - 15) * (1 + fraction / 2 ** 10)

    return result

# 例子
hex_value = "4510"
decimal_value = hex_to_float_16(hex_value)
print(decimal_value)
