require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'メールアドレスは@を含んでいれば登録できる' do
        @user.email = 'aaaaaa@aaaaaa'
        expect(@user).to be_valid
      end
      it 'パスワードは６文字以上で登録できる' do
        @user.password = 'aaaaaa123'
        @user.password_confirmation = 'aaaaaa123'
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード（確認用）、値の一致して登録できる' do
        @user.password = 'aaaaaa123'
        @user.password_confirmation = 'aaaaaa123'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it '姓が空だと登録できない' do
        @user.last_name = ''
        @user.valid?

        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end
      it '名が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it '姓（フリガナ）が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana 全角カタカナのみで入力して下さい')
      end
      it '名（フリガナ）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana 全角カタカナのみで入力して下さい')
      end
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
      it '重複するパスワードが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?

        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが数字のみの場合に登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)', 'Password は半角6~12文字英小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'パスワードが英字のみの場合は登録できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)', 'Password は半角6~12文字英小文字・数字それぞれ１文字以上含む必要があります')
      end
    end
  end
end
