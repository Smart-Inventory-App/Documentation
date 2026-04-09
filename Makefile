ORG_SOURCE := plantilla.org
OUTPUT_HTML := docs/index.html
EXPORT_HTML := $(basename $(ORG_SOURCE)).html

EMACS ?= emacs

.PHONY: docs clean check-emacs validate-html print-source

docs: print-source check-emacs $(OUTPUT_HTML) validate-html

print-source:
	@echo "Usando ORG_SOURCE=$(ORG_SOURCE)"
	@if [ "$(ORG_SOURCE)" = "plantilla.org" ] && [ -f otro_proyecto/plantilla.org ]; then \
		echo "Aviso: tambien existe otro_proyecto/plantilla.org y NO se usa para el deploy."; \
	fi

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
			--eval "(org-html-export-to-html nil nil nil nil nil)"; \
		cp $(EXPORT_HTML) $(OUTPUT_HTML); \
		rm -f $(EXPORT_HTML); \
	else \
		echo "Saltando build local (sin emacs)."; \
		echo "Tu deploy automatico lo va a generar en CI."; \
	fi

clean:
	@rm -f $(OUTPUT_HTML) $(EXPORT_HTML)

validate-html:
	@test -f $(OUTPUT_HTML)
	@grep -qi "<html" $(OUTPUT_HTML) || { echo "Error: docs/index.html no es un HTML completo."; exit 1; }
	@grep -qi "<head" $(OUTPUT_HTML) || { echo "Error: docs/index.html no contiene <head>."; exit 1; }
