default['cv']['url'] = "https://github.com/Xfennec/cv/archive/v0.4.1.tar.gz"

default['cv']['dependencies'] = case node['platform_family']
when 'rhel'
  ['tar','ncurses-devel']
when 'debian'
  ['tar','ncurses-dev']
else
  []
end
