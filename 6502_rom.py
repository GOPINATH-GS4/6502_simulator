import serial
import time
import codecs
import sys
import os


def read_code(filename):  
    return open(filename, "rb").read() 

def parse_instruction(data):

    if data.find('[MSG]:') != -1 :
        read_write = data[6:7]
        return ("Message", data[8:],read_write)
    elif data.find('[ADDR]:') != -1:
        read_write = data[7:8]
        return ("Address", int(data[9:]), read_write);
    elif data.find('[DATA]:') != -1:
        read_write = data[7:8]
        return ("Data", int(data[9:]), read_write)
    else:
        return ("Unknown", data, 'r')

def set_clock_speed(clock_speed):

    print("Setting Clock speed to " + clock_speed)
    arduino.write(str(clock_speed).encode())
    arduino.write("\n".encode())
    arduino.flush();

def process_instructions(dtype, data,  memmap, read_write, write_addr):

    if dtype == "Address":
        if read_write == 'r':
            print("Address : " + hex(data) + " Contents : "  + hex(memmap[data - 0x8000]) + " read_write " + read_write)
        if read_write == 'W':
            write_addr = data 
            print("Address : " + hex(write_addr) + " Contents : "  + hex(memmap[write_addr]) + " read_write " + read_write)
        arduino.write(str(memmap[data - 0x8000]).encode())
        arduino.write("\n".encode())
        arduino.flush();
    elif dtype == "Message":
        print("Message : " +  data);
    elif dtype == "Data":
        print("Data : {0:4s}".format(hex(data)))
        if read_write == 'W':
            print("Writing data to :" + hex(write_addr) + " Contents : " + hex(data) + " read_write " + read_write )
            #memmap[write_addr - 0x8000] = data
            #arduino.write("\n".encode())
            #arduino.flush();
    else:
        print("Unkown : " +  data);
    return

if __name__ == '__main__': 
    
    read_write = None;
    write_addr = 0x9000;
    if len(sys.argv) -1 != 2 : 
        print("Usage python3 6502_rom.py \"Serial Port for data \" \"bin file\" ")
        sys.exit(1)

    clock_speed = os.getenv('CLOCK_SPEED') 
    if clock_speed is None: 
        clock_speed = "10"
    arduino = serial.Serial(sys.argv[1], 57600, timeout=.1)
    memmap = bytearray(read_code(sys.argv[2]))

    while True:
        data = arduino.readline()[:-2]
        strdata = data.decode('utf-8')
        if data:
            dtype, instruction,read_write = parse_instruction(strdata)
            if dtype == 'Address' and read_write == 'W': 
                print('Assigning write_addr = ' + hex(instruction))
                write_addr = instruction
            process_instructions(dtype, instruction,  memmap, read_write, write_addr)
            #set_clock_speed('CLOCK:' + clock_speed)
            
    arduino.close();
