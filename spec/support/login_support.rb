module LoginSupport
  def login_as(user)
    visit root_path
    click_link 'Login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'Login'
  end
end
