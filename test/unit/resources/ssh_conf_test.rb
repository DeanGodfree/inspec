# encoding: utf-8
# author: Christoph Hartmann
# author: Dominik Richter

require 'helper'
require 'inspec/resource'

describe 'Inspec::Resources::SshConf' do

  describe 'ssh_config' do
    it 'check ssh config parsing' do
      resource = load_resource('ssh_config')
      _(resource.Host).must_equal '*'
      _(resource.Tunnel).must_be_nil
      _(resource.SendEnv).must_equal 'LANG LC_*'
      _(resource.HashKnownHosts).must_equal 'yes'
    end

    it 'is case insensitive' do
      resource = load_resource('ssh_config')
      _(resource.gssapiauthentication).must_equal 'no'
      _(resource.GSSAPIAuthentication).must_equal 'no'
    end
  end

  describe 'sshd_config' do
    it 'check protocol version' do
      resource = load_resource('sshd_config')
      _(resource.Port).must_equal '22'
      _(resource.UsePAM).must_equal 'yes'
      _(resource.ListenAddress).must_be_nil
      _(resource.HostKey).must_equal [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_dsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
      ]
    end
  end
end
