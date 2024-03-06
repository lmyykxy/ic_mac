class WrongBinNumError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)

class UnalignWidthError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(self.message)

def str_sft_pad0(strbin,sft_num=0):
	return strbin[sft_num:] + '0'*sft_num

def unsigned_extended(num, ext_width):
	return format(num, '0{}b'.format(ext_width))

def signed_extended(num, unsign_width, ext_sign_width, if_str=1):
	if if_str == 0:
		binary_string = unsigned_extended(num,unsign_width)
	else:
		binary_string = num

	if len(binary_string) >= ext_sign_width:
		return binary_string
    # 计算需要添加的符号位
	sign_bit = binary_string[0]
	extension_bits = sign_bit * (ext_sign_width - len(binary_string))
    # 将符号位扩展到固定位宽
	extended_binary_string = extension_bits + binary_string
	return extended_binary_string

def bin2int(bin):
	return int(bin,2)

def check_0_1(bin):
	if (bin != 0) and (bin != 1):
		raise WrongBinNumError('运算非2进制数')
	
def print_hex(binary_string, binary_string_name):
	integer_number = int(binary_string, 2)  # 将二进制字符串转换为整数
	hexadecimal_string = hex(integer_number)  # 将整数转换为十六进制字符串
	print(binary_string_name+ ': '+hexadecimal_string)


def full_adder(x,y,z):
	x = int(x)
	y = int(y)
	z = int(z)
	
	s = x ^ y ^ z
	c = (x & y) | (x & z) | (y & z)

	check_0_1(x)
	check_0_1(y)
	check_0_1(z)
	check_0_1(s)
	check_0_1(c)

	return str(s),str(c)

def csa_compute(num1,num2,num3):
	# 校验三个数据是否位宽相等
	if not len(num1)==len(num2)==len(num3):
		raise UnalignWidthError('CSA输入数据之间不等长')
	
	out_s=''
	out_c=''
	for i in range(len(num1)):
		s,c = full_adder(num1[i],num2[i],num3[i])
		out_s = out_s + s
		out_c = out_c + c

	if (len(out_s) != len(out_c)) or (len(out_s) != len(num1)):
		raise UnalignWidthError('CSA运算数据输出不等长')
	return out_s,out_c

def full_compute(num1,num2):
	# 校验三个数据是否位宽相等
	if not len(num1)==len(num2):
		raise UnalignWidthError('全加器输入数据之间不等长')
	
	out_s=''
	c = '0'
	for i in range(len(num1)):
		j = len(num1)-i-1
		s,c = full_adder(num1[j],num2[j],c)
		out_s = s + out_s

	return out_s
