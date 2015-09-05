# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Area.create!(name: "Küche",
		     clean: false,
		     points: 1200,
		     last_cleaned: 3.days.ago
		     )
Area.create!(name: "Bad",
		     clean: false,
		     points: 1000,
		     last_cleaned: 4.days.ago
		     )
Area.create!(name: "Wz./Flur",
		     clean: true,
		     points: 400,
		     last_cleaned: 1.days.ago
		     )

Area.create!(name: "Müll",
		     clean: true,
		     points: 100,
		     last_cleaned: 1.days.ago
		     )

Area.create!(name: "Staubsauger",
		     clean: true,
		     points: 400,
		     last_cleaned: 1.days.ago
		     )

Area.create!(name: "Kühlschrank",
		     clean: true,
		     points: 800,
		     last_cleaned: 1.days.ago
		     )



marcus = Mate.create!(first_name: "Marcus",
			 last_name: "Ding",
			 mobile_number: "+4917695855565",
			 email: "marcusding@me.com",
			 chat_id: "27397086",
			 points: 0,
			 balance: 0)

nga = Mate.create!(first_name: "Nga",
			 last_name: "Nguyen",
			 mobile_number: "+49 176 57608441",
			 email: "n.thuy_nga@yahoo.de",
			 points: 0,
			 balance: 0)

puneh = Mate.create!(first_name: "Puneh",
			 last_name: "Nejati-Mehr",
			 mobile_number: "+4915168410618",
			 email: "p.mehr@me.com",
			 points: 0,
			 balance: 0)

jakob = Mate.create!(first_name: "Jakob",
			 last_name: "Wunderwald",
			 mobile_number: "+4915735808519 11111",
			 email: "Jakobwunderwald@yahoo.de",
			 points: 0,
			 balance: 0)

right_now = Time.zone.now
sunday_at_22 = right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second

marcus.duties.create!(area_id: Area.find_by(name: "Küche").id,
					  due_to: sunday_at_22,
					  accomplished_at: nil,
					  accomplished_by_assigned: true,
					  faulty: false)

jakob.duties.create!(area_id: Area.find_by(name: "Bad").id,
					 due_to: sunday_at_22,
					 accomplished_at: nil,
					 accomplished_by_assigned: true,
					 faulty: false)

nga.duties.create!(area_id: Area.find_by(name: "Wz./Flur").id,
					  due_to: sunday_at_22,
					  accomplished_at: nil,
					  accomplished_by_assigned: true,
					  faulty: false)

puneh.duties.create!(area_id: Area.find_by(name: "Kühlschrank").id,
					  due_to: sunday_at_22,
					  accomplished_at: nil,
					  accomplished_by_assigned: true,
					  faulty: false)
