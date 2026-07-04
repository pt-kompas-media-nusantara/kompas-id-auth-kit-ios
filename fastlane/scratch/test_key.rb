require 'openssl'
require 'base64'

key_base64 = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JR1RBZ0VBTUJNR0J5cUdTTTQ5QWdFR0NDcUdTTTQ5QXdFSEJIa3dkd0lCQVFRZ3JhbnFpdHZZYkRPWE1RQlEKcFQxNjRUMkdRY0FQK0R6cXozdXhsOHZZSXJlZ0NnWUlLb1pJemowREFRZWhSQU5DQUFTVWZLZGNtZUw2anFmVwpDRllxMWhuMGIzZUZEQmJKR09BSHZCTnAzWm9QZDdVeFloRDM0aU5PTW1aWHJyd0RzcFFYREtDbVljcnVJSEJVCm1rUHlqVHlJCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0="
decoded = Base64.decode64(key_base64)
puts "Decoded PEM length: #{decoded.length}"

begin
  pkey = OpenSSL::PKey.read("")
  puts "PKey class: #{pkey.class}"
rescue => e
  puts "Error reading empty key: #{e.class} - #{e.message}"
end

