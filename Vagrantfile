# --------------------------------------------------------
# Modified from https://bitbucket.org/logicblox/lb-vagrant
# --------------------------------------------------------

# Sanity checks: is a logicblox tarball present?
tarballs = Dir.glob("logicblox-*.tar.gz")
if tarballs.length == 0 then
    puts "No logicblox tarball found in current directory, please make sure you copy or hardlink a logicblox-*.tar.gz release tarball into the current directory."
    puts "You can download release tarballs from https://download.logicblox.com"
    Kernel.exit(1)
elsif File.symlink?(tarballs[0]) then
    puts "You cannot symlink a logicblox tarball, it has to be a copy or hardlink, you can create a hardlink using 'ln' without using the '-s' switch."
    Kernel.exit(2)
end

# Vagrant configuration itself
Vagrant.configure("2") do |config|
  # This VM is based on Ubuntu 12.04 64-bit
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Give the VM 2GB of memory
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Install the Java JRE 7 and nginx (add more packages as desired)
  # Unpack the logicblox tarball in /opt and symlink /opt/logicblox to the extracted
  # directory
  config.vm.provision :shell, inline: <<eos
    set -e
    # Checking if not already installed before
    if [ -e /etc/profile.d/logicblox.sh ]; then
        exit 0
    fi

    echo "Installing some required packages in the VM"
    apt-get update -qq
    apt-get install -qq -y openjdk-7-jre vim-tiny nginx make

    echo "Extracting the LogicBlox tarball"
    mkdir -p /opt
    cd /opt
    tar xzf /vagrant/logicblox-*.tar.gz
    ln -s logicblox-* logicblox
    echo "source /opt/logicblox/etc/profile.d/logicblox.sh\ncd /vagrant" > /etc/profile.d/logicblox.sh

    echo "Setting up some lb_deployment subdirectories in your project folder"
    mkdir -p /vagrant/lb_deployment/{config,logs}
    mkdir -p /home/vagrant/lb_deployment && chown vagrant:vagrant /home/vagrant/lb_deployment
    ln -s /vagrant/lb_deployment/{config,logs} /home/vagrant/lb_deployment/

    echo "Setting up LB auto start and starting LB itself"
    source /opt/logicblox/etc/profile.d/logicblox.sh
    if [ "" != "\$(which lb-services)" ]; then
        sed -i 's/exit 0/su - vagrant -c "lb-services start"\\n\\nexit 0/' /etc/rc.local
        su - vagrant -c "lb-services start"
    else
        sed -i 's/exit 0/su - vagrant -c "lb services start"\\n\\nexit 0/' /etc/rc.local
        su - vagrant -c "lb services start"
    fi
eos

  # Map port 8080 in the VM to the host's port 8080
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  # And 8086 to 8086
  config.vm.network "forwarded_port", guest: 8086, host: 8086, auto_correct: true

  # Alternatively you can use a static private IP, for this comment out the line above
  # and uncomment the following line
  #config.vm.network "private_network", ip: "192.168.13.22"
end
