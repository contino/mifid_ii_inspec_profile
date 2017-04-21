# encoding: utf-8
#
# Copyright 2017, Emre Erkunt
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
#
# author: Emre Erkunt
# author: Daniel Hurst

title 'File integrity checks'

control 'integrity-01' do
  impact 1.0
  title 'Check for .rhosts and .netrc file'
  desc 'Find .rhosts and .netrc files - CIS Benchmark 9.2.9-10'

  output = command('find / \( -iname .rhosts -o -iname .netrc \) -print 2>/dev/null | grep -v \'^find:\'')
  out = output.stdout.split(/\r?\n/)
  describe out do
    it { should be_empty }
  end
end