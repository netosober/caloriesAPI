json.profiles @profiles do |profile|
    json.id profile.id
    json.role profile.role
    json.calories_limit profile.calories_limit
    json.name profile.name
    json.email profile.user.email
end
