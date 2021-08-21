# save user with auto generated password if user does not give password on registration.
 # default role is temp
 # return error if user email/username/phone is empty.
 def register_user(params)
  user = User.new(params)
  user.role = "admin"

  user.valid?
  user.duplicate?
  
  if user.save
    user.send_mail_confirmation
  end
  user
 end