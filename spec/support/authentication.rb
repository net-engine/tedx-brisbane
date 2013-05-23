def sign_in_as_admin
  visit '/admin'
  fill_in 'admin_user_email', with: 'admin@example.com'
  fill_in 'admin_user_password', with: 'password123'

  click_button 'Login'
end

