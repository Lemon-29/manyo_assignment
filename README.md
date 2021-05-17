| Table schema |                 | 
| ------------ | --------------- | 
|    #type     |  #column        | 
|              |                 | 
| tasks model  |                 | 
| intiger      | status          | 
| string       | title           | 
| text         | content         | 
| bigint       | user_id         | 
|              |                 | 
|              |                 | 
| users model  |                 | 
| type         | column          | 
| string       | name            | 
| string       | email           | 
| string       | password_digest | 


Herokuへのデプロイ手順
ログイン
heroku login

Assetプリコンパイル
rails assets:precompile RAILS_ENV=production

git add & git commit
git add -A git commit -m "init"

heroku create
heroku create

heroku stackを18に変更
heroku stack:set heroku-18

デプロイ出来ない場合、下記をbuildpackを入れる
heroku buildpacks:set heroku/ruby ※デプロイ出来ない場合 heroku buildpacks:add --index 1 heroku/nodejs ※デプロイ出来ない場合

まだデプロイ出来ない場合、下記をplatformを入れる
bundle lock --add-platform x86_64-linux ※デプロイ出来ない場合

Heroku master (or main)にpush
git push heroku master( or main)

heroku内でマイグレーション
heroku run rails db:migrate

herokuサーバーを再起動
heroku restart

アクセスして動作確認
heroku config