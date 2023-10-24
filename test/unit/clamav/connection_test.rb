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

describe "ClamAV::Connection" do
  let(:client)  { ClamAV::Client.new }
  let(:wrapper) { ClamAV::Wrappers::NewLineWrapper.new }
  let(:socket_mock)  do
    mock = Minitest::Mock.new
    mock.expect(:!, false)
  end

  it "requires a client, a socket and a wrapper" do
    assert_raises(ArgumentError) { ClamAV::Connection.new }
    assert_raises(ArgumentError) { ClamAV::Connection.new(socket: socket_mock, wrapper: wrapper) }
    assert_raises(ArgumentError) { ClamAV::Connection.new(client: client, wrapper: wrapper) }
    assert_raises(ArgumentError) { ClamAV::Connection.new(client: client, socket: socket_mock) }
  end

  it "can be constructed with a client, a socket and wrapper class" do
    ClamAV::Connection.new(client: client, socket: socket_mock, wrapper: wrapper)
  end

  it "support raw writes" do
    socket_mock.expect(:write, nil, ["foo"])

    conn = ClamAV::Connection.new(client: client, socket: socket_mock, wrapper: wrapper)
    conn.raw_write("foo")

    socket_mock.verify
  end
end
