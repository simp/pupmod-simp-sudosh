require 'spec_helper_acceptance'

test_name 'sudosh'

describe 'sudosh' do
  let(:manifest) {
    <<-EOS
      include 'sudosh'
    EOS
  }

  hosts.each do |host|
    context "on #{host}" do
      context 'default parameters' do
        it 'should work with no errors' do
          apply_manifest_on(host, manifest, :catch_failures => true)
        end

        it 'should be idempotent' do
          apply_manifest_on(host, manifest, :catch_failures => true)
        end

        it 'should have sudosh2 installed' do
          expect(check_for_package(host, 'sudosh2')).to be true
        end
      end
    end
  end
end
