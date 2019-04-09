json.extract! user, :id, :name, :s_name, :phone
json.title [user.s_name, user.name].join(' ').strip
json.email user.email unless user.guest?
