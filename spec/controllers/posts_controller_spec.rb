require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }
  let(:post) { create(:post, user: user, organization: organization) }
  let(:valid_attributes) { attributes_for(:post, user: user, organization: organization) }
  let(:invalid_attributes) { attributes_for(:post, title: nil) }

  before do
    sign_in user
    allow(controller).to receive(:current_organization).and_return(organization)
    request.host = "#{organization.subdomain}.example.com"
    request.env['HTTP_HOST'] = "#{organization.subdomain}.example.com"
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all posts as @posts' do
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    context 'when filtering published posts' do
      let!(:published_post) { create(:post, user: user, organization: organization, published_at: Time.current) }
      let!(:draft_post) { create(:post, user: user, organization: organization, published_at: nil) }

      it 'returns only published posts when filter is true' do
        get :index, params: { published: 'true' }
        expect(assigns(:posts)).to include(published_post)
        expect(assigns(:posts)).not_to include(draft_post)
      end
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new post as @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'New Title' } }

      it 'updates the requested post' do
        put :update, params: { id: post.id, post: new_attributes }
        post.reload
        expect(post.title).to eq('New Title')
      end

      it 'assigns the requested post as @post' do
        put :update, params: { id: post.id, post: new_attributes }
        expect(assigns(:post)).to eq(post)
      end

      it 'redirects to the posts list' do
        put :update, params: { id: post.id, post: new_attributes }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid params' do
      it 'does not update the post' do
        put :update, params: { id: post.id, post: invalid_attributes }
        post.reload
        expect(post.title).not_to be_nil
      end

      it 'renders the edit template' do
        put :update, params: { id: post.id, post: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post = create(:post, user: user, organization: organization)
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_path)
    end
  end
end 