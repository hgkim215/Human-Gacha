.PHONY: get format format-check analyze test check

get:
	flutter pub get

format:
	dart format .

format-check:
	dart format --set-exit-if-changed .

analyze:
	flutter analyze

test:
	flutter test

check: format-check analyze test
