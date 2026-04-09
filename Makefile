ORG_SOURCE := plantilla.org
OUTPUT_HTML := docs/index.html

EMACS := emacs

.PHONY: docs clean

docs: $(OUTPUT_HTML)

$(OUTPUT_HTML): $(ORG_SOURCE)
	@mkdir -p docs
	@$(EMACS) --batch -Q \
		--eval "(require 'org)" \
		--eval "(require 'ox-html)" \
		--eval "(find-file \"$(ORG_SOURCE)\")" \
		--eval "(org-html-export-to-html nil nil nil t nil)"
	@cp plantilla.html $(OUTPUT_HTML)
	@rm -f plantilla.html

clean:
	@rm -f $(OUTPUT_HTML) plantilla.html
