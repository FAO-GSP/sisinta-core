require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  subject { create :user, :confirmed }
  let(:profile) { create :profile }
  let(:required_params) { { selections: { profile_ids: [] } } }

  describe '#update' do
    before { sign_in subject }

    it 'gets a response' do
      put selection_path(format: :js), params: required_params

      must_respond_with :success
    end

    it 'updates the current selection' do
      put selection_path(format: :js),
        params: { selections: { profile_ids: [profile.to_param] } }

      subject.current_selection.must_equal [profile.id]
    end

    it 'adds to the current_selection' do
      subject.update_attribute :current_selection, [profile.to_param]

      another_profile = create :profile

      put selection_path(format: :js),
        params: { selections: { profile_ids: [another_profile.to_param] } }

      subject.current_selection.include?(profile.id).must_equal true
      subject.current_selection.include?(another_profile.id).must_equal true
    end

    it 'returns forbidden if no user is logged in' do
      sign_out subject

      put selection_path(format: :js), params: required_params

      must_respond_with :forbidden
    end
  end
end
