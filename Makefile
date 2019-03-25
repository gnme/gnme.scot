.PHONY: dev dev_assets clean

dev:
	hugo serve --disableFastRender

dev_assets:
	npm ci
	npm run dev

clean:
	rm -rf node_modules/ static/css/ static/img/ public/
