require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
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

    describe '#create' do
      it 'redirects to root' do
        post operations_path, params: { operation: { name: 'some operation' } }

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

    describe '#create' do
      it 'creates an operation' do
        lambda do
          post operations_path, params: { operation: { name: 'some operation' } }
        end.must_change 'Operation.count'

        must_redirect_to operation_path(Operation.last.to_param)
      end
    end
  end

  describe 'routes' do
    it 'understands named export route' do
      value({
        controller: 'operations', action: 'create', locale: 'es',
        process: 'something', operation: { 'name' => 'export' }
      }).must_route_for(
        path: '/es/operations/export/something',
        method: :post
      )

      # FIXME Verify if this should pass, generating the default create action.
      # value({
      #   controller: 'operations', action: 'create', locale: 'es'
      # }).must_route_to('/es/operations')
    end
  end
end
