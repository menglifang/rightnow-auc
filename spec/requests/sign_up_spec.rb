# -*- encoding: utf-8 -*-
require 'spec_helper'

describe 'Sign up', js: true do
  it 'displays a form to sign up' do
    visit '/users/sign_up'

    within '#sign-up' do
      page.should have_field '我的邮箱'
      page.should have_field '密码'
      page.should have_field '密码确认'
      page.should have_button '注册'
    end
  end

  it 'alerts the required fields is missing' do
    visit '/users/sign_up'

    within '#sign-up' do
      click_button '注册'

      page.should have_content '您填写的邮箱地址已经存在'
    end
  end

  it 'alerts invalid email' do
    visit '/users/sign_up'

    within '#sign-up' do
      fill_in '我的邮箱', with: 'towerhe'

      click_button '注册'

      page.should have_content '您填写的邮箱地址格式不正确'
    end
  end

  it 'alerts two passwords mismatch' do
    visit '/users/sign_up'

    within '#sign-up' do
      fill_in '我的邮箱', with: 'towerhe@gmail.com'
      fill_in '密码', with: 'password'
      fill_in '密码确认', with: 'another one'
      
      click_button '注册'

      page.should have_content '您两次填写的密码不一致'
    end
  end

  it 'signs up a new user' do
    visit '/users/sign_up'

    within '#sign-up' do
      fill_in '我的邮箱', with: 'towerhe@gmail.com'
      fill_in '密码', with: 'towerhe'
      fill_in '密码确认', with: 'towerhe'
      
      click_button '注册'
    end

    page.should have_content '恭喜您！您已经成功注册成为会员。'
  end
end
