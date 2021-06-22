#!/usr/bin/env python3

from email.header import decode_header
import sys
import base64
import unittest
import re


def decode(base64_encode: str) -> str:
#    with open('/tmp/.mime_decoder.py.base64_dump.txt', 'w') as f:
#        f.write(base64_encode)
#        f.write('\n')
#        f.flush()

    raw = base64.b64decode(base64_encode).decode()

    decoded = decode_header(raw)
    #print(decoded, file=sys.stderr)

    result = ''
    for dec in decoded:
        if dec[1] is None:
            (s, t) = dec
            if isinstance(s, str):
                result += s
            else:
                result += s.decode()
        else:
            (s, t) = dec
            result += s.decode(t.upper())

    value = result[result.find(':')+2:]

    # Remove new line
    value = re.sub(r'''\r?\n''', '', value)

    return value.strip()


def main():
    base64 = sys.argv[1]

    d = decode(base64_encode=base64)

    sys.stdout.write(d)


if __name__ == '__main__':
    main()


class TestDecode(unittest.TestCase):
    def test_10_subject(self):
        base64 = ('U3ViamVjdDogW1Byb2plY3RzXVtDUkRdW0xCRyBTdXBwb3J0XSBMQkcgU3VwcG9y'
                  'dCBQcm9qZWN0IGlzIGxvb2tpbmcgZm9yDQogYW1hemluZyB0ZWFtIG1lbWJlcnMh')
        result = ('[Projects][CRD][LBG Support] LBG Support Project is looking for'
                  ' amazing team members!')
        self.assertEqual(result, decode(base64))

    def test_20_subject(self):
        base64 = ('U3ViamVjdDogPT9VVEYtOD9RPz01QkNSRD01RD01QkNhbGw9NUQ9NUJBdXR1bW5f'
                  'R0FfPUUyPTgwPTk4MjE9NURfQXBwbHlfdG9fYmVfYV9tZW1iZXJfb2Y/PQ0KCT0/'
                  'VVRGLTg/UT9fdGhlX0F1dHVtbl9HQV9GUl9UZWFtXz03Q19ETF90b19hcHBseT0z'
                  'QV8wMj0yRjA2Xz00MF8yMz0zQTAwX0NFU1Q/PQ==')
        result = ('[CRD][Call][Autumn GA ‘21] Apply to be a member of the Autumn GA'
                  ' FR Team | DL to apply: 02/06 @ 23:00 CEST')
        self.assertEqual(result, decode(base64))

    def test_30_from(self):
        base64 = ('RnJvbTogPT9VVEYtOD9CP1RIVmp3NjFoSUV6RHMzQmxlaUJrWlNCVWRYSnBjMjhn'
                  'VU1PcGNtVjY/PSA8bHVjaWEubG9wZXp0dXJpc29AYmVzdC1ldS5vcmc+')
        result = ('Lucía López de Turiso Pérez <lucia.lopezturiso@best-eu.org>')
        self.assertEqual(result, decode(base64))


