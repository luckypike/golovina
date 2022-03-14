# frozen_string_literal: true

json.extract! user, :id, :name, :s_name, :phone, :state
json.title [user.s_name, user.name].join(' ').strip
json.email user.email unless user.guest?
