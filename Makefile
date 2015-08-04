ROKU_DEV_TARGET = 192.168.129.242

all: roku-framework

roku-framework: source/framework/main/main.brs
	zip -9 -r out/roku-framework.zip . -x \*~ -x Makefile -x \*.zip -x .git/* -x .git

clean: rm roku-framework.zip

install: roku-framework
	@echo Installing out/roku-framework.zip to $(ROKU_DEV_TARGET)
	@curl -s -S -F "mysubmit=Install" -F "archive=@out/roku-framework.zip" -F "passwd=" http://$(ROKU_DEV_TARGET)/plugin_install | grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["