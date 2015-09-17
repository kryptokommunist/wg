class Mate < ActiveRecord::Base
	validates :first_name, uniqueness: true
	validates :last_name, uniqueness: true
	validates :mobile_number, uniqueness: true
	validates :chat_id, uniqueness: true, allow_nil: true

	has_many :duties

	# return the current open duty
	def current_duty
		self.duties.find_by(accomplished_at: nil)
	end

  # returns next area_id out of 1..3
	def next_area_id
		next_id = self.current_duty.area.id + 1
		return next_id if (next_id <= 4)
		return 1
	end

	# notifies all mates exept the given, that a task was completed
	def notify(duty)

		Thread.new do

			maocit = File.read('data/maobibel.txt').split('+')
			last_i = maocit.length - 1

			Mate.all.each do |other_mate|
				if other_mate != self

					cit = maocit[Random.rand(last_i)]
					time = Time.zone.now.strftime('%H:%M')
					mao = 'Es ist ' + time + ' Uhr.' + "\nDas Mao-Zitat der Stunde enstammt der Quelle: " + cit
					planned = ""
					planned = "Diese Aufgabe war übrigens nicht geplant!"  if duty.due_to.nil?
					message = """\nHi #{other_mate.first_name},\n#{mate.first_name} hat grade folgendes gemacht: #{duty.area.name}.\n#{planned}\nEr hat nun #{mate.points} Punkte.\nDu hast #{other_mate.points} Punkte!\nLink: #{root_url + "##{other_mate.first_name.downcase}"}\n\n#{mao}"""
					send_message(other_mate.chat_id, message)
				end
			end

		end
	end

end
