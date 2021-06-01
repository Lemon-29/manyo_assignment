require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:task2) { FactoryBot.create(:task2, user_id: user.id) }
  let!(:task3) { FactoryBot.create(:task3, user_id: user.id) }

  before do
    visit tasks_path
    visit new_session_path
    fill_in "sessions-new_email", with: "user1@example.com"
    fill_in "sessions-new_password", with: "password1"
    click_on "sessions-new_submit"
    visit tasks_path
  end
      
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = Task.last
        task_list = find("#tasks-index_item_title-#{task.id}")
        expect(task_list).to have_content task.title
      end
    end
  end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.tasks-index_item_title')
        expect(task_list.first).to have_content Task.order(created_at: :desc).first.title
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の遅いタスクが一番上に表示される' do
        find('#tasks_index_sort-expired').click
        task_list = all('.tasks-index_item_title')
        expect(task_list.first).to have_content Task.order(expired_at: :desc).first.title
      end
    end

    context 'タスクが優先順位の高い順に並んでいる場合' do
      it '優先順位の高いタスクが一番上に表示される' do
        # within '.sort_expired' do
          click_on '優先順位でソートする'
        # end
        task_list = all('.tasks-index_item_title')
        # expect(task_list.first).to have_content Task.order(priority: :desc).first.title
        expect(task_list.first).to have_content "task3_title"

      end
    end

  describe '検索機能' do
    context 'タイトルで検索した場合' do
      it '該当タイトルのタスクが表示される' do
        fill_in "search_title", with: "3"
        click_on 'search'
        expect(page).to have_content 'task3'
      end
    end
    context 'ステータスで検索した場合' do
      it '該当ステータスのタスクが表示される' do
        select 'Completed', from: 'search_status'
        sleep 0.5
        click_on 'search'
        expect(page).to have_content 'Completed'
        expect(page).to have_content 'task3_content'
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      it '該当のタスクが表示される' do
        fill_in "search_title", with: "2"
        select 'On_going', from: 'search_status'
        sleep 0.5
        click_on 'search'
        expect(page).to have_content 'task2'
        expect(page).to have_content 'On_going'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end