# clamav-client - ClamAV client
# Copyright (C) 2014 Franck Verrot <franck@verrot.fr>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'test_helper'

describe "ClamAV::Client" do
  describe "connect!" do
    let(:conn_mock) { Minitest::Mock.new }
    let(:client) { ClamAV::Client.new }

    it "opens the connection" do
      conn_mock.expect(:establish_connection, nil)

      client.connect!(conn_mock)

      conn_mock.verify
    end

    it 'raises an custom error if connection times out' do
      conn_mock.expect(:establish_connection, nil) do
        raise Errno::ETIMEDOUT
      end

      assert_raises(ClamAV::Client::ConnectTimeoutError) { client.connect!(conn_mock) }
    end

    it 'raises an custom error if something goes wrong' do
      conn_mock.expect(:establish_connection, nil) do
        raise SocketError
      end

      assert_raises(ClamAV::Client::ConnectionError) { client.connect!(conn_mock) }
    end
  end

  describe "tcp?" do
    it "returns true when config is tcp" do
      assert client = ClamAV::Client.new(tcp_host: 'example', tcp_port: 3310).tcp?
    end

    it "returns false when config is not tcp" do
      refute client = ClamAV::Client.new.tcp?
      refute client = ClamAV::Client.new(unix_socket: '/some.sock').tcp?
    end
  end
end
