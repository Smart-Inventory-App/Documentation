ORG_SOURCE := plantilla.org
OUTPUT_HTML := docs/index.html
EXPORT_HTML := $(basename $(ORG_SOURCE)).html

EMACS ?= emacs

.PHONY: docs clean check-emacs

docs: check-emacs $(OUTPUT_HTML)

check-emacs:
	@if command -v $(EMACS) >/dev/null 2>&1; then \
		exit 0; \
	fi; \
	if [ "$$GITHUB_ACTIONS" = "true" ]; then \
		echo "Error: '$(EMACS)' no esta disponible en CI."; \
		exit 127; \
	fi; \
	echo "Aviso: '$(EMACS)' no esta instalado localmente."; \
	echo "No hace falta instalar nada: en push a main, GitHub Actions genera docs/index.html automaticamente.";

$(OUTPUT_HTML): $(ORG_SOURCE)
	@mkdir -p docs
	@if command -v $(EMACS) >/dev/null 2>&1; then \
		$(EMACS) --batch -Q \
			--eval "(require 'org)" \
			--eval "(require 'ox-html)" \
			--eval "(find-file \"$(ORG_SOURCE)\")" \
			--eval "(org-html-export-to-html nil nil nil t nil)"; \
		cp $(EXPORT_HTML) $(OUTPUT_HTML); \
		rm -f $(EXPORT_HTML); \
	else \
		echo "Saltando build local (sin emacs)."; \
		echo "Tu deploy automatico lo va a generar en CI."; \
	fi

clean:
	@rm -f $(OUTPUT_HTML) $(EXPORT_HTML)
