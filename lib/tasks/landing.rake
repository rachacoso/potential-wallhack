task :set_auth_tokens => :environment do
	users = User.where(:auth_token => nil)
	puts users.count
	users.each do |u|
		begin
			u.auth_token = SecureRandom.urlsafe_base64
		end while User.where(:auth_token => u.auth_token).exists?
		puts "User: #{u.email} token: #{u.auth_token}"
	end
end