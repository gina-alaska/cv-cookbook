def cv_version
  require 'uri'
  require 'pathname'

  Pathname.new(URI.parse(node['cv']['url']).path).basename.to_s.gsub(/^v/,'')
end


def cv_name
  "cv-#{cv_version}"
end

def cv_build_dir
  ::File.basename(cv_name, ".tar.gz")
end
