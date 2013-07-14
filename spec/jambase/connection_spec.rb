require 'spec_helper.rb'

describe Jambase::Connection, vcr: true do

  let(:conn){ api.connection }
  let(:bad_conn){ Jambase::Connection.new('fake_api_key') }

  it 'connects' do
    response = conn.get('events', id: 0)
    response['Id'].should eq(0)
  end

  context 'exceptions raised' do
    it 'when using bad credentials' do
      expect{ bad_conn.get('events', id: 0) }
      .to raise_exception Jambase::NotAuthenticated
    end

    it 'when nil key passed' do
      expect{ Jambase::Connection.new(nil) }
      .to raise_exception Jambase::NilApiKey
    end
  end

  describe '#authenticated?' do
    it 'returns true when credentials are valid' do
      conn.authenticated?.should be_true
    end
    it 'returns false when credentials are valid' do
      bad_conn.authenticated?.should be_false
    end
  end

end
