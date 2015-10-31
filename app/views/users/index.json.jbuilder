json.array!(@users) do |user|
	json.extract! user, :id, :email, :last_sign_in_at
	json.role user.role.name
end

