require 'http_signatures'
require 'net/http'
require 'time'

def print_request(request, context = '')
  puts ''
  puts "Message #{context}:"
  puts "  Headers:"
  request.each_header {|key,value| puts "    #{key} = #{value}" }
  puts "  content_length: #{request.content_length}" 
end

def verify_sig request
  puts "\n\n"
  puts "Signature verified: #{$context.verifier.valid?(request)}"
end

# Creating signing content
$context = HttpSignatures::Context.new(
  keys: {'407c0a27-4f93-4654-9ae4-86b7a2b258b4' => 'abcasdadaskoklklkalsdasd'},
  algorithm: 'hmac-sha256',
  headers: ['Date', 'digest', 'Content-Length'],
)

# Create message
message = Net::HTTP::Get.new(
  '/path?query=12aaaa3',
  'Date' => 'Sun Sep 28 23:19:56 2014 UTC',
  'digest' => 'SHA-256=[B@63c8e097',
  'content-length' => '0'
)

print_request message

sig = $context.signer.sign(message);

print_request message, "after signing"

verify_sig message

# Tamper with the message
puts "\n\nTampering with content length"
message.content_length=1212

print_request message, "after tampering"

verify_sig message
