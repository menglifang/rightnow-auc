# -*- encoding: utf-8 -*-
require 'spec_helper'

feature 'Users', 'List users' do
  background do
    FactoryGirl.create(:user, email: 'towerhe@gmail.com', password: '123456', role: :admin)
  end

  scenario 'Listing the users' do
    visit '/users/sign_in'

    within '#sign-in' do
      fill_in '我的邮箱', with: 'towerhe@gmail.com'
      fill_in '密码', with: '123456'

      click_button '登录'
    end

    visit '/users'

    page.should have_content 'towerhe@gmail.com'
  end
end
