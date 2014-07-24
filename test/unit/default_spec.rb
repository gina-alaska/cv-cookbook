require_relative 'spec_helper'

describe "cv::default" do
  let(:chef_run){ ChefSpec::Runner.new}

  it 'includes build-essentials' do
    chef_run.converge(described_recipe)

    expect(chef_run).to include_recipe('build-essential')
  end

  it 'installs dependencies' do
    chef_run.node.set['cv']['dependencies'] = %w{ foo bar }
    chef_run.converge(described_recipe)

    expect(chef_run).to install_package('foo')
    expect(chef_run).to install_package('bar')
  end

  it 'downloads the cv tarball' do
    chef_run.node.set['cv']['url'] = "http://example.com/cv/v0.4.1.tar.gz"
    chef_run.converge(described_recipe)

    expect(chef_run).to create_remote_file('/var/chef/cache/cv-0.4.1.tar.gz').
      with(source: "http://example.com/cv/v0.4.1.tar.gz")
  end

  it 'builds the software' do
    chef_run.converge(described_recipe)

    expect(chef_run).to run_bash("build cv").with(
      cwd: Chef::Config[:file_cache_path],
      action: [:run]
    )
  end
end
