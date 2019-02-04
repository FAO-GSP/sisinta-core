require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  let(:operation) { create :operation }

  describe 'as guest' do
    describe '#index' do
      it 'redirects to root' do
        get operations_path

        must_redirect_to :localized_root
      end
    end

    describe '#show' do
      it 'redirects to root' do
        get operation_path(operation.to_param)

        must_redirect_to :localized_root
      end
    end
  end

  describe 'signed in' do
    before { sign_in operation.user }

    describe '#index' do
      it 'gets a response' do
        get operations_path

        must_respond_with :success
      end
    end

    describe '#show' do
      it 'gets a response' do
        get operation_path(operation.to_param)

        must_respond_with :success
      end
    end
  end

  describe 'routes' do
    it 'understands named export route' do
      value({
        controller: 'operations', action: 'create', locale: 'es',
        operation: { 'name' => 'csv_export' }
      }).must_route_to('/es/operations/export')

      # FIXME Verify if this should pass, generating the default create action.
      # value({
      #   controller: 'operations', action: 'create', locale: 'es'
      # }).must_route_to('/es/operations')

      value({
        path: '/es/operations/export', method: :post
      }).must_route_from({
        controller: 'operations', action: 'create', locale: 'es',
        operation: { 'name' => 'csv_export' }
      })
    end
  end
end
