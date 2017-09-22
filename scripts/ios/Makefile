# Makefile for building and updating the filepicker plugin

CONFIGURATION="Release"
FRAMEWORK_NAME="FSPicker"
LIBS=${FRAMEWORK_NAME} "AFNetworking" "Filestack"
SIMULATOR_LIBRARIES_PATH="build/${CONFIGURATION}-iphonesimulator/"
DEVICE_LIBRARIES_PATH="build/${CONFIGURATION}-iphoneos/"
OUTPUT_LIBRARIES_PATH="../../src/ios/libs/"

default: build

pod: clean
	pod install

build: pod
	cd Pods && xcodebuild -configuration ${CONFIGURATION} -target ${FRAMEWORK_NAME}
	cd Pods && xcodebuild -configuration ${CONFIGURATION} -sdk iphonesimulator11.0 -target ${FRAMEWORK_NAME}
	mkdir ${OUTPUT_LIBRARIES_PATH}
	for LIB in ${LIBS}; do \
		mkdir ${OUTPUT_LIBRARIES_PATH}/$$LIB.framework ; \
		cp -r ${DEVICE_LIBRARIES_PATH}/$$LIB/$$LIB.framework/. ${OUTPUT_LIBRARIES_PATH}/$$LIB.framework/; \
		rm ${OUTPUT_LIBRARIES_PATH}/$$LIB.framework/$$LIB; \
		lipo ${SIMULATOR_LIBRARIES_PATH}/$$LIB/$$LIB.framework/$$LIB ${DEVICE_LIBRARIES_PATH}/$$LIB/$$LIB.framework/$$LIB -create -output ${OUTPUT_LIBRARIES_PATH}/$$LIB.framework/$$LIB; \
	done
clean:
	-rm -rf build
	-rm -rf Pods
	-rm Podfile.lock
	-rm -rf ${OUTPUT_LIBRARIES_PATH}
