import socket
import base64
import os
import time


class MySocket(object):

	def __init__(self, buf_size, tcp_ip, tcp_port):
		self.tcp_ip = tcp_ip
		self.buf_size = buf_size
		self.tcp_port = tcp_port

	def create_socket(self):
		self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		self.s.bind((self.tcp_ip, self.tcp_port))
		self.s.listen()
		print('listening')

	def run(self):
		while True:
			conn, addr = self.s.accept()

			timestr = time.strftime("%Y%m%d-%H%M%S")
			file = open(f'../images/{timestr}.png', 'wb')
			print(f'Connection address: {addr}')

			data = conn.recv(self.buf_size)
			file.write(data)

			while data != b'':
				data = conn.recv(self.buf_size)
				file.write(data)

			file.close()
			conn.close()

if __name__ == '__main__':
	new_socket = MySocket(buf_size=1024, tcp_ip='192.168.1.128', tcp_port=1543)
	new_socket.create_socket()
	new_socket.run()
