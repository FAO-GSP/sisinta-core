require 'test_helper'
 
class ProcessWithRJobTest < ActiveJob::TestCase
  let(:operation) { create :operation, state: 'queued' }

  it 'fails without profiles' do
    ProcessWithRJob.perform_now(operation)

    operation.must_be :failed?
    operation.error_message.must_equal I18n.t('jobs.process_with_r.no_profiles_selected')
  end

  describe 'Rapi interaction' do
    let(:profile) { create :profile, :complete }
    let(:operation) { create :operation, state: 'queued', process: 'plot_spc', profile_ids: [profile.id] }

    it 'handles 500 errors' do
      # Currently fails
      operation.process = 'dissimilarity'

      VCR.use_cassette '500 error' do
        ProcessWithRJob.perform_now(operation)
      end

      operation.must_be :failed?
      operation.error_message.must_equal I18n.t('rapi.response.code.500')
    end

    it 'handles 404 errors' do
      operation.process = 'invented-process'

      VCR.use_cassette '404 error' do
        ProcessWithRJob.perform_now(operation)
      end

      operation.must_be :failed?
      operation.error_message.must_equal I18n.t('rapi.response.code.404')
    end

    it 'correctly saves the response' do
      VCR.use_cassette 'plot_spc' do
        ProcessWithRJob.perform_now(operation)
      end

      operation.must_be :completed?
      operation.error_message.must_be :nil?
      operation.results.must_be :attached?
    end
  end
end
