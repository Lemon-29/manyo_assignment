require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "名前", with: "new_user_name"
        fill_in "メールアドレス", with: "new@example.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_on '登録する'
        expect(page).to have_content 'new_user_name'
        expect(page).to have_content 'new@example.com'
      end
    end
    context '未ログインのユーザーがタスク一覧画面に飛んだ場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        h2 = find('h2')
        expect(h2).to have_content 'ログイン'
      end
    end
  end
  describe 'セッション機能のテスト ' do
    context 'ログインした場合' do
      it '作成したユーザーが表示される' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "メールアドレス", with: "user1@example.com"
        fill_in "パスワード", with: "password1"
        within '.actions' do
          click_on 'ログイン'
        end
        expect(page).to have_content 'test_user1'
        expect(page).to have_content 'user1@example.com'
      end
    end
    context '他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user1@example.com"
        fill_in "パスワード", with: "password1"
        within '.actions' do
          click_on 'ログイン'
        end
        visit user_path(user2.id)
        h2 = find('h2')
        expect(h2).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "メールアドレス", with: "user1@example.com"
        fill_in "パスワード", with: "password1"
        within '.actions' do
          click_on 'ログイン'
        end
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        h2 = find('h2')
        expect(h2).to have_content 'ログイン'
      end
    end
  end
  describe '管理画面のテスト ' do
    context '管理ユーザーが管理画面にアクセスした場合' do
      it '管理画面に遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user2@example.com"
        fill_in "パスワード", with: "password2"
        within '.actions' do
          click_on 'ログイン'
        end
        click_on '管理画面'
        h2 = find('h2')
        expect(h2).to have_content '管理画面：ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "メールアドレス", with: "user1@example.com"
        fill_in "パスワード", with: "password1"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        expect(page).to have_content '管理画面へは、管理者以外はアクセスできません'
        h2 = find('h2')
        expect(h2).to have_content 'タスク一覧'
      end
    end
    context '管理ユーザーが管理画面でユーザーの新規登録をした場合' do
      it '管理画面のユーザー詳細ページに遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user2@example.com"
        fill_in "パスワード", with: "password2"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        click_on '新しくユーザーを作成する'
        fill_in "名前", with: "new_user_name"
        fill_in "メールアドレス", with: "new@example.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_on '登録する'
        expect(page).to have_content 'ユーザー情報を登録しました'
        h2 = find('h2')
        expect(h2).to have_content '管理画面：ユーザー情報詳細'
      end
    end
    context '管理ユーザーが管理画面でユーザーの詳細ページに飛んだ場合' do
      it 'ユーザーの詳細ページに遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user2@example.com"
        fill_in "パスワード", with: "password2"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        visit admin_user_path(user1.id)
        h2 = find('h2')
        expect(h2).to have_content '管理画面：ユーザー情報詳細'
        expect(page).to have_content 'test_user1'
      end
    end
    context '管理ユーザーが管理画面でユーザーの編集ページに飛んだ場合' do
      it 'ユーザーの編集ページで情報編集ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user2@example.com"
        fill_in "パスワード", with: "password2"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        visit edit_admin_user_path(user1.id)
        fill_in "名前", with: "update_user_name"
        fill_in "メールアドレス", with: "update@example.com"
        fill_in "パスワード", with: "password_update"
        fill_in "確認用パスワード", with: "password_update"
        click_on '更新する'
        expect(page).to have_content 'ユーザー情報を編集しました'
        h2 = find('h2')
        expect(h2).to have_content '管理画面：ユーザー情報詳細'
        expect(page).to have_content 'update_user_name'
      end
    end
    context '管理ユーザーが管理画面でユーザーの削除ボタンを押した場合' do
      it 'ユーザーの削除ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "メールアドレス", with: "user2@example.com"
        fill_in "パスワード", with: "password2"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        within 'ul li:first-child' do
          page.accept_confirm do
            click_on 'ユーザー情報を削除する'
          end
        end
        expect(page).to have_content 'ユーザー情報を削除しました'
      end
    end
  end
end 


