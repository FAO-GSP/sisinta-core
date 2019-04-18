require 'test_helper'

describe DispatchOperationService, :model do
  subject { DispatchOperationService.new user: user, name: 'user defined' }
  let(:user) { create :user }

  describe 'operation_job' do
    it 'defaults to a null operation' do
      subject.operation_job.must_equal NoOperationJob
    end

    it 'recognizes export' do
      subject.name = 'export'

      subject.operation_job.must_equal ExportJob
    end

    it 'recognizes delete' do
      subject.name = 'delete'

      subject.operation_job.must_equal DeleteProfilesJob
    end

    it 'recognizes process_with_r' do
      subject.name = 'process_with_r'

      subject.operation_job.must_equal ProcessWithRJob
    end
  end

  describe 'operation_name' do
    it 'defaults to no_operation' do
      subject.operation_name.must_equal t('operations.create.no_operation', name: 'user defined')
    end

    it 'recognizes export' do
      subject.name = 'export'
      subject.process = 'something'

      subject.operation_name.must_equal t('operations.index.export.title', process: 'something')
    end

    it 'recognizes delete' do
      subject.name = 'delete'

      subject.operation_name.must_equal t('operations.index.delete.title')
    end

    it 'recognizes process_with_r' do
      subject.name = 'process_with_r'
      subject.process = 'something'

      subject.operation_name.must_equal t('operations.index.process_with_r.title', process: 'something')
    end
  end

  describe 'call' do
    it 'creates an operation for processing' do
      lambda do
        subject.call
      end.must_change 'Operation.count'

      Operation.find_by(name: subject.operation_name).must_be :persisted?
    end
  end
end
