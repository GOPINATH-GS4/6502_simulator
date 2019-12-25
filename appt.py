class Appt:

	def __init__(self, title, start_time, duration):
		self.title = title
		self.start_time = start_time
		self.participant_list = []
		self.end_time = self.start_time + duration

	def __repr__(self):
		return self.title + " " + str(self.start_time) + " " + str(self.end_time)

	def add_participant(self, email_address):
		self.participant_list.append(email_address)
		return str(self)

	def send_update(self):
		for i in self.participant_list:
			print("Sending " + str(self) + " to " + i)

class Calendar:

	def __init__(self, email_address):
		self.email_address = email_address
		self.appointments = []

	def add_appt(self, title, start_time, duration):
		appt = Appt(title, start_time, duration)
		appt.add_participant(self.email_address)
		self.appointments.append(appt)
		
		appt.send_update()

	def check_for_conflict(self):
		
		for i in range(len(self.appointments)):
			first_val = self.appointments[i];
			for j in range(i+1, len(self.appointments)):
				next_val = self.appointments[j];
				if (first_val.start_time >= next_val.start_time and first_val.start_time <= next_val.end_time) or (first_val.end_time >= next_val.start_time and first_val.end_time <= next_val.end_time):
					print("Appoint " + first_val.title + " conflicts with " + next_val.title); 

def main():

	cal = Calendar("gopi@gmail.com")
	cal.add_appt("MTG 1" , 100, 20);
	cal.add_appt("MTG 2" , 125 , 30);
	cal.add_appt("MTG 3", 150, 20);
	cal.add_appt("MTG 4", 150, 20);
	cal.check_for_conflict()

main()
