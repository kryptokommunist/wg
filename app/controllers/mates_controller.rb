
class MatesController < ApplicationController

	def show
		if @mate = Mate.find_by(id: params[:id])
			@areas = Area.all
		else
			flash[:danger] = "Mate id nicht gefunden" 
			redirect_to root_path
		end
	end

	def edit
		@mate = Mate.find_by(id: params[:id])
		@duty = @mate.current_duty
		check_mate_duty(@mate, @duty)
	end

	def update
		mate = Mate.find_by(id: params[:id])
		duty = mate.duties.find_by(accomplished_at: nil) # always retrieve the current open task
		area_id = params[:area_id].to_i 

		if (check = check_mate_duty(mate, duty, area_id)) == :no_duty_match # case that cleaned area wasn't assigned
			# create new duty for cleaned area for tracking purposes
			x = mate.duties.create!(area_id: area_id,
									due_to: nil,
									accomplished_by_assigned: false, # mark that this wasn't an assigned task
									accomplished_at: Time.zone.now,
									faulty: false)
			area = Area.find(area_id)
			mate.update_attribute(:points, mate.points + area.points)
			area.update_columns(last_cleaned: Time.zone.now, clean: true)
		elsif check # case that the area was assigned in current duty
			x = mate.duties.create(area_id: next_area(duty.area_id),
									due_to: next_sunday(duty.due_to),
									accomplished_by_assigned: true,
									accomplished_at: nil,
									faulty: false)
			if x # make sure new duty was created
				duty.update_attribute(:accomplished_at, Time.zone.now)
				duty.area.update_attribute(:clean, true)
				mate.update_attribute(:points, mate.points + duty.area.points)
				duty.area.update_columns(last_cleaned: Time.zone.now, clean: true)

				mate.reload # for access to new task in sms

				edit_url = edit_mate_url(mate, duty_id: mate.duties.last.id)
				message = """Super #{mate.first_name}, neuer Punktestand: #{mate.points}. \n Deine nächste Aufgabe: #{mate.duties.last.area.name}. \n Deadline: #{mate.duties.last.due_to}. \n Link: #{edit_url}"""
	
				send_message(mate.mobile_number, message)

				flash[:success] = "Punkte gutgeschrieben - Neue Aufgabe zugeteilt"
				@error = nil # set error to nil since it may already contain sth.
			else
				@error = "Fehler beim Aufgabenerzeugen!"
				flash[:danger] = @error
			end
		end

		@area = Area.find(area_id) # used in js response
		@mate = mate.reload

		respond_to do |format|
		    format.js
		end
	end

	private

		# checks validity, returns false if not compliant, returns 1 if the area wasn't in the current duty, otherwise returns true
		# also sets the @error variable, for use in responses/views
		def check_mate_duty(mate, duty, area_id)
			if mate && duty # check if mate/duty were found in database
				if (mate.id != duty.mate_id) || (duty.area.id != area_id) # check if duty belongs to mate and if duty belongs to area
					@error = "Diese Aufgabe war nicht geplant! Super, #{mate.first_name}! :)"
					flash[:danger] = @error
					return :no_duty_match
		   		elsif duty.accomplished_at # if not nil, duty has already been accomplished
		   			@error = "Bereits erledigt!"
					flash[:danger] = @error
					return false
				end
				return true
			else
				@error = "Falsche User/Duty ID!"
				flash[:danger] = @error
				return false
			end
		end

		# returns next area_id out of 1..3
		def next_area(current_id)
			next_id = current_id + 1
			return next_id if (next_id <= 3)
			return 1
		end

		# returns date for sunday 24:00pm of current week or of next week if supplied with due_to_date before now. 
		# E.g. Function is called Monday at 00:00pm, then right_now needs to be incremented to next week (+7 days) since duties are assigned weekly
		def next_sunday(due_to_date)
			right_now = Time.zone.now
			right_now += 6.days if right_now <= due_to_date # approximation should be fine, ignore edge cases for now
            return right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second
        end

        # sends message via Twilio
        def send_message(number,message)
			account_sid = 'AC2c8fd13944d9190874525dd9a0c5b339' 
			auth_token = '5a9d4063607d343906330171968f7371' 

			begin
				# set up a client to talk to the Twilio REST API
				client = Twilio::REST::Client.new account_sid, auth_token 
				 
				client.account.messages.create({:from => '+4915735981100', 
												:to => number,
												:body => message,})

			rescue Exception => ex
	  			@error = ex.message + "\n\n" + ex.backtrace.join("\n")
			end
		end

end
