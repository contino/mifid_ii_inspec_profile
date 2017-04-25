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

# require_relative '../libraries/encryption.rb'

title 'File encryption checks for *.gpg files in /important/files'

control 'encryption-01' do
  impact 0.9
  title 'Check if the files are encrypted with at least 2048 bit keys'
  desc 'MiFIDD II - Sample Test 02'
  tag 'encryption'
  targetDir = '/important/files'

  output = command('find '+targetDir+' -name "*.gpg"').stdout
  fileList = output.split(/\r?\n/)

  fileList.each do |filename|

    describe encryption(filename) do
      its('encrypted') { should eq true }
      its('key_bits')  { should >= 2048 }
    end

  end

end