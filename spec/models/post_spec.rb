require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization: organization) }
  let(:post) { build(:post, user: user, organization: organization) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post.title = nil
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a body' do
      post.body = nil
      expect(post).not_to be_valid
      expect(post.errors[:body]).to include("can't be blank")
    end

    it 'is not valid without a user' do
      post.user = nil
      expect(post).not_to be_valid
      expect(post.errors[:user]).to include("must exist")
    end

    it 'is not valid without an organization' do
      post.organization = nil
      expect(post).not_to be_valid
      expect(post.errors[:organization]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(post.user).to eq(user)
    end

    it 'belongs to an organization' do
      expect(post.organization).to eq(organization)
    end
  end

  describe 'scopes' do
    let!(:published_post) { create(:post, user: user, organization: organization, published_at: Time.current) }
    let!(:draft_post) { create(:post, user: user, organization: organization, published_at: nil) }

    describe '.published' do
      it 'returns only published posts' do
        expect(Post.published).to include(published_post)
        expect(Post.published).not_to include(draft_post)
      end
    end
  end

  describe 'callbacks' do
    it 'sets the organization from user on create' do
      new_post = create(:post, user: user)
      expect(new_post.organization).to eq(user.organization)
    end
  end
end
