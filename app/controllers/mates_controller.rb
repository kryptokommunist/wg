class MatesController < ApplicationController


	def edit
		@mate = Mate.find_by(id: params[:id])
		@duty = Duty.find_by(id: params[:duty_id])
		if @mate && @duty
			if @mate.id != @duty.mate_id
				flash[:danger] = "Falsche Aufgabe!" 
				redirect_to root_path
		    elsif @duty.accomplished_at # if not nil, duty has already been accomplished
				flash[:danger] = "Bereits erledigt!"
				redirect_to root_path
			end		
		else
		flash[:danger] = "Falsche User/Duty ID!"
		redirect_to root_path
		end
	end

	def update
		mate = Mate.find_by(:id,params[:id])
		duty = Duty.find_by(:id, params[:duty_id])
		duty.update_attribute(:accomplished_at, Time.zone.now)
		mate.update_attribute(:points, mate.points + duty.area.points)
		duty.area.update_columns(last_cleaned: Time.zone.now, clean: true)
		mate.duties.create!(area_id: next_area(duty.area_id),
							due_to: this_sunday,
							accomplished_by_assigned: true,
							accomplished_at: nil,
							faulty: false)
		redirect_to root_path
	end

	private

		def next_area(current_id)
			next_id = current_id + 1
			return next_id if (next_id <= 3)
			return
		end

		def this_sunday
			right_now = Time.zone.now
            sunday_at_22 = right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second
        end
end
