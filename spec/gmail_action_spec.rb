describe Fastlane::Actions::GmailAction do
  before do
    @username = 'user_name'
    @password = '1234'
    @to = 'recipients'
    @cc = 'cc_recipients'
    @subject = 'New Build!'
    @body = 'body text'
    @options = {
      address:              'smtp.gmail.com',
      port:                 587,
      user_name:            @username,
      password:             @password,
      authentication:       'plain',
      enable_starttls_auto: true
    }
    @params = {
      username: @username,
      password: @password,
      to:       @to,
      cc:       @cc,
      subject:  @subject,
      body:     @body
    }
  end

  describe 'Gmail' do
    it 'send mail' do
      expect(Mail::Configuration.instance).to receive(:delivery_method) do |method, settings|
        expect(method).to eql(:smtp)
        expect(settings).to eql(@options)
      end.ordered
      expect(Mail::Configuration.instance).to receive(:delivery_method).and_return(Mail::TestMailer.new(@options)).at_least(:once)

      Fastlane::Actions::GmailAction.run(@params)

      expect(Mail::TestMailer.deliveries.count).to eql(1)
      expect(Mail::TestMailer.deliveries[0].from).to eql([@username])
      expect(Mail::TestMailer.deliveries[0].to).to eql([@to])
      expect(Mail::TestMailer.deliveries[0].cc).to eql([@cc])
      expect(Mail::TestMailer.deliveries[0].subject).to eql(@subject)
      expect(Mail::TestMailer.deliveries[0].body.parts[0].body.raw_source).to eql(@body)
    end
  end

  describe 'Invalid Parameters' do
    it 'raises an error if no username was given' do
      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
          gmail({
            password: '#{@password}',
            to:       '#{@to}',
            cc:       '#{@cc}',
            subject:  '#{@subject}',
            body:     '#{@body}'
          })
        end").runner.execute(:test)
      end.to raise_error "No username"
    end

    it 'raises an error if no recipients was given' do
      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
          gmail({
            username: '#{@username}',
            password: '#{@password}',
            subject:  '#{@subject}',
            body:     '#{@body}'
          })
        end").runner.execute(:test)
      end.to raise_error "No recipients"
    end

    it 'raises an error if no subject was given' do
      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
          gmail({
            username: '#{@username}',
            password: '#{@password}',
            to:       '#{@to}',
            cc:       '#{@cc}',
            body:     '#{@body}'
          })
        end").runner.execute(:test)
      end.to raise_error "No subject of email"
    end

    it 'raises an error if no body was given' do
      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
          gmail({
            username: '#{@username}',
            password: '#{@password}',
            to:       '#{@to}',
            cc:       '#{@cc}',
            subject:  '#{@subject}'
          })
        end").runner.execute(:test)
      end.to raise_error "No body of email"
    end

    it 'no raises an error if no cc was given' do
      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
          gmail({
            username: '#{@username}',
            password: '#{@password}',
            to:       '#{@to}',
            subject:  '#{@subject}',
            body:     '#{@body}'
          })
        end").runner.execute(:test)
      end.not_to raise_error
    end
  end
end
