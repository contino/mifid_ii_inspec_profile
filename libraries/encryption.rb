class Encryption < Inspec.resource(1)
  name 'encryption'

  desc "
  Encrypted File Handling
  "

  example "
    describe encrypted_file(filename) do
      its('encrypted') { should eq true }
      its('key_bits')  { should >= 2048 }
    end
  "

  def initialize(filename)
    print "Loading "+filename+"\n"
    @filename = filename
    @file = inspec.file(@filename)
    @params = {}
    return skip_resource "Can't find file \"#{@filename}\"" if !@file.file?

    begin
      fileDetails = inspec.command("file "+@filename).stdout.strip
      if /encrypted/.match(fileDetails).length > 0
        @params['encrypted'] = true
      else
        @params['encrypted'] = false
      end

      @params['key_bits'] = /.*encrypted session key - keyid:.* (\d*)b ./.match(fileDetails)[1].to_i
    rescue Exception
      return skip_resource "#{@filename}: #{$!}"
    end
  end

  def encrypted
    return true
  end

  def exists?
    @file.file?
  end

  def method_missing(name)
    return @params[name.to_s]
  end

end
