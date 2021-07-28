module LoginSupport
  def login_as(user)
    visit root_path
    fill_in 'user_session_email', with: user.email
    fill_in 'user_session_password', with: 'password'
    click_button 'login'
    expect(page).to have_current_path root_path
  end
end
