# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Area.create!(name: "Küche",
		     clean: false,
		     points: 10,
		     last_cleaned: 3.days.ago
		     )
Area.create!(name: "Bad",
		     clean: false,
		     points: 15,
		     last_cleaned: 4.days.ago
		     )
Area.create!(name: "Wz./Flur",
		     clean: true,
		     points: 8,
		     last_cleaned: 1.days.ago
		     )

Area.create!(name: "Staubsauger",
		     clean: true,
		     points: 8,
		     last_cleaned: 1.days.ago
		     )

Area.create!(name: "Kühlschrank",
		     clean: true,
		     points: 17,
		     last_cleaned: 1.days.ago
		     )


Area.create!(name: "Müll",
		     clean: true,
		     points: 4,
		     last_cleaned: 1.days.ago
		     )


marcus = Mate.create!(first_name: "Marcus",
			 last_name: "Ding",
			 mobile_number: "+4917695855565",
			 email: "marcusding@me.com",
			 points: 0,
			 balance: 0)

marius = Mate.create!(first_name: "Marius",
			 last_name: "Bothe",
			 mobile_number: "+4917644494194",
			 email: "?",
			 points: 0,
			 balance: 0)

jakob = Mate.create!(first_name: "Jakob",
			 last_name: "Wunderwald",
			 mobile_number: "+4915735808519",
			 email: "?",
			 points: 0,
			 balance: 0)

right_now = Time.zone.now
sunday_at_22 = right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second

marcus.duties.create!(area_id: Area.find_by(name: "Küche").id,
					  due_to: sunday_at_22,
					  accomplished_at: nil,
					  accomplished_by_assigned: true,
					  faulty: false)

jakob.duties.create!(area_id: Area.find_by(name: "Wz./Flur").id,
					 due_to: sunday_at_22,
					 accomplished_at: nil,
					 accomplished_by_assigned: true,
					 faulty: false)

marius.duties.create!(area_id: Area.find_by(name: "Bad").id,
					  due_to: sunday_at_22,
					  accomplished_at: nil,
					  accomplished_by_assigned: true,
					  faulty: false)

