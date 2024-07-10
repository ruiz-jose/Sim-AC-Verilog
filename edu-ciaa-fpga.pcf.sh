# Archivo: edu-ciaa-fpga.pcf
# Este es un ejemplo básico y deberás modificarlo según tu diseño y la FPGA específica.

# Mapeo de pines de reloj
set_io clk_i P3

# Mapeo de pines para señales de entrada/salida
set_io reset_i P4
set_io reg_acc_o[0] P5
set_io reg_acc_o[1] P6
set_io reg_acc_o[2] P7
set_io reg_acc_o[3] P8
set_io reg_acc_o[4] P9
set_io reg_acc_o[5] P10
set_io reg_acc_o[6] P11
set_io reg_acc_o[7] P12

# Asegúrate de consultar la documentación de tu FPGA para obtener los nombres correctos de los pines