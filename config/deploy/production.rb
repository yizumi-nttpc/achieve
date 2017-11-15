server '13.230.79.25', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/yizumi/.ssh/id_rsa.pub'
