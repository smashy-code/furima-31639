require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    # context '新規登録がうまくいくとき' do
    #   it 'メールアドレスは@を含んでいれば登録できる' do
    #     @user.email = "aaa@aaa"
    #     expect(@user).to be_valid
    #   end
    #   it 'パスワードは６文字以上で登録できる' do
    #     @user.password = "aaaaaa"
    #     @user.password_confirmation = "aaaaaa"
    #     expect(@user).to be_valid
    #   end
    #   it 'パスワードとパスワード（確認用）、値の一致して登録できる'do
    #     @user.password = "aaaaaa"
    #     @user.password_confirmation = "aaaaaa"
    #     expect(@user).to be_valid
    #   end
    # end

    context '新規登録がうまくいかない時' do
      it 'メールアドレスが空と登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスに＠を含んでいなければ登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードは空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、５文字以下であれば登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードとパスワード（確認用）、値の一致していなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワード（確認用）が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
