
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
		@duty = @mate.duties.last
		check_mate_duty(@mate, @duty)
	end

	def update
		mate = Mate.find_by(id: params[:id])
		duty = mate.duties.last
		area_id = params[:area_id].to_i

		if check_mate_duty(mate, duty, area_id)
		
			x = mate.duties.create!(area_id: next_area(duty.area_id),
									due_to: this_sunday,
									accomplished_by_assigned: true,
									accomplished_at: nil,
									faulty: false)
			if x
				duty.update_attribute(:accomplished_at, Time.zone.now)
				duty.area.update_attribute(:clean, true)
				mate.update_attribute(:points, mate.points + duty.area.points)
				duty.area.update_columns(last_cleaned: Time.zone.now, clean: true)

				mate.reload # for access to new task in sms

				edit_url = edit_mate_url(mate, duty_id: mate.duties.last.id)
				message = """Super #{mate.first_name}, neuer Punktestand: #{mate.points}. \n Deine nächste Aufgabe: #{mate.duties.last.area.name}. \n Deadline: #{mate.duties.last.due_to}. \n Link: #{edit_url}"""
				send_message(mate.mobile_number, message)

				flash[:success] = "Punkte gutgeschrieben - Neue Aufgabe zugeteilt"
				@error = nil
			else
				@error = "Fehler beim Aufgabenerzeugen!"
				flash[:danger] = @error
			end
		end

		respond_to do |format|
		    format.js
		end
	end

	private

		def check_mate_duty(mate, duty, area_id)
			if mate && duty
				if (mate.id != duty.mate_id) || (duty.area.id != area_id)
					@error = "Falsche Aufgabe!"
					flash[:danger] = @error
					return false
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

		# assuming only the first three areas are distributed
		def next_area(current_id)
			next_id = current_id + 1
			return next_id if (next_id <= 3)
			return 1
		end

		def this_sunday
			right_now = Time.zone.now
            sunday_at_22 = right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second
        end

        def send_message(number,message)
		# put your own credentials here 
		# put your own credentials here 
		account_sid = 'AC2c8fd13944d9190874525dd9a0c5b339' 
		auth_token = '5a9d4063607d343906330171968f7371' 
		 
		# set up a client to talk to the Twilio REST API 
		client = Twilio::REST::Client.new account_sid, auth_token 
		 
		client.account.messages.create({:from => '+4915735981100', :to => number, :body => message,  })
		end

end
