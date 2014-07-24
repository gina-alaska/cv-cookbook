require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "CV" do

  it 'installs cv' do
    expect(file('/usr/local/bin/cv')).to be_a_file
    expect(file('/usr/local/bin/cv')).to be_mode 755
    expect(file('/usr/local/bin/cv')).to be_owned_by 'root'
  end

end
