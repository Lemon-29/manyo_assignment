FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'task.title' }
    expired_at { '2021-05-01 03:33:33' }
    status { 1 }
    priority { 1 }
  end
  factory :task2, class: "Task" do
    title { 'task2_title' }
    content { 'task2_content' }
    expired_at { '2021-05-15 03:33:33' }
    status { 2 }
    priority { 2 }
  end
  factory :task3, class: "Task" do
    title { 'task3_title' }
    content { 'task3_content' }
    expired_at { '2021-03-21 03:33:33' }
    status { 3 }
    priority { 3 }
  end
end