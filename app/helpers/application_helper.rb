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

	def check_brand_public_profile # check "completeness" of public profile

		list = 0

		# fields to check from primary document
		checklist = [
			:year_established,
			:company_size,
			:country_of_origin,
			:export_countries,
			:sectors,
			:channels
		]
		
		# fields to check from related document (:country_of_manufacture in :products)
		if @profile.products.distinct(:country_of_manufacture).reject(&:empty?).count > 0
				list += 1
		end

		# complete is all from checklist plus the related document(s)
		complete = checklist.count + 1

		checklist.each do |item|
			if !@profile.send(item).blank?
				list += 1
			end
		end

		percent_complete = list.to_f/complete.to_f * 100.0

		return percent_complete.round

	end

	def check_brand_full_profile # check "completeness" of full profile

		# NEED TO do

		return 50

	end



	def check_distributor_public_profile # check "completeness" of public profile

		list = 0

		# fields to check from primary document
		checklist = [
			:year_established,
			:company_size,
			:country_of_origin,
			:sectors,
			:channels
		]

		# complete is all from checklist
		complete = checklist.count

		checklist.each do |item|
			if !@profile.send(item).blank?
				list += 1
			end
		end

		percent_complete = list.to_f/complete.to_f * 100.0

		return percent_complete.round

	end

	def check_distributor_full_profile # check "completeness" of full profile

		# NEED TO do

		return 50

	end

end
