require 'spec_helper'
require 'tmpdir'

RSpec.describe YAPAAS::Machine do

  let(:tmpdir) { Dir.mktmpdir }
  subject { described_class.new(tmpdir) }

  {
    server_key: 'server_key.pem',
    config_file: 'config.json',
    public_key: 'id_rsa.pub',
    server_cert: 'server.pem',
    private_key: 'id_rsa',
    cert: 'cert.pem',
    key: 'key.pem',
    ca: 'ca.pem',
  }.each do |m, f|
    describe "##{m}" do
      it "is a readable connection to #{f}" do
        expect(subject.send(m)).to respond_to(:read)
      end
    end
  end

  describe '#config' do
    before do
      File.open(File.join(tmpdir, 'config.json'), 'w') do |f|
        f.print('{"foo": "bar"}')
      end
    end
    it 'loads the config as JSON' do
      expect(subject.config).to eql('foo' => 'bar')
    end
  end

  describe '::driver_name' do
    it 'is "Docker Machine"' do
      expect(described_class.driver_name).to eql('Docker Machine')
    end
  end

  describe '::path' do
    it 'is the general docker machine path' do
      expected = File.join(ENV['HOME'], '.docker/machine/machines')
      expect(described_class.path.to_s).to eql(expected)
    end
  end

  describe '::all' do
    it 'contains all folders in ~/.docker/machine/machines' do
      Pathname.new(tmpdir).join('m1').mkdir
      Pathname.new(tmpdir).join('m2').mkdir
      Pathname.new(tmpdir).join('m3').mkdir
      allow(described_class).to receive(:path).and_return(Pathname.new(tmpdir))
      expect(described_class.all.map(&:name)).to eq(%w(m1 m2 m3))
    end
  end
end
