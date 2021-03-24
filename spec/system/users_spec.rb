require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit "/"
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user) # buildだとsaveが必要だよ！
    # サインインページへ移動する
    visit  new_user_session_path # root_pathのがいい気がするけど
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    # ログインボタンをクリックする
    click_on('Log in') # 引数にテキストorValue属性を指定
    # find('input[name="commit"]').clickでもクリックできる
    # トップページに遷移していることを確認する
    expect(current_path).to eq "/"
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit "/"
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in "user_email", with: "test@gmail.com"
    fill_in "user_password", with: @user.password
    # ログインボタンをクリックする
    click_on('Log in')
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq new_user_session_path
  end
end

# テスト実行コマンド
# bundle exec rspec spec/system/users_spec.rb