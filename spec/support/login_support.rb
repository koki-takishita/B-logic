module LoginSupport
  def login_as(user)
    visit root_path
    click_button 'ログイン'
    within('#LoginModal') do
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: 'password'
      click_button 'ログイン'
    end
    expect(page).to have_content I18n.t 'user_sessions.create.success'
  end
end
