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

require 'clamav/wrapper'

module ClamAV
  module Wrappers
    class NullTerminationWrapper < ::ClamAV::Wrapper
      def wrap_request(request)
        "z#{request}\0"
      end

      def read_response(socket)
        buff = ""
        while (char = socket.getc) != "\0"
          buff << char
        end
        buff
      end
    end
  end
end
