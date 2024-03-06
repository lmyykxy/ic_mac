from func import signed_extended, unsigned_extended, csa_compute, print_hex, bin2int

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
pp1 = signed_extended(pp1,unsign_width=34,ext_sign_width=38,if_str=0)
pp2 = signed_extended(pp2,unsign_width=34,ext_sign_width=38,if_str=0)[2:]+'00'
pp3 = signed_extended(pp3,unsign_width=34,ext_sign_width=38,if_str=0)[4:]+'0000'
# CSA A11
A11_s,A11_c = csa_compute(pp1,pp2,pp3)
print_hex(A11_s,'A11_s')
print_hex(A11_c,'A11_c')


# A12
pp4 = signed_extended(pp4,unsign_width=34,ext_sign_width=38,if_str=0)
pp5 = signed_extended(pp5,unsign_width=34,ext_sign_width=38,if_str=0)[2:]+'00'
pp6 = signed_extended(pp6,unsign_width=34,ext_sign_width=38,if_str=0)[4:]+'0000'
# CSA A11
A12_s,A12_c = csa_compute(pp4,pp5,pp6)
print_hex(A12_s,'A12_s')
print_hex(A12_c,'A12_c')


# A13
pp7 = signed_extended(pp7,unsign_width=34,ext_sign_width=38,if_str=0)
pp8 = signed_extended(pp8,unsign_width=34,ext_sign_width=38,if_str=0)[2:]+'00'
pp9 = signed_extended(pp9,unsign_width=34,ext_sign_width=38,if_str=0)[4:]+'0000'
# CSA A11
A13_s,A13_c = csa_compute(pp7,pp8,pp9)
print_hex(A13_s,'A13_s')
print_hex(A13_c,'A13_c')


# A14
pp10 = signed_extended(pp10,unsign_width=34,ext_sign_width=38,if_str=0)
pp11 = signed_extended(pp11,unsign_width=34,ext_sign_width=38,if_str=0)[2:]+'00'
pp12 = signed_extended(pp12,unsign_width=34,ext_sign_width=38,if_str=0)[4:]+'0000'
# CSA A11
A14_s,A14_c = csa_compute(pp10,pp11,pp12)
print_hex(A14_s,'A14_s')
print_hex(A14_c,'A14_c')


# A15
pp13 = signed_extended(pp13,unsign_width=34,ext_sign_width=38,if_str=0)
pp14 = signed_extended(pp14,unsign_width=34,ext_sign_width=38,if_str=0)[2:]+'00'
pp15 = signed_extended(pp15,unsign_width=34,ext_sign_width=38,if_str=0)[4:]+'0000'
# CSA A11
A15_s,A15_c = csa_compute(pp13,pp14,pp15)
print_hex(A15_s,'A15_s')
print_hex(A15_c,'A15_c')



print('---------------------------------------------------')


# A21
A11_s = signed_extended(A11_s,unsign_width=38,ext_sign_width=44)
A11_c = signed_extended(A11_c,unsign_width=38,ext_sign_width=44)[1:]+'0'
A12_s = signed_extended(A12_s,unsign_width=38,ext_sign_width=44)[6:]+'000000'
# CSA A11
A21_s,A21_c = csa_compute(A11_s,A11_c,A12_s)
print_hex(A21_s,'A21_s')
print_hex(A21_c,'A21_c')


# A22
A12_c = signed_extended(A12_c,unsign_width=38,ext_sign_width=44)
A13_s = signed_extended(A13_s,unsign_width=38,ext_sign_width=44)[5:]+'00000'
A13_c = signed_extended(A13_c,unsign_width=38,ext_sign_width=44)[6:]+'000000'
# CSA A11
A22_s,A22_c = csa_compute(A12_c,A13_s,A13_c)
print_hex(A22_s,'A22_s')
print_hex(A22_c,'A22_c')