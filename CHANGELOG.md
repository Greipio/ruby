# Changelog

## 2.0.0 — 2026-03-19

### Breaking

- **Greip API v2** endpoints and `https://v2.greipapi.com` base URL.
- **Authorization: Bearer** token; v2 success envelope handling.
- REST path changes (lookup, score, country, ASN, IBAN, email, phone, profanity POST, payments POST).
- Returned hashes use v2 keys (`ip` → nested `address`, `geo.country_code`, `is_valid`, `risk_level`, ASN `number`).

### Changed

- Minitest suite updated for live v2 responses.
