#!/usr/bin/env python3

from email.header import decode_header
import sys
import base64

base64_encode = sys.argv[1]

raw = base64.b64decode(base64_encode).decode()

decoded = decode_header(raw)
if len(decoded) < 2:
    (tmp, _) = decoded[0]
    decoded = tmp[tmp.find(':')+2:]
elif len(decoded) == 2:
    (s, t) = decoded[1]
    decoded = s.decode(t)

sys.stdout.write(decoded.strip())
