class User < ActiveRecord::Base
	has_secure_password
end

#Macro gives us access to a few new methods. A macro is a method that when called, creates methods for you.

#This method works in conjunction with the gem bcrypt