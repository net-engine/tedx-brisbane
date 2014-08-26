a = AdminUser.new
a.email = 'lisa@woodfordia.com'
a.password = a.password_confirmation = 'ASDF'
a.save!

a = AdminUser.new
a.email = 'team+tedx@netengine.com.au'
a.password = a.password_confirmation = 'asdf'
a.save!
