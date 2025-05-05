.PHONY: install dev build check format lint

install:
	bun install

dev:
	bun run dev

build:
	bun run build

check:
	bun run check

format:
	bun run format

lint:
	bun run lint
