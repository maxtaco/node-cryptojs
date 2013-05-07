
CRYPTO_JS_VERSION=3.1.2

CRYPTO_SRC=deps/crypto-js/src

all: default
deps: deps-crypto-js

clean:
	rm -rf build

depclean:
	rm -rf deps

deps-crypto-js: $(CRYPTO_SRC)/core.js

$(CRYPTO_SRC)/core.js:
	mkdir -p deps
	cd deps ; \
	if [ -d crypto-js ] ; then \
		(cd crypto-js && svn up); \
	else \
		svn checkout http://crypto-js.googlecode.com/svn/tags/$(CRYPTO_JS_VERSION) crypto-js ; \
	fi

build/js/crypto.js: \
	$(CRYPTO_SRC)/core.js \
	$(CRYPTO_SRC)/x64-core.js \
	$(CRYPTO_SRC)/enc-base64.js \
	$(CRYPTO_SRC)/hmac.js \
	$(CRYPTO_SRC)/sha1.js \
	$(CRYPTO_SRC)/sha256.js \
	$(CRYPTO_SRC)/sha512.js \
	$(CRYPTO_SRC)/md5.js \
	$(CRYPTO_SRC)/evpkdf.js \
	$(CRYPTO_SRC)/cipher-core.js \
	$(CRYPTO_SRC)/aes.js \
	$(CRYPTO_SRC)/pbkdf2.js
	mkdir -p `dirname $@`
	cat $^ > $@

index.js : build/js/crypto.js
	cat $^ > $@
	echo "exports.CryptoJS = CryptoJS;" >> $@

default: index.js
distclean : depclean clean


.PHONY: clean depclean test distclean
