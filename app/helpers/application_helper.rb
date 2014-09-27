module ApplicationHelper

	def get_collection_variables(newitem, iscurrent)

		collection_name = newitem.class.name.tableize

		case iscurrent
		when "true"
			form_id = "new_current_" + newitem.class.name.tableize
		when "false"
			form_id = "new_past_" + newitem.class.name.tableize
		else
			form_id = "new_" + newitem.class.name.tableize
		end

		return form_id, collection_name

	end



end
