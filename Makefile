.PHONY: dist

dist:
	@npm run build
	@rsync -auvz -e ssh --rsync-path='sudo rsync' dist/ pi@192.168.1.20:/var/www/html/
