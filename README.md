A quick look at Joyents http signature spec for sigining http requests.

This example uses the ruby gem and simply:

1. Creates a message
2. Signs it
3. Verfies that the message was signed ok
4. Tampers with the message
5. Verifies that the signature is not valid anymore



*Links*
https://github.com/joyent/node-http-signature/blob/master/http_signing.md
