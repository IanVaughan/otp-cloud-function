
describe  'OTP Functions' do
  include FunctionsFramework::Testing

  describe 'Send OTP', redis: true do
    let(:phone_number) { "+2347012345678" }
    let(:body) { { phone_number: phone_number }.to_json }
    let(:headers) { ["Content-Type: application/json"] }

    it 'should send OTP successfully' do
      load_temporary "app.rb" do
        request = make_post_request "/otp", body, headers

        response = call_http "otp", request
        expect(response.status).to eq 200
        expect(response.content_type).to eq("application/json")

        parsed_response = JSON.parse(response.body.join)
        expect(parsed_response['status']).to eq true
        expect(parsed_response['message']).to eq 'OTP sent successfully'
      end
    end
  end
end