#
# Author:: Stuart Preston (<stuart@chef.io>)
# Copyright:: Copyright 2018, Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "chef/json_compat"
require "win32ole"

class Chef
  module Mixin
    module PowershellExec
      # Run a command under PowerShell via a managed (.NET) COM interop API.
      # This implementation requires the managed dll to be registered on the
      # target machine.
      #
      # Requires: .NET Framework 4.0 or higher on the target machine.
      #
      # @param script [String] script to run
      # @return [Hash] output
      def powershell_exec(*command_args)
        script = command_args.first
        ps = WIN32OLE.new("Chef.PowerShell")
        outcome = ps.ExecuteScript(script)

        Chef::JSONCompat.parse(outcome)
      end
    end
  end
end
