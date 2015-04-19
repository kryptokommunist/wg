module MateHelper

	def deadline(mate)
		mate.duties.last.due_to.strftime("%a, %d.%m") + " (noch #{days_till_deadline mate})"
	end

end