# Documentation

Informe preparado para publicarse con Cloudflare.

## Publicación

- El contenido principal está en [docs/informe.html](docs/informe.html).
- El despliegue automático está en [.github/workflows/cloudflare-pages.yml](.github/workflows/cloudflare-pages.yml).

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