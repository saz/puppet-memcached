require 'spec_helper_acceptance'

describe 'memcached' do
  context 'with all defaults' do
    let(:pp) do
      'include memcached'
    end
    it 'works idempotently with no errors' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
    describe service('memcached') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
