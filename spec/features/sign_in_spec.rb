# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'Sign in' do
  context 'when user does not exist' do
    it 'alerts email not found' do
      visit '/users/sign_in'

      within '#sign-in' do
        fill_in '我的邮箱', with: 'not_exists@example.com'
        fill_in '密码', with: '123456'

        click_button '登录'
      end

      page.should have_content '您填写的邮箱或密码不正确'
    end
  end

  context 'when password is wrong' do
    it 'alerts email and password not matched' do
      FactoryGirl.create(:user, email: 'towerhe@gmail.com', password: '123456')

      visit '/users/sign_in'

      within '#sign-in' do
        fill_in '我的邮箱', with: 'towerhe@gmail.com'
        fill_in '密码', with: 'wrong'

        click_button '登录'

      end

      page.should have_content '您填写的邮箱或密码不正确'
    end
  end

  context 'with valid email and password' do
    it 'alerts email and password not matched' do
      FactoryGirl.create(:user, email: 'towerhe@gmail.com', password: '123456')

      visit '/users/sign_in'

      within '#sign-in' do
        fill_in '我的邮箱', with: 'towerhe@gmail.com'
        fill_in '密码', with: '123456'

        click_button '登录'
      end

      page.should have_content '恭喜您！您已经登录成功。'
    end
  end
end
