module StatusHelper

	def days_till_deadline (mate)
		days = ((mate.duties.last.due_to - Time.zone.now) / 1.day).to_i
		return pluralize(days, "Tag");
	end

end
