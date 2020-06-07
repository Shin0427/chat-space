
require 'rails_helper'

RSpec.describe Message, type: :model do

  describe '#create' do

    context 'messageを保存できる場合' do
      it 'contentがあれば保存できること' do
        
        message = build(:message, image: nil)
        expect(message).to be_valid
        # expect(FactoryBot.create(:message, image: nil)).to be_valid
      end

      it '画像があれば保存できる' do
        message = build(:message, content: nil)
        expect(message).to be_valid
      end

      it 'メッセージと画像があれば保存できる' do
        message = build(:message)
        expect(message).to be_valid
      end
    end

    context 'messageを保存できない場合' do

      it 'content と imageが両方空だと保存できないこと' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      it 'group_idが無いと保存できないこと' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it ' user_idが無いと保存できないこと' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    
    end
    
  end
end