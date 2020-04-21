BUCK=Tools/buck
root_buck = $(shell $(BUCK) root)
buck_out = $(root_buck)/buck-out

build:
	$(BUCK) build //App:GalleryApp --config custom.root_buck="$(root_buck)"

debug:
	$(BUCK) install //App:GalleryApp --config custom.root_buck="$(root_buck)" --run --simulator-name 'iPhone 8'

test:
	@rm -f $(buck_out)/tmp/*.profraw
	@rm -f $(buck_out)/gen/*.profdata
	$(BUCK) test //App:GalleryAppCITests --test-runner-env XCTOOL_TEST_ENV_LLVM_PROFILE_FILE="$(buck_out)/tmp/code-%p.profraw%15x" \
		--config custom.other_cflags="\$$(config custom.code_coverage_cflags)" \
		--config custom.other_cxxflags="\$$(config custom.code_coverage_cxxflags)" \
		--config custom.other_ldflags="\$$(config custom.code_coverage_ldflags)" \
		--config custom.other_swift_compiler_flags="\$$(config custom.code_coverage_swift_compiler_flags)" \
		--config custom.root_buck="$(root_buck)"
	xcrun llvm-profdata merge -sparse "$(buck_out)/tmp/code-"*.profraw -o "$(buck_out)/gen/Coverage.profdata"
	xcrun llvm-cov report "$(buck_out)/gen/App/GalleryBin#iphonesimulator-x86_64" -instr-profile "$(buck_out)/gen/Coverage.profdata" -ignore-filename-regex "Pods|Carthage|buck-out"

removeprojects:
	find App -name '*.xcodeproj' -print0 | xargs -0 rm -rf
	find App -name '*.xcworkspace' -print0 | xargs -0 rm -rf
	find Modules -name '*.xcodeproj' -print0 | xargs -0 rm -rf


clean: kill removeprojects
	buck clean
	rm -rf buck-out

kill:
	killall Xcode || true
	killall Simulator || true

project: kill removeprojects
	$(BUCK) project //App:GalleryAppWorkspace --config custom.root_buck="$(root_buck)"
	rm -rf App/App.xcodeproj/xcshareddata/xcschemes/App.xcscheme
	cp IDETemplateMacros.plist App/App.xcodeproj/xcshareddata/
	cp IDETemplateMacros.plist Modules/Core/Core.xcodeproj/xcshareddata/
	cp IDETemplateMacros.plist Modules/RootUI/RootUI.xcodeproj/xcshareddata/
	cp IDETemplateMacros.plist Modules/Gallery/Gallery.xcodeproj/xcshareddata/
	cp IDETemplateMacros.plist Modules/Network/Network.xcodeproj/xcshareddata/

open:
	if [ -a App/GalleryApp.xcworkspace ] ; then open App/GalleryApp.xcworkspace; fi

graph:
	buck query "deps(//App:GalleryBin)" --config custom.root_buck="$(root_buck)" --dot > query-result.dot
	dot -Tpng query-result.dot -o graph.png

targets:
	$(BUCK) targets //... --config custom.root_buck="$(root_buck)"

server:
		cd CacheServer/ ; grunt
