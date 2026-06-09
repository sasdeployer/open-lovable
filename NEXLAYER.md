# Nexlayer — open-lovable

<!-- nexlayer:meta version=1 analyzed=2026-06-09T02:55:07Z repo=https://github.com/sasdeployer/open-lovable branch=main -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
Open Lovable is an AI-powered platform that allows users to build React applications instantly through chat, utilizing web scraping via Firecrawl and dynamic code execution sandboxes provided by Vercel or E2B.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Next.js | framework | 15.x | package.json, next.config.ts |
| TypeScript | language | 5.x | tsconfig.json |
| Tailwind CSS | framework | 3.x | tailwind.config.ts |
| Node.js | language | 22 | package.json |
| pnpm | tool | 9.x | pnpm-lock.yaml |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- app/ — Next.js App Router pages and server actions
- components/ — UI components using Radix UI and Tailwind
- lib/ — Shared utility functions and API clients
- packages/create-open-lovable — CLI tool for bootstrapping projects
- public/ — Static assets
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- Firecrawl API (FIRECRAWL_API_KEY)
- Vercel Sandbox/OIDC (VERCEL_OIDC_TOKEN)
- E2B Sandbox (E2B_API_KEY)
- AI Providers (ANTHROPIC_API_KEY, OPENAI_API_KEY, GEMINI_API_KEY, GROQ_API_KEY)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 20
- pnpm >= 9

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
FIRECRAWL_API_KEY=your_firecrawl_api_key
SANDBOX_PROVIDER=vercel
VERCEL_OIDC_TOKEN=your_token
ANTHROPIC_API_KEY=your_key
OPENAI_API_KEY=your_key
```

### Steps

1. `pnpm install` — Install project dependencies
2. `cp .env.example .env.local` — Setup environment variables
3. `pnpm dev` — Start development server with Turbopack on http://localhost:3000

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### nexlayer.yaml

```yaml
application:
  name: fine-jade-open-lovable
  pods:
    - name: app
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 3000
      vars: {}
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| web | mirror.gcr.io/library/node:22-alpine | 3000 | web |

### Inter-pod environment variables

- `web` pod: `FIRECRAWL_API_KEY=${FIRECRAWL_API_KEY}`
- `web` pod: `SANDBOX_PROVIDER=${SANDBOX_PROVIDER}`
- `web` pod: `VERCEL_OIDC_TOKEN=${VERCEL_OIDC_TOKEN}`
- `web` pod: `ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}`
- `web` pod: `OPENAI_API_KEY=${OPENAI_API_KEY}`

### Deployment notes

- The application is a Next.js full-stack app and does not require a dedicated internal database pod based on provided source files; it relies on external API-based sandboxes (Vercel/E2B) and LLM providers.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-09T03:00:25Z  
**Live URL:** https://zen-antelope-fine-jade-open-lovable.cloud.nexlayer.ai  
**Runtime:** node · **Port:** 3000  
**Deploy branch:** main  

```yaml
application:
  name: fine-jade-open-lovable
  pods:
    - name: app
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 3000
      vars: {}
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-09T02:55:07Z | analyzed | initial repo analysis |
| 2026-06-09T03:00:25Z | success | deployed https://zen-antelope-fine-jade-open-lovable.cloud.nexlayer.ai |
<!-- nexlayer:end -->
