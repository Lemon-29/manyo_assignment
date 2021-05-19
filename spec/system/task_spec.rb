require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', content: 'task') }
  let!(:task2) { FactoryBot.create(:task, title: 'task2', content: 'task2') }
  let!(:task3) { FactoryBot.create(:task, title: 'task3', content: 'task3') }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: "task_name"
        fill_in "task_content", with: "task_content"
        click_on '登録する'
        expect(page).to have_content 'task_name'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task_list = all('ul li')
      expect(task_list[0]).to have_content 'task3'
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, content: 'task')
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end