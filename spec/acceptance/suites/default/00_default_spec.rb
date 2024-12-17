require 'spec_helper_acceptance'

test_name 'sudosh'

describe 'sudosh' do
  let(:manifest) do
    <<-EOS
      include 'sudosh'
    EOS
  end

  hosts.each do |host|
    context "on #{host}" do
      context 'default parameters' do
        it 'enables SIMP dependencies repo for sudosh package' do
          install_simp_repos(host)
        end

        it 'works with no errors' do
          apply_manifest_on(host, manifest, catch_failures: true)
        end

        it 'is idempotent' do
          apply_manifest_on(host, manifest, catch_failures: true)
        end

        it 'has sudosh2 installed' do
          expect(check_for_package(host, 'sudosh2')).to be true
        end
      end
    end
  end
end
