# Documentation

Informe preparado para publicarse con Cloudflare.

## Como funciona

Este repo publica la documentacion automaticamente en Cloudflare Pages a partir de un archivo fuente en Org Mode.

Flujo:

1. Editas el contenido en [plantilla.org](plantilla.org).
2. El comando `make docs` genera [index.html](index.html) en la raiz y una carpeta [assets](assets).
3. El workflow [cloudflare-pages.yml](.github/workflows/cloudflare-pages.yml) ejecuta ese build en cada push a `main`.
4. Cloudflare Pages publica [index.html](index.html), [assets](assets) y [docs](docs).

## Publicación

- El contenido se publica desde [index.html](index.html), [assets](assets) y [docs](docs).
- El despliegue automático está en [.github/workflows/cloudflare-pages.yml](.github/workflows/cloudflare-pages.yml).

## Build local

Para previsualizar antes de pushear:

1. Ejecuta `make docs` desde la raiz del repo.
2. Abre [index.html](index.html) en el navegador.

## Uso

1. Haz cambios en el informe.
2. Sube los cambios a la rama `main`.
3. GitHub Actions desplegará automáticamente a Cloudflare Pages.

## Secrets requeridos

Configura estos secrets en **Settings > Secrets and variables > Actions**:

- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`
- `CLOUDFLARE_PROJECT_NAME`

## Nota

Si GitHub Pages estuvo activo previamente, desactívalo en la configuración del repositorio en **Settings > Pages**.