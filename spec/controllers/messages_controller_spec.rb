
require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  # MessagesController これ重要、ファイル名に依存してる

  #  letを利用してテスト中使用するインスタンスを定義、モデルのインスタンスを生成
  let(:group_instance) { create(:group) }
  let(:user_instance) { create(:user) }

  describe 'GET #index' do
    # メッセージ一覧ページを表示するアクション

    context 'ログインしている場合' do

      before do
        login user_instance
        get :index, params: { group_id: group_instance.id }
        # rails routes で確認すると、group_idがある。{}は中身がイコールみたいな。group_idに仮に、groupインスタンスのidを入れる
        # paramsがないと、Messageのインスタンスを生成できない
        # messageのインスタンスのキーgroup_id、に、groupモデルのインスタンスのid を入れて、？
      end

      it '@messageに期待した値が入っていること' do
        expect(assigns(:message)).to be_a_new(Message)
        # インスタンス変数に代入されたオブジェクトは、コントローラのassigns メソッド経由で参照できます。 
        # @messageを参照したい場合、assigns(:message)と記述することができます。
        # be_a_newマッチャ、 対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか確かめることができます

      end

      it '@groupに期待した値が入っていること' do
        expect(assigns(:group)).to eq group_instance
      end

      it 'index.html.haml に遷移すること' do
        expect(response).to render_template :index
        # responseは、example内で[リクエストが行われた後の遷移先のビューの情報]を持つインスタンス
      end
    end

    context 'ログインしていない場合' do

      before do
        get :index, params: { group_id: group_instance.id }
      end

      it 'ログイン画面にリダイレクトすること' do
        expect(response).to redirect_to(new_user_session_path)
      end

    end
    
  end

  describe '#create' do
    let(:params_fake) { { group_id: group_instance.id, user_id: user_instance.id, message: attributes_for(:message) } }

    context 'ログインしている場合' do
      before do
        login user_instance
      end

      context '保存に成功した場合' do
        subject {
          post :create, params: params_fake
        }

        it 'messageを保存すること' do
          expect{subject}.to change(Message, :count).by(1)
        end

        it 'group_messages_pathへリダイレクトすること' do
          subject
          expect(response).to redirect_to(group_messages_path(group_instance))
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { group_id: group_instance.id, user_id: user_instance.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          # fabricate mock HTTP post method, create action
          params: invalid_params
        }

        it 'messageを保存しないこと' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'index.html.hamlに遷移すること' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'ログインしていない場合' do

      it 'new_user_session_pathにリダイレクトすること' do
        post :create, params: params_fake
        #fabricate HTTP POST 
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end














  # -----------
#   describe 'POST #create' do
#     # メッセージを作成するアクション
#     let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

#     # before do
#     #   post :create, params {group_id: group.id}
#     #   # 「擬似的にcreateアクションを動かすリクエストを行う」ために、
#     #   # getメソッドを利用しています。
#     #   # messagesのルーティングはgroupsにネストされているため、group_idを含んだパスを生成


#     # end

#     context 'ログインしているかつ、保存に成功した場合' do

#       login user

#       it 'メッセージの保存はできたのか' do
#         # @messageのインスタンスにmessageモデルのオブジェクトが
#         messageInstance = create(:message)
#         messageInstance.to be_valid
#         expect(assigns(:message)).to 
#       end

#       it '意図した画面に遷移しているか' do

#         expect(response).to redirect_to(group_messages_path(@group))
#       end

#     end

#     context 'ログインしているが、保存に失敗した場合' do

#       it 'メッセージの保存は行われなかったか' do
#       end

#       it '意図したビューが描画されているか' do
#       end

#     end

#     context 'ログインしていない場合' do

#       it '意図した画面にリダイレクトできているか' do
#         expect(response).to redirect_to()

#       end

#     end


#   end
# end