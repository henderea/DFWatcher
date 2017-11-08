#!/usr/bin/env ruby

require 'net/http'
require 'rubygems'
require 'aws-sdk'

data          = nil
net           = Net::HTTP.new('www.dragonfable.com')
PATH          = '/df-designnotes.asp'
START_PATTERN = '<!-- End Header -->'
END_PATTERN   = '<!-- Footer -->'
SLEEP_TIME    = 60*60

ses = AWS::SimpleEmailService.new(
    :access_key_id     => 'AKIAJ5GW6ZXHBW74UGWQ',
    :secret_access_key => '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'
)

while true
  prev_data = data
  resp, _   = net.get(PATH)
  body      = resp.body
  ind1      = body.index(START_PATTERN) + START_PATTERN.length
  ind2      = body.index(END_PATTERN, ind1)
  data      = body[ind1...ind2].strip
  unless data.nil? || prev_data.nil?
    if data != prev_data
      ses.send_email(
          :subject   => 'DF DNs changed',
          :from      => 'henderea@gmail.com',
          :to        => 'henderea@gmail.com',
          :body_text => 'DF Design Notes Changed: http://www.dragonfable.com/df-designnotes.asp',
          :body_html => '<h1>DF Design Notes Changed</h1><a href="http://www.dragonfable.com/df-designnotes.asp" style="color:#0000FF;">http://www.dragonfable.com/df-designnotes.asp</a>')
    end
  end
  sleep(SLEEP_TIME)
end