require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', user_id: user.id)
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト2', content: '', user_id: user.id)
        expect(task).not_to be_valid
      end
    end
    
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', user_id: user.id)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, title: 'task', status: 1, user_id: user.id) }
    let!(:second_task) { FactoryBot.create(:task, title: "sample", expired_at: '2021-03-33 03:33:33', status: 3, user_id: user.id) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(second_task)
        expect(Task.search_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('Pending')).to include(task)
        expect(Task.search_status('Pending')).not_to include(second_task)
        expect(Task.search_status('Pending').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('sample')).to include(second_task)
        expect(Task.search_status('Completed')).to include(second_task)
        expect(Task.search_title('sample')).not_to include(task)
        expect(Task.search_status('Completed')).not_to include(task)
        expect(Task.search_title('sample').count).to eq 1
        expect(Task.search_status('Completed').count).to eq 1
      end
    end
  end
end 