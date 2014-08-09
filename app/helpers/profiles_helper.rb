module ProfilesHelper

	def countries_list
		@countries = [
			['United States', 'us'],
			['Canada', 'ca'],
			['Korea', 'kr'],
			['France', 'fr'],
			['Germany', 'de']
		]
	end

	def sectors_list
		@countries = [
			['Personal care', 'personalcare'],
			['Baby/Kids', 'babykids'],
			['Fashion', 'fashion']
		]
	end

	def channels_list
		@countries = [
			['Department Stores', 'departmentsores'],
			['Home Shopping', 'homeshopping'],
			['Beauty Retailers', 'beautyretailers'],
			['Supermarkets', 'supermarkets'],
			['Online Malls', 'onlinemalls'],
			['Professional Channels', 'professionalchannels']
		]
	end


end
