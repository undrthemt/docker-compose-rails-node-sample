# docker-compose-rails-node-sample

## docker-compose
* .env.default にデフォルトが記載されています。コピーして利用してください
* .envファイルで自ホスト側のポートを変更できます

```bash
# 初回のみ
cp -p .env.default .env
docker-compose up
docker-compose exec web bundle exec rails db:create
docker-compose exec web bundle exec rails db:migrate db:seed_fu

# 以降
docker-compose up
```

* postgres, gem, node_modules は volume で永続化されています
* そのため以下のコマンドをイメージをリビルドせずに流せます

```bash
# bundle install
docker-compose exec web bundle install

# npm install
docker-compose exec web npm i

# db:migrate db:seed_fu
docker-compose exec web bundle exec rails db:migrate db:seed_fu
```

* コンテナに接続する

```bash
docker-compose exec web bash
```
