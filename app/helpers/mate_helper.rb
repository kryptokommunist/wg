module MateHelper

	def duty_deadline(mate)
		duty = mate.current_duty
		return duty.area.name + " bis " + duty.due_to.strftime("%a, %d.%m") + " (noch " + days_till_deadline(mate) +")"
	end

	def days_till_deadline (mate)
		days = ((mate.current_duty.due_to - Time.zone.now) / 1.day).to_i
		return pluralize(days, "Tag");
	end

end