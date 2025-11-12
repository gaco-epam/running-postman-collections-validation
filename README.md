# Newman Collection Runner

Automated Postman collection execution using Newman in GitHub Actions.

## Process

1. **GitHub Actions** detects push or PR
2. **Installs Newman** on the runner
3. **Executes collection** from Postman API
4. **Applies environment** with configured variables
5. **Reports results** in the workflow

## Configuration

### 1. GitHub Secrets
Configure these secrets in your repository:
- Settings → Secrets and variables → Actions
- `POSTMAN_API_KEY` - Your Postman API key
- `COLLECTION_ID` - Your Postman collection ID

### 2. Triggers
The pipeline runs on:
- Push to `main` or `develop`
- Pull requests to `main`
- Manually from Actions tab

## Local Execution

```bash
export POSTMAN_API_KEY="your-api-key"
COLLECTION_ID="42412586-34a224bb-8e50-4d72-a578-69263e0e2318"
newman run "https://api.getpostman.com/collections/${COLLECTION_ID}?apikey=${POSTMAN_API_KEY}" -e environment.json
```

## Files

- `environment.json` - Environment variables for tests (baseUrl, etc.)
- `.github/workflows/newman-tests.yml` - CI/CD pipeline

## Colección

- **ID**: `42412586-34a224bb-8e50-4d72-a578-69263e0e2318`
- **Nombre**: JSONPLACEHOLDER
- **Tests**: Pruebas sobre API REST de JSONPlaceholder
