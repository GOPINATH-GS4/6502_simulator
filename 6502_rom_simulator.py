import serial
import sys
import os

class W65C02:

	def __init__(self, serial_port,  file):
		self.address = None
		self.data = None
		self.read_write = None
		self.arduino = serial.Serial(serial_port, 57600, timeout=.1)
		self.memmap = bytearray(self.read_code(file))
		lsb = self.memmap[len(self.memmap) - 4]
		hsb = self.memmap[len(self.memmap) - 3]
		hx = hsb << 8 + lsb
		self.addr_offset = hx
		print("Communication initialized ... Address offset = " + hex(self.addr_offset))
		self.arduino.write("RESET".encode());
		self.arduino.write("\n".encode())
		self.arduino.flush()
		
	def read_message(self):
		msg = self.arduino.readline()[:-2]
		strdata = msg.decode('utf-8')
		return strdata


	def write_data(self):
		self.arduino.write(str(self.memmap[self.address - self.addr_offset]).encode())
		self.arduino.write("\n".encode())
		self.arduino.flush()


	def write_local_data(self):
		self.memmap[self.address - self.addr_offset] = self.data
		self.arduino.write("\n".encode())
		self.arduino.flush()


	def read_code(self, filename):
		return open(filename, "rb").read()


	def process_message(self, msg):
		if msg.find('[OUT]:') != -1:
			self.address = int(msg[6:10], 16)
			self.read_write = msg[11:12]
			self.data = int(msg[13:], 16)
			print(">> Instruction Address : " + hex(self.address) + " Instruction / Data  : "  + hex(self.memmap[self.address - self.addr_offset]))
			if self.read_write == 'R':
				self.write_data()
			elif self.read_write == 'W' or self.read_write == 'X':
				self.write_local_data()
		else:
			print(" << " + msg)
	def run_loop(self):
		while True: 
			data = self.read_message()
			if data:
				self.process_message(data)

if __name__ == '__main__':

	if len(sys.argv) - 1 < 2:
		print("Usage python3 6502_rom.py \"Serial Port for data \" \"bin file\" ")
		sys.exit(1)
	w65c02 = W65C02(sys.argv[1], sys.argv[2])
	w65c02.run_loop()	
