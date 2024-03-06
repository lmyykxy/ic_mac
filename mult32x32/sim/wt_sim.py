from func import full_compute, str_sft_pad0, signed_extended, unsigned_extended, csa_compute, print_hex, bin2int

pp1 =0x37b7b29f7
pp2 =0x8484d609
pp3 =0x2f6f653ee
pp4 =0x10909ac12
pp5 =0x2f6f653ee
pp6 =0x10909ac12
pp7 =0x8484d609
pp8 =0x8484d609
pp9 =0
pp10=0
pp11=0x37b7b29f7
pp12=0
pp13=0x10909ac12
pp14=0
pp15=0x37b7b29f7
pp16=0x37b7b29f7
pp17=0x8484d609

# A11
pp1 = str_sft_pad0(signed_extended(pp1,unsign_width=34,ext_sign_width=38,if_str=0))
pp2 = str_sft_pad0(signed_extended(pp2,unsign_width=34,ext_sign_width=38,if_str=0),2)
pp3 = str_sft_pad0(signed_extended(pp3,unsign_width=34,ext_sign_width=38,if_str=0),4)
# CSA
A11_s,A11_c = csa_compute(pp1,pp2,pp3)
print_hex(A11_s,'A11_s')
print_hex(A11_c,'A11_c')


# A12
pp4 = str_sft_pad0(signed_extended(pp4,unsign_width=34,ext_sign_width=38,if_str=0))
pp5 = str_sft_pad0(signed_extended(pp5,unsign_width=34,ext_sign_width=38,if_str=0),2)
pp6 = str_sft_pad0(signed_extended(pp6,unsign_width=34,ext_sign_width=38,if_str=0),4)
# CSA
A12_s,A12_c = csa_compute(pp4,pp5,pp6)
print_hex(A12_s,'A12_s')
print_hex(A12_c,'A12_c')


# A13
pp7 = str_sft_pad0(signed_extended(pp7,unsign_width=34,ext_sign_width=38,if_str=0))
pp8 = str_sft_pad0(signed_extended(pp8,unsign_width=34,ext_sign_width=38,if_str=0),2)
pp9 = str_sft_pad0(signed_extended(pp9,unsign_width=34,ext_sign_width=38,if_str=0),4)
# CSA
A13_s,A13_c = csa_compute(pp7,pp8,pp9)
print_hex(A13_s,'A13_s')
print_hex(A13_c,'A13_c')


# A14
pp10 = str_sft_pad0(signed_extended(pp10,unsign_width=34,ext_sign_width=38,if_str=0))
pp11 = str_sft_pad0(signed_extended(pp11,unsign_width=34,ext_sign_width=38,if_str=0),2)
pp12 = str_sft_pad0(signed_extended(pp12,unsign_width=34,ext_sign_width=38,if_str=0),4)
# CSA
A14_s,A14_c = csa_compute(pp10,pp11,pp12)
print_hex(A14_s,'A14_s')
print_hex(A14_c,'A14_c')


# A15
pp13 = str_sft_pad0(signed_extended(pp13,unsign_width=34,ext_sign_width=38,if_str=0))
pp14 = str_sft_pad0(signed_extended(pp14,unsign_width=34,ext_sign_width=38,if_str=0),2)
pp15 = str_sft_pad0(signed_extended(pp15,unsign_width=34,ext_sign_width=38,if_str=0),4)
# CSA
A15_s,A15_c = csa_compute(pp13,pp14,pp15)
print_hex(A15_s,'A15_s')
print_hex(A15_c,'A15_c')



print('---------------------------------------------------')


# A21
A11_s = str_sft_pad0(signed_extended(A11_s,unsign_width=38,ext_sign_width=44))
A11_c = str_sft_pad0(signed_extended(A11_c,unsign_width=38,ext_sign_width=44),1)
A12_s = str_sft_pad0(signed_extended(A12_s,unsign_width=38,ext_sign_width=44),6)
# CSA
A21_s,A21_c = csa_compute(A11_s,A11_c,A12_s)
print_hex(A21_s,'A21_s')
print_hex(A21_c,'A21_c')


# A22
A12_c = str_sft_pad0(signed_extended(A12_c,unsign_width=38,ext_sign_width=44))
A13_s = str_sft_pad0(signed_extended(A13_s,unsign_width=38,ext_sign_width=44),5)
A13_c = str_sft_pad0(signed_extended(A13_c,unsign_width=38,ext_sign_width=44),6)
# CSA
A22_s,A22_c = csa_compute(A12_c,A13_s,A13_c)
print_hex(A22_s,'A22_s')
print_hex(A22_c,'A22_c')


# A23
A14_s = str_sft_pad0(signed_extended(A14_s,unsign_width=38,ext_sign_width=44))
A14_c = str_sft_pad0(signed_extended(A14_c,unsign_width=38,ext_sign_width=44),1)
A15_s = str_sft_pad0(signed_extended(A15_s,unsign_width=38,ext_sign_width=44),6)
# CSA
A23_s,A23_c = csa_compute(A14_s,A14_c,A15_s)
print_hex(A23_s,'A23_s')
print_hex(A23_c,'A23_c')


# A24
A15_c = str_sft_pad0(signed_extended(A15_c,unsign_width=38,ext_sign_width=39))
pp16  = str_sft_pad0(signed_extended(pp16 ,unsign_width=34,ext_sign_width=39,if_str=0),5)
pp17  = str_sft_pad0(signed_extended(pp17 ,unsign_width=34,ext_sign_width=39,if_str=0),7)
# CSA
A24_s,A24_c = csa_compute(A15_c,pp16,pp17)
print_hex(A24_s,'A24_s')
print_hex(A24_c,'A24_c')



print('---------------------------------------------------')


# A31
A21_s = str_sft_pad0(signed_extended(A21_s,unsign_width=44,ext_sign_width=51))
A21_c = str_sft_pad0(signed_extended(A21_c,unsign_width=44,ext_sign_width=51),1)
A22_s = str_sft_pad0(signed_extended(A22_s,unsign_width=44,ext_sign_width=51),7)
# CSA
A31_s,A31_c = csa_compute(A21_s,A21_c,A22_s)
print_hex(A31_s,'A31_s')
print_hex(A31_c,'A31_c')


# A32
A22_c = str_sft_pad0(signed_extended(A22_c,unsign_width=44,ext_sign_width=55))
A23_s = str_sft_pad0(signed_extended(A23_s,unsign_width=44,ext_sign_width=55),10)
A23_c = str_sft_pad0(signed_extended(A23_c,unsign_width=44,ext_sign_width=55),11)
# CSA
A32_s,A32_c = csa_compute(A22_c,A23_s,A23_c)
print_hex(A32_s,'A32_s')
print_hex(A32_c,'A32_c')



print('---------------------------------------------------')



# A41
A31_s = str_sft_pad0(signed_extended(A31_s,unsign_width=51,ext_sign_width=63))
A31_c = str_sft_pad0(signed_extended(A31_c,unsign_width=51,ext_sign_width=63),1)
A32_s = str_sft_pad0(signed_extended(A32_s,unsign_width=55,ext_sign_width=63),8)
# CSA
A41_s,A41_c = csa_compute(A31_s,A31_c,A32_s)
print_hex(A41_s,'A41_s')
print_hex(A41_c,'A41_c')


# A42
A32_c = str_sft_pad0(signed_extended(A32_c,unsign_width=55,ext_sign_width=55))
A24_s = str_sft_pad0(signed_extended(A24_s,unsign_width=39,ext_sign_width=55),16)
A24_c = str_sft_pad0(signed_extended(A24_c,unsign_width=39,ext_sign_width=55),17)
# CSA
A42_s,A42_c = csa_compute(A32_c,A24_s,A24_c)
print_hex(A42_s,'A42_s')
print_hex(A42_c,'A42_c')



print('---------------------------------------------------')


# A51
A41_s = str_sft_pad0(signed_extended(A41_s,unsign_width=63,ext_sign_width=64))
A41_c = str_sft_pad0(signed_extended(A41_c,unsign_width=63,ext_sign_width=64),1)
A42_s = str_sft_pad0(signed_extended(A42_s,unsign_width=55,ext_sign_width=64),9)
# CSA
A51_s,A51_c = csa_compute(A41_s,A41_c,A42_s)
print_hex(A51_s,'A51_s')
print_hex(A51_c,'A51_c')



print('---------------------------------------------------')

# A61
A51_s = str_sft_pad0(signed_extended(A51_s,unsign_width=64,ext_sign_width=64))
A51_c = str_sft_pad0(signed_extended(A51_c,unsign_width=64,ext_sign_width=64),1)
A42_c = str_sft_pad0(signed_extended(A42_c,unsign_width=55,ext_sign_width=64),10)
# CSA
A61_s,A61_c = csa_compute(A51_s,A51_c,A42_c)
print_hex(A61_s,'A61_s')
print_hex(A61_c,'A61_c')




print('---------------------------------------------------')

# Full add
A61_s = str_sft_pad0(signed_extended(A61_s,unsign_width=64,ext_sign_width=64))
A61_c = str_sft_pad0(signed_extended(A61_c,unsign_width=64,ext_sign_width=64),1)
# CSA
out = full_compute(A61_s,A61_c)
print_hex(out,'out')

